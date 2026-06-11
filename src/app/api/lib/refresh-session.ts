import { SessionPayload } from "@/types";
import { logServerError } from "./log-server-error";
import { getEnv } from "@/env";

export async function refreshSession(session: SessionPayload) {
  if (Date.now() <= session.exp) {
    return undefined;
  }

  if (
    !session.refreshToken ||
    (session.refreshExp && Date.now() > session.refreshExp)
  ) {
    return undefined;
  }

  const {
    KEYCLOAK_URL: keycloakBase,
    KEYCLOAK_REALM: realm,
    KEYCLOAK_CLIENT_ID: clientId,
    KEYCLOAK_CLIENT_SECRET: clientSecret,
  } = getEnv();

  const tokenUrl = `${keycloakBase}/realms/${realm}/protocol/openid-connect/token`;

  const body = new URLSearchParams({
    grant_type: "refresh_token",
    refresh_token: session.refreshToken,
    client_id: clientId!,
    client_secret: clientSecret!,
  });

  const tokenResponse = await fetch(tokenUrl, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body,
  });

  if (!tokenResponse.ok) {
    logServerError("Erro ao renovar sessão", await tokenResponse.text());
    return undefined;
  }

  const tokenJson = await tokenResponse.json();

  const newAccessToken = tokenJson.access_token as string;
  const newRefreshToken = tokenJson.refresh_token as string | undefined;
  const newExpiresIn = tokenJson.expires_in as number;
  const newRefreshExpiresIn = tokenJson.refresh_expires_in as
    | number
    | undefined;

  const newSession: SessionPayload = {
    accessToken: newAccessToken,
    refreshToken: newRefreshToken,
    exp: Date.now() + newExpiresIn * 1000,
    refreshExp: newRefreshExpiresIn
      ? Date.now() + newRefreshExpiresIn * 1000
      : session.refreshExp,
  };

  return newSession;
}
