import { NextResponse } from "next/server";
import { getServerSession, logServerError } from "@/lib/auth";
import { decodeJwt } from "@/lib/api";

export async function GET() {
  const session = await getServerSession();

  if (!session) {
    return new NextResponse("Sessão não encontrada", { status: 401 });
  }

  try {
    const decoded = decodeJwt(session.accessToken);

    return NextResponse.json(decoded);
  } catch (error) {
    logServerError("Erro ao decodificar token", error);
    return new NextResponse("Erro ao decodificar token", { status: 500 });
  }
}
