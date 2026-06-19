import { NextRequest, NextResponse } from "next/server";
import { requestImoveisBackend } from "./lib/backend";
import type { ApiSuccessResponse, Imovel } from "@/types";

// ---------------------------------------------------------------------------
// Mock in-memory (ativo quando USE_MOCK_IMOVEIS=true no .env.local)
// ---------------------------------------------------------------------------
let mockImoveis: Imovel[] = [
  {
    id: 1,
    cpf: "000.000.000-00",
    endereco: "RUA SANTO AFONSO, 216 / LOJ B - TIJUCA",
    numInscricao: "00000026",
  },
  {
    id: 2,
    cpf: "000.000.000-00",
    endereco: "RUA SANTO AFONSO, 216 / LOJA A - TIJUCA",
    numInscricao: "00000018",
  },
  {
    id: 3,
    cpf: "000.000.000-00",
    endereco: "RUA TERESA CAVALCANTI, 35 / APT 404 - PIEDADE",
    numInscricao: "00026344",
  },
  {
    id: 1,
    cpf: "000.000.000-00",
    endereco: "RUA SANTO AFONSO, 216 / LOJ B - TIJUCA",
    numInscricao: "00000026",
  },
  {
    id: 2,
    cpf: "000.000.000-00",
    endereco: "RUA SANTO AFONSO, 216 / LOJA A - TIJUCA",
    numInscricao: "00000018",
  },
  {
    id: 3,
    cpf: "000.000.000-00",
    endereco: "RUA TERESA CAVALCANTI, 35 / APT 404 - PIEDADE",
    numInscricao: "00026344",
  },
];
let mockNextId = 7;

const USE_MOCK = process.env.USE_MOCK_IMOVEIS === "true";

export async function GET() {
  if (USE_MOCK) {
    return NextResponse.json<ApiSuccessResponse<Imovel[]>>({
      success: true,
      data: mockImoveis,
    });
  }

  return requestImoveisBackend<Imovel[]>("/imoveis");
}

export async function POST(request: NextRequest) {
  const body = await request.json().catch(() => ({}));

  if (USE_MOCK) {
    const novoImovel: Imovel = {
      id: mockNextId++,
      cpf: "000.000.000-00",
      endereco: `IMÓVEL MOCK - INSCRIÇÃO ${body?.numInscricao ?? ""}`,
      numInscricao: body?.numInscricao ?? "",
    };
    mockImoveis.push(novoImovel);
    return NextResponse.json<ApiSuccessResponse<Imovel>>({
      success: true,
      data: novoImovel,
    });
  }

  return requestImoveisBackend<Imovel>("/imoveis", {
    method: "POST",
    body: JSON.stringify({
      numInscricao: body?.numInscricao,
    }),
  });
}
