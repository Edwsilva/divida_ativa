import { NextResponse } from "next/server";
import { getEnv } from "@/lib/env";

export async function GET() {
  const keycloakBase = getEnv().KEYCLOAK_URL;
  const realm = getEnv().KEYCLOAK_REALM;
  const clientId = getEnv().KEYCLOAK_CLIENT_ID;
  const redirectUri = getEnv().KEYCLOAK_REDIRECT_URI;

  const authUrl = new URL(
    `${keycloakBase}/realms/${realm}/protocol/openid-connect/auth`,
  );

  authUrl.searchParams.set("client_id", clientId!);
  authUrl.searchParams.set("response_type", "code");
  authUrl.searchParams.set("scope", "openid"); // pode adicionar profile,email...
  authUrl.searchParams.set("redirect_uri", redirectUri);

  return NextResponse.redirect(authUrl.toString());
}
