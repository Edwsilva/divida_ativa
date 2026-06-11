import { NextResponse } from "next/server";
import { getEnv } from "@/env";

export async function GET() {
  const logoutGovbrUrl = getEnv().LOGOUTGOVBR_URL;

  if (!logoutGovbrUrl) {
    return new NextResponse(null, { status: 204 });
  }

  return NextResponse.redirect(logoutGovbrUrl);
}
