// src/env.ts
import { z } from "zod";

const serverSchema = z.object({
  KEYCLOAK_URL: z.string().url(),
  KEYCLOAK_REALM: z.string(),
  KEYCLOAK_CLIENT_ID: z.string(),
  KEYCLOAK_CLIENT_SECRET: z.string(),
  KEYCLOAK_REDIRECT_URI: z.string().url(),
  KEYCLOAK_POST_LOGOUT_REDIRECT_URI: z.string().url().optional(),
  LOGOUTGOVBR_URL: z.string().url().optional(),
  SESSION_SECRET: z.string(),
});

let _serverEnv: z.infer<typeof serverSchema> | undefined;

/** Stub usado apenas durante o build no CI, quando as variáveis de servidor não estão definidas. */
function getBuildStubEnv(): z.infer<typeof serverSchema> {
  return {
    KEYCLOAK_URL: "",
    KEYCLOAK_REALM: "",
    KEYCLOAK_CLIENT_ID: "",
    KEYCLOAK_CLIENT_SECRET: "",
    KEYCLOAK_REDIRECT_URI: "",
    KEYCLOAK_POST_LOGOUT_REDIRECT_URI: undefined,
    LOGOUTGOVBR_URL: undefined,
    SESSION_SECRET: "",
  };
}

function isBuildTime(): boolean {
  return process.env.KEYCLOAK_URL === undefined;
}

export function getEnv() {
  if (typeof window !== "undefined") {
    throw new Error(
      "getEnv() só pode ser chamado no servidor.",
    );
  }

  if (_serverEnv !== undefined) {
    return _serverEnv;
  }

  try {
    _serverEnv = serverSchema.parse({
      KEYCLOAK_URL: process.env.KEYCLOAK_URL,
      KEYCLOAK_REALM: process.env.KEYCLOAK_REALM,
      KEYCLOAK_CLIENT_ID: process.env.KEYCLOAK_CLIENT_ID,
      KEYCLOAK_CLIENT_SECRET: process.env.KEYCLOAK_CLIENT_SECRET,
      KEYCLOAK_REDIRECT_URI: process.env.KEYCLOAK_REDIRECT_URI,
      KEYCLOAK_POST_LOGOUT_REDIRECT_URI:
        process.env.KEYCLOAK_POST_LOGOUT_REDIRECT_URI,
      LOGOUTGOVBR_URL: process.env.LOGOUTGOVBR_URL,
      SESSION_SECRET: process.env.SESSION_SECRET,
    });
    return _serverEnv;
  } catch (e) {
    if (e instanceof z.ZodError && isBuildTime()) {
      return getBuildStubEnv();
    }
    throw e;
  }
}
