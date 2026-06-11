import { NextRequest, NextResponse } from "next/server";
import {
  sealAccessSession,
  sealRefreshSession,
  isSafeInternalPath,
  logServerError,
  ACCESS_COOKIE,
  REFRESH_COOKIE,
  COOKIE_MAX_AGE,
  POST_LOGIN_REDIRECT_COOKIE,
} from "@/lib/auth";
import { getEnv } from "@/lib/env";
import { KeycloakTokenResponse } from "@/types";

function resolvePostLoginUrl(
  redirectUri: string,
  requestOrigin: string,
): string {
  try {
    return new URL(redirectUri).origin;
  } catch {
    return requestOrigin;
  }
}

export async function GET(request: NextRequest) {
  const url = new URL(request.url);
  const code = url.searchParams.get("code");

  if (!code) {
    return new NextResponse("Missing code", { status: 400 });
  }

  const {
    KEYCLOAK_URL: keycloakBase,
    KEYCLOAK_REALM: realm,
    KEYCLOAK_CLIENT_ID: clientId,
    KEYCLOAK_CLIENT_SECRET: clientSecret,
    KEYCLOAK_REDIRECT_URI: redirectUri,
  } = getEnv();

  const tokenUrl = `${keycloakBase}/realms/${realm}/protocol/openid-connect/token`;

  const body = new URLSearchParams({
    grant_type: "authorization_code",
    code,
    redirect_uri: redirectUri,
    client_id: clientId,
    client_secret: clientSecret,
  });

  const tokenResponse = await fetch(tokenUrl, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body,
  });

  if (!tokenResponse.ok) {
    logServerError("Erro ao trocar code por token", await tokenResponse.text());
    return new NextResponse("Erro na autenticação", { status: 500 });
  }

  const tokenJson = (await tokenResponse.json()) as KeycloakTokenResponse;

  const {
    access_token: accessToken,
    refresh_token: refreshToken,
    expires_in: expiresIn,
    refresh_expires_in: refreshExpiresIn,
  } = tokenJson;

  if (!accessToken) {
    logServerError("Erro ao obter access token", tokenJson);
    return new NextResponse("Erro na autenticação", { status: 500 });
  }

  const exp = Date.now() + expiresIn * 1000;
  const refreshExp = refreshExpiresIn
    ? Date.now() + refreshExpiresIn * 1000
    : undefined;

  const sealedAccess = await sealAccessSession({
    accessToken,
    exp,
  });

  const sealedRefresh =
    refreshToken || refreshExp
      ? await sealRefreshSession({
          refreshToken,
          refreshExp,
        })
      : undefined;

  const postLoginTarget = request.cookies.get(
    POST_LOGIN_REDIRECT_COOKIE,
  )?.value;
  const publicOrigin = resolvePostLoginUrl(redirectUri, url.origin);
  const fallbackUrl = new URL("/", publicOrigin).toString();
  const redirectTo = isSafeInternalPath(postLoginTarget)
    ? new URL(postLoginTarget, publicOrigin).toString()
    : fallbackUrl;

  const response = NextResponse.redirect(redirectTo);

  response.cookies.set(ACCESS_COOKIE, sealedAccess, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: COOKIE_MAX_AGE,
  });

  if (sealedRefresh) {
    response.cookies.set(REFRESH_COOKIE, sealedRefresh, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: COOKIE_MAX_AGE,
    });
  } else {
    response.cookies.set(REFRESH_COOKIE, "", {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: 0,
    });
  }

  response.cookies.set(POST_LOGIN_REDIRECT_COOKIE, "", {
    path: "/",
    maxAge: 0,
  });

  return response;
}
