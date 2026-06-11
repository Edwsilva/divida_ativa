import { cookies } from "next/headers";

import { SessionPayload } from "@/types";

import {
  ACCESS_COOKIE,
  COOKIE_MAX_AGE,
  REFRESH_COOKIE,
  sealAccessSession,
  sealRefreshSession,
  unsealAccessSession,
  unsealRefreshSession,
} from "./session";
import { logServerError } from "./log-server-error";
import { refreshSession } from "./refresh-session";

export async function getServerSession() {
  const cookieStore = cookies();
  const accessCookie = (await cookieStore).get(ACCESS_COOKIE);
  const refreshCookie = (await cookieStore).get(REFRESH_COOKIE);

  if (!accessCookie?.value) return null;

  let session: SessionPayload;
  try {
    session = await unsealAccessSession(accessCookie.value);
    if (refreshCookie?.value) {
      session = {
        ...session,
        ...(await unsealRefreshSession(refreshCookie.value)),
      };
    }
  } catch (error) {
    logServerError("Erro ao abrir sessão", error);
    return null;
  }

  if (!session.accessToken || !session.exp) return null;

  if (Date.now() <= session.exp) return session as SessionPayload;

  if (
    !session.refreshToken ||
    (session.refreshExp && Date.now() > session.refreshExp)
  ) {
    return null;
  }

  const refreshedSession = await refreshSession(session as SessionPayload);

  if (!refreshedSession) return null;

  const sealedAccess = await sealAccessSession({
    accessToken: refreshedSession.accessToken,
    exp: refreshedSession.exp,
  });

  (await cookieStore).set(ACCESS_COOKIE, sealedAccess, {
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
    (await cookieStore).set(REFRESH_COOKIE, sealedRefresh, {
      httpOnly: true,
      secure: process.env.NODE_ENV === "production",
      sameSite: "lax",
      path: "/",
      maxAge: COOKIE_MAX_AGE,
    });
  }

  return refreshedSession;
}
