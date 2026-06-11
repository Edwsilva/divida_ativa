export const runtime = "nodejs";
import { NextRequest, NextResponse } from "next/server";
import {
  sealAccessSession,
  unsealAccessSession,
  sealRefreshSession,
  unsealRefreshSession,
  refreshSession,
  logServerError,
  ACCESS_COOKIE,
  REFRESH_COOKIE,
  COOKIE_MAX_AGE,
  POST_LOGIN_REDIRECT_COOKIE,
  POST_LOGIN_REDIRECT_MAX_AGE,
} from "@/lib/auth";

function redirectToLoginPreservingTarget(request: NextRequest) {
  const { pathname, search } = request.nextUrl;
  const loginUrl = new URL("/login", request.url);
  const response = NextResponse.redirect(loginUrl);

  response.cookies.set(POST_LOGIN_REDIRECT_COOKIE, pathname + search, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    maxAge: POST_LOGIN_REDIRECT_MAX_AGE,
  });

  return response;
}

export default async function middleware(request: NextRequest) {
  const { pathname, searchParams } = request.nextUrl;

  // Se o Keycloak redirecionou para / (ou outra rota) com o code na query,
  // encaminhar para o callback para trocar o code pelo token e evitar loop.
  if (searchParams.has("code") && pathname !== "/callback") {
    const callbackUrl = new URL("/callback", request.url);
    searchParams.forEach((value, key) =>
      callbackUrl.searchParams.set(key, value),
    );
    return NextResponse.redirect(callbackUrl);
  }

  const accessCookie = request.cookies.get(ACCESS_COOKIE);
  const refreshCookie = request.cookies.get(REFRESH_COOKIE);

  if (!accessCookie) {
    return redirectToLoginPreservingTarget(request);
  }

  let session;
  try {
    const accessSession = await unsealAccessSession(accessCookie.value);
    const refreshSessionPayload = refreshCookie
      ? await unsealRefreshSession(refreshCookie.value)
      : {};
    session = {
      ...accessSession,
      ...refreshSessionPayload,
    };
  } catch (err) {
    logServerError("Erro ao abrir sessão", err);
    return redirectToLoginPreservingTarget(request);
  }

  const refreshedSession = await refreshSession(session);

  if (Date.now() > session.exp && !refreshedSession) {
    return redirectToLoginPreservingTarget(request);
  }

  if (refreshedSession) {
    const sealedAccess = await sealAccessSession({
      accessToken: refreshedSession.accessToken,
      exp: refreshedSession.exp,
    });

    const response = NextResponse.next();
    response.cookies.set(ACCESS_COOKIE, sealedAccess, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: COOKIE_MAX_AGE,
    });

    if (refreshedSession.refreshToken || refreshedSession.refreshExp) {
      const sealedRefresh = await sealRefreshSession({
        refreshToken: refreshedSession.refreshToken,
        refreshExp: refreshedSession.refreshExp,
      });

      response.cookies.set(REFRESH_COOKIE, sealedRefresh, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "lax",
        path: "/",
        maxAge: COOKIE_MAX_AGE,
      });
    }
    return response;
  }

  return NextResponse.next();
}

export const config = {
  runtime: "nodejs",
  matcher: ["/"],
};
