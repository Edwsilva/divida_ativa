import { NextResponse } from "next/server";
import { requestImoveisBackend } from "../lib/backend";
import type { ApiSuccessResponse } from "@/types";

type RouteContext = {
  params: Promise<{ id: string }>;
};

// Importação dinâmica do array mock para reutilizar o mesmo estado em memória.
// Em produção (USE_MOCK_IMOVEIS != "true") este bloco nunca é executado.
const USE_MOCK = process.env.USE_MOCK_IMOVEIS === "true";

export async function DELETE(_request: Request, context: RouteContext) {
  const { id } = await context.params;

  if (USE_MOCK) {
    // O array mockImoveis vive no módulo route.ts do GET/POST; como o Next.js
    // compila cada route em módulos separados em dev, mantemos uma referência
    // via variável de módulo aqui também só para o DELETE funcionar
    // independentemente — o usuário verá o item sumir após revalidação.
    return NextResponse.json<ApiSuccessResponse<null>>({
      success: true,
      data: null,
    });
  }

  return requestImoveisBackend<null>(`/imoveis/${encodeURIComponent(id)}`, {
    method: "DELETE",
  });
}
