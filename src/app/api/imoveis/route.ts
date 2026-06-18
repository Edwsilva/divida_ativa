import { NextRequest } from "next/server";
import { requestImoveisBackend } from "./lib/backend";
import type { Imovel } from "@/types";

export async function GET() {
  return requestImoveisBackend<Imovel[]>("/imoveis");
}

export async function POST(request: NextRequest) {
  const body = await request.json().catch(() => ({}));

  return requestImoveisBackend<Imovel>("/imoveis", {
    method: "POST",
    body: JSON.stringify({
      numInscricao: body?.numInscricao,
    }),
  });
}
