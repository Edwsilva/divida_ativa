import { parseBackendPayload } from "@/utils/api/parse-backend-payload";

export interface ParseBackendJsonPayloadResult<T> {
  rawText: string;
  data: T;
}

/**
 * Parseia a resposta do backend como JSON e retorna `data` já tipado como `T`.
 *
 * Use em endpoints que retornam JSON estruturado.
 *
 * ⚠️ O cast para `T` é feito em runtime sem validação de schema — garanta que
 * o contrato do backend seja estável ou use uma lib como Zod para validar.
 *
 * @example
 * ```ts
 * const { data } = await parseBackendJsonPayload<Solicitacao[]>(response);
 * return NextResponse.json<ApiSuccessResponse<Solicitacao[]>>({ success: true, data });
 * ```
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
