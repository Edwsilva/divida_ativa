import { NextResponse } from "next/server";
import { getServerSession } from "@/lib/auth";
import { logServerError } from "@/lib/auth";
import { parseBackendErrorResponse } from "@/lib/api/parse-backend-error-response";
import { parseBackendJsonPayload } from "@/lib/api/parse-backend-json-payload";
import type { ApiErrorResponse, ApiSuccessResponse } from "@/types";

const DEFAULT_API_URL = "http://localhost:8080";

function getApiBaseUrl() {
  return (process.env.API_DIVIDA_ATIVA_URL || DEFAULT_API_URL).replace(
    /\/$/,
    "",
  );
}

async function getAuthorizationHeader() {
  const session = await getServerSession();

  if (!session?.accessToken) {
    return null;
  }

  return `Bearer ${session.accessToken}`;
}

/**
 * Proxy autenticado para o backend de dívida ativa.
 *
 * Injeta automaticamente o Bearer token da sessão atual e normaliza
 * as respostas no padrão `ApiResponse<T>`.
 */
export async function requestDividaAtivaBackend<T>(
  path: string,
  init: RequestInit = {},
) {
  const authorization = await getAuthorizationHeader();

  if (!authorization) {
    return NextResponse.json<ApiErrorResponse>(
      { success: false, error: "Sessão não encontrada", statusCode: 401 },
      { status: 401 },
    );
  }

  try {
    const response = await fetch(`${getApiBaseUrl()}${path}`, {
      ...init,
      cache: "no-store",
      headers: {
        Accept: "application/json",
        Authorization: authorization,
        ...(init.body ? { "Content-Type": "application/json" } : {}),
        ...init.headers,
      },
    });

    if (response.status === 204) {
      return NextResponse.json<ApiSuccessResponse<null>>({
        success: true,
        data: null,
      });
    }

    if (!response.ok) {
      const error = await parseBackendErrorResponse(response);
      return NextResponse.json<ApiErrorResponse>(
        {
          success: false,
          error: error.errorMessage,
          statusCode: response.status,
          backendBody: error.parsed,
        },
        { status: response.status },
      );
    }

    const { data } = await parseBackendJsonPayload<T>(response);
    return NextResponse.json<ApiSuccessResponse<T>>({
      success: true,
      data,
    });
  } catch (error) {
    logServerError("Erro ao chamar API de dívida ativa", error);
    return NextResponse.json<ApiErrorResponse>(
      {
        success: false,
        error: "Serviço de dívida ativa indisponível no momento.",
        statusCode: 503,
      },
      { status: 503 },
    );
  }
}
