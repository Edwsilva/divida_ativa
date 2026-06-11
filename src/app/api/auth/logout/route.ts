import { NextRequest, NextResponse } from "next/server";
import { getEnv } from "@/env";
import { ACCESS_COOKIE, REFRESH_COOKIE } from "../../lib/index";

function getPostLogoutRedirectUri(request: NextRequest) {
  const { KEYCLOAK_POST_LOGOUT_REDIRECT_URI } = getEnv();
  try {
    return KEYCLOAK_POST_LOGOUT_REDIRECT_URI
      ? new URL(KEYCLOAK_POST_LOGOUT_REDIRECT_URI).toString()
      : new URL("/", request.url).toString();
  } catch {
    return new URL("/", request.url).toString();
  }
}

export async function GET(request: NextRequest) {
  const {
    KEYCLOAK_URL: keycloakBase,
    KEYCLOAK_REALM: realm,
    KEYCLOAK_CLIENT_ID: clientId,
  } = getEnv();

  const logoutUrl = new URL(
    `${keycloakBase}/realms/${realm}/protocol/openid-connect/logout`,
  );

  const postLogoutRedirectUri = getPostLogoutRedirectUri(request);

  logoutUrl.searchParams.set("client_id", clientId!);
  logoutUrl.searchParams.set("post_logout_redirect_uri", postLogoutRedirectUri);

  const response = NextResponse.redirect(logoutUrl.toString());

  response.cookies.set(ACCESS_COOKIE, "", {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 0,
  });

  response.cookies.set(REFRESH_COOKIE, "", {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: 0,
  });

  return response;
}
