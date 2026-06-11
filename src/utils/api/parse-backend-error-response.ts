import {
  parseBackendPayload,
  type ParseBackendPayloadResult,
} from "@/utils/api/parse-backend-payload";

export interface ParseBackendErrorResponseResult extends ParseBackendPayloadResult {
  errorMessage: string;
}

export async function parseBackendErrorResponse(
  response: Response,
): Promise<ParseBackendErrorResponseResult> {
  const payload = await parseBackendPayload(response);

  return {
    ...payload,
    errorMessage: payload.message || "Erro ao processar resposta do backend",
  };
}
