import { parseBackendPayload } from "@/lib/api/parse-backend-payload";

export interface ParseBackendJsonPayloadResult<T> {
  rawText: string;
  data: T;
}

/**
 * Parseia a resposta do backend como JSON e retorna `data` tipado como `T`.
 *
 * Use em endpoints que retornam JSON estruturado.
 *
 * ⚠️ O cast para `T` é feito em runtime sem validação de schema — garanta que
 * o contrato do backend seja estável ou valide com Zod.
 */
export async function parseBackendJsonPayload<T>(
  response: Response,
): Promise<ParseBackendJsonPayloadResult<T>> {
  const { rawText, parsed, isJson } = await parseBackendPayload(response);

  if (!isJson) {
    console.warn(
      "[parseBackendJsonPayload] Resposta não JSON recebida em endpoint esperado como JSON. Use parseBackendTextPayload.",
    );
  }

  return {
    rawText,
    data: parsed as T,
  };
}
