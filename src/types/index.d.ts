interface DecodedToken {
  sub: string;
  preferred_username?: string;
  name?: string;
  given_name?: string;
  family_name?: string;
  email?: string;
  realm_access?: {
    roles?: string[];
  };
  resource_access?: Record<
    string,
    {
      roles?: string[];
    }
  >;
  [key: string]: unknown;
}

interface KeycloakTokenResponse {
  access_token: string;
  id_token?: string;
  refresh_token?: string;
  expires_in: number;
  refresh_expires_in?: number;
  error?: string;
  error_description?: string;
}

interface SessionPayload {
  accessToken: string;
  refreshToken?: string;
  exp: number;
  refreshExp?: number;
}

/** Tipo de domínio: dívida ativa. Adapte os campos conforme o contrato do backend. */
interface DividaAtiva {
  id: string;
  cpf: string;
  nomeDevedor: string;
  valorTotal: number;
  dataInscricao: string;
  situacao: string;
  [key: string]: unknown;
}

/** Resposta de sucesso padronizada das rotas de API (Next). */
type ApiSuccessResponse<T> = {
  success: true;
  data: T;
};

/** Resposta de erro padronizada das rotas de API (Next). */
type ApiErrorResponse = {
  success: false;
  error: string;
  statusCode?: number;
  backendBody?: unknown;
};

/** Resposta genérica de API: sucesso com data ou erro com mensagem. */
type ApiResponse<T> = ApiSuccessResponse<T> | ApiErrorResponse;

/** Formas comuns de erro retornadas por backends externos (para parse na rota). */
type BackendErrorBody = {
  mensagem?: string;
  message?: string;
  error?: string;
  errors?: unknown;
};

export type {
  DecodedToken,
  SessionPayload,
  ApiSuccessResponse,
  ApiErrorResponse,
  ApiResponse,
  BackendErrorBody,
  KeycloakTokenResponse,
  DividaAtiva,
};
