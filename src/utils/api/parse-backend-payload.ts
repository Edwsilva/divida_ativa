import type { BackendErrorBody } from "@/types";

export interface ParseBackendPayloadResult {
  rawText: string;
  parsed: BackendErrorBody | unknown;
  isJson: boolean;
  message: string | null;
}

export async function parseBackendPayload(
  response: Response,
): Promise<ParseBackendPayloadResult> {
  const rawText = await response.text();

  let parsed: BackendErrorBody | unknown = null;
  let isJson = false;

  if (rawText) {
    try {
      parsed = JSON.parse(rawText);
      isJson = true;
    } catch {
      parsed = rawText;
    }
  }

  const message =
    (parsed as BackendErrorBody)?.mensagem ||
    (parsed as BackendErrorBody)?.message ||
    (parsed as BackendErrorBody)?.error ||
    (typeof parsed === "string" ? parsed : null) ||
    rawText ||
    null;

  return { rawText, parsed, isJson, message };
}
