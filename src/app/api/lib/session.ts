import Iron from "@hapi/iron";
import { getEnv } from "@/env";
import { SessionPayload } from "@/types";

const SESSION_SECRET = getEnv().SESSION_SECRET;

type AccessSessionPayload = Pick<SessionPayload, "accessToken" | "exp">;
type RefreshSessionPayload = Pick<
  SessionPayload,
  "refreshToken" | "refreshExp"
>;

async function seal(payload: object): Promise<string> {
  if (!SESSION_SECRET) {
    throw new Error("SESSION_SECRET is not set");
  }
  return Iron.seal(payload, SESSION_SECRET, Iron.defaults);
}

async function unseal<T>(sealed: string): Promise<T> {
  if (!SESSION_SECRET) {
    throw new Error("SESSION_SECRET is not set");
  }
  return Iron.unseal(sealed, SESSION_SECRET, Iron.defaults) as Promise<T>;
}

export async function sealAccessSession(
  payload: AccessSessionPayload,
): Promise<string> {
  return seal(payload);
}

export async function unsealAccessSession(
  sealed: string,
): Promise<AccessSessionPayload> {
  return unseal<AccessSessionPayload>(sealed);
}

export async function sealRefreshSession(
  payload: RefreshSessionPayload,
): Promise<string> {
  return seal(payload);
}

export async function unsealRefreshSession(
  sealed: string,
): Promise<RefreshSessionPayload> {
  return unseal<RefreshSessionPayload>(sealed);
}

export const ACCESS_COOKIE = "web_template_session";
export const REFRESH_COOKIE = "web_template_refresh_session";
export const COOKIE_MAX_AGE = 60 * 60 * 8; // 8h

export const POST_LOGIN_REDIRECT_COOKIE =
  "web_template_post_login_redirect";
export const POST_LOGIN_REDIRECT_MAX_AGE = 60 * 10; // 10 minutos: tempo máximo do round-trip de login

export function isSafeInternalPath(
  value: string | undefined | null,
): value is string {
  if (!value) return false;
  if (!value.startsWith("/")) return false;
  if (value.startsWith("//") || value.startsWith("/\\")) return false;
  return true;
}
