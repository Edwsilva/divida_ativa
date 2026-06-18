import { ApiError } from "@/lib/api/api-error";
import type { ApiResponse } from "@/types";

/**
 * Cliente HTTP para consumir as API Routes do Next.js (BFF).
 *
 * - Sempre envia/recebe JSON.
 * - Lança `ApiError` em caso de erro de rede ou resposta `{ success: false }`.
 * - Retorna `data` diretamente em caso de sucesso.
 *
 * @example
 * ```ts
 * const dados = await apiClient<MinhaInterface[]>(endpoints.dividaAtiva.listar);
 * ```
 */
export async function apiClient<T>(
  url: string,
  init: RequestInit = {},
): Promise<T> {
  const response = await fetch(url, {
    ...init,
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
      ...init.headers,
    },
  });

  let json: ApiResponse<T>;

  try {
    json = await response.json();
  } catch {
    throw new ApiError(response.status, "Resposta inválida do servidor.");
  }

  if (!json.success) {
    throw new ApiError(
      json.statusCode ?? response.status,
      json.error ?? "Erro desconhecido.",
    );
  }

  return json.data;
}
