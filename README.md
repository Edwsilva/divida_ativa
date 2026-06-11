# Web Template Keycloak (Next.js 15)

Template **Next.js 15 / TypeScript** para iniciar aplicações web autenticadas por Keycloak (id.rio).

A tela inicial autenticada exibe o payload do JWT em formato de tabela — ponto de partida para novos projetos.

---

## Como rodar

### Passo 1 — Instale o Node.js (se ainda não tiver)

Baixe e instale a versão **LTS** em: https://nodejs.org

Verifique se instalou corretamente:

```bash
node -v
```

Deve aparecer algo como `v22.x.x`.

### Passo 2 — Instale o pnpm

```bash
npm install -g pnpm
```

Verifique:

```bash
pnpm -v
```

### Passo 3 — Entre na pasta do projeto

```bash
cd web-template
```

### Passo 4 — Instale as dependências

```bash
pnpm install
```

### Passo 5 — Suba o servidor

```bash
pnpm dev
```

### Passo 6 — Abra no navegador

```
http://localhost:3000
```

Você será redirecionado para o login do Keycloak (homologação). Após autenticar, a tela exibe o payload do JWT.

> O arquivo `.env.development` já vem pré-configurado com as credenciais de homologação do id.rio. Não é necessário alterar nada para rodar.

---

## Scripts disponíveis

| Comando | O que faz |
|---------|-----------|
| `pnpm dev` | Sobe o servidor de desenvolvimento em `localhost:3000` |
| `pnpm build` | Gera o build de produção |
| `pnpm start` | Sobe o servidor com o build de produção |
| `pnpm lint` | Verifica o código com ESLint |

---

## Variáveis de ambiente

O arquivo `.env.local` já vem pronto para homologação. Se precisar configurar outro ambiente, copie o arquivo e ajuste os valores:

| Variável | Descrição |
|----------|-----------|
| `KEYCLOAK_URL` | URL base do Keycloak |
| `KEYCLOAK_REALM` | Nome do realm |
| `KEYCLOAK_CLIENT_ID` | ID do client OAuth2 |
| `KEYCLOAK_CLIENT_SECRET` | Secret do client |
| `KEYCLOAK_REDIRECT_URI` | URL de retorno após login |
| `KEYCLOAK_POST_LOGOUT_REDIRECT_URI` | URL de destino após logout |
| `LOGOUTGOVBR_URL` | Opcional. URL de logout federado Gov.br |
| `SESSION_SECRET` | Chave para proteger os cookies de sessão. Use uma string longa e aleatória. |

Para gerar um `SESSION_SECRET`:

```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

---

## Fluxo de autenticação

1. O browser acessa `/`.
2. O middleware verifica se existe cookie de sessão.
3. Sem sessão, o usuário é redirecionado para `/api/auth/login`.
4. `/api/auth/login` redireciona para o Keycloak.
5. O Keycloak autentica o usuário e retorna com `code`.
6. `/api/auth/callback` troca o `code` por access token e refresh token.
7. Os tokens são guardados em cookies HTTP-only selados com `@hapi/iron`.
8. A home lê a sessão no servidor, decodifica o JWT e exibe o payload em tabela.
9. No logout, o front dispara o logout federado gov.br em iframe oculto e redireciona para o logout OIDC do Keycloak.

---

## Estrutura principal

- `src/middleware.ts` — protege a home e redireciona retornos com `code` para o callback
- `src/env.ts` — valida variáveis de ambiente usadas no servidor
- `src/app/page.tsx` — tela autenticada que exibe o payload do JWT
- `src/app/api/auth/login/route.ts` — monta a URL de login do Keycloak
- `src/app/api/auth/callback/route.ts` — troca o `code` por tokens
- `src/app/api/auth/me/route.ts` — retorna o payload decodificado do JWT
- `src/app/api/auth/logout/route.ts` — limpa cookies e redireciona para logout do Keycloak
- `src/app/api/lib/session.ts` — sela e abre os cookies de sessão
- `src/app/api/lib/refresh-session.ts` — renova a sessão usando refresh token
- `src/app/components/Layout/Header` — header institucional com botão de logout
- `src/app/components/Layout/Footer` — footer institucional

---

## Stack

- Next.js 15
- React 19
- TypeScript
- tailwind css
- shadcn/ui
- Sonner 
- CVA
- Keycloak por authorization code
- Cookies HTTP-only selados com `@hapi/iron`
- Logout federado gov.br opcional
