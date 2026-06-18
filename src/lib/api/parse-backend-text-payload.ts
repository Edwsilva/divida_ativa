import { parseBackendPayload } from "@/lib/api/parse-backend-payload";

export interface ParseBackendTextPayloadResult {
  rawText: string;
  data: string;
}

/**
 * Parseia a resposta do backend como texto puro (text/html, text/plain, etc.).
 *
 * Use em endpoints que retornam strings — mensagens de status, HTML, etc.
 */
export async function parseBackendTextPayload(
  response: Response,
  fallback = "Operação realizada com sucesso",
): Promise<ParseBackendTextPayloadResult> {
  const { rawText, message, isJson } = await parseBackendPayload(response);

  if (isJson) {
    console.warn(
      "[parseBackendTextPayload] Resposta JSON recebida em endpoint esperado como texto. Use parseBackendJsonPayload.",
    );
  }

  return {
    rawText,
    data: message ?? fallback,
  };
}
