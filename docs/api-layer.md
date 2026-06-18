# Camada de API — Arquitetura DDD

Documentação da estrutura de acesso à API implementada no projeto, seguindo o padrão **BFF (Backend For Frontend)** com **TanStack Query** e organização por **features**.

---

## Visão Geral

```
Client Component
  → hook (TanStack Query)
  → service (apiClient)
  → Next.js API Route (BFF)          ← único ponto que fala com o backend
  → Backend externo (Bearer token)
```

O browser **nunca** chama o backend diretamente. Toda comunicação passa pelas API Routes do Next.js, que injetam o token de sessão automaticamente.

---

## Estrutura de Arquivos

```
src/
├── lib/
│   └── api/
│       ├── index.ts                         # barrel de exports
│       ├── api-error.ts                     # classe ApiError tipada
│       ├── api-client.ts                    # cliente HTTP para as API Routes
│       ├── endpoints.ts                     # mapa centralizado de endpoints
│       ├── parse-backend-payload.ts         # parser base (JSON ou texto)
│       ├── parse-backend-json-payload.ts    # parse tipado de JSON
│       ├── parse-backend-text-payload.ts    # parse de respostas texto/html
│       └── parse-backend-error-response.ts  # parse de erros do backend
│
├── components/
│   └── providers/
│       └── query-provider.tsx               # QueryClientProvider (TanStack Query)
│
├── features/
│   └── divida-ativa/                        # exemplo de feature de domínio
│       ├── divida-ativa-service.ts          # orquestra chamadas via apiClient
│       └── hooks/
│           ├── use-divida-ativa.ts          # useQuery: lista dívidas
│           └── use-divida-ativa-item.ts     # useQuery: busca por id
│
└── app/
    └── api/
        └── divida-ativa/                    # API Routes (BFF)
            ├── route.ts                     # GET /api/divida-ativa
            ├── [id]/
            │   └── route.ts                 # GET /api/divida-ativa/[id]
            └── lib/
                └── backend.ts               # proxy autenticado para o backend
```

---

## Dependências Instaladas

| Pacote | Versão | Uso |
|---|---|---|
| `@tanstack/react-query` | ^5 | cache e sincronização de estado servidor |
| `react-hook-form` | ^7 | formulários |
| `@hookform/resolvers` | ^5 | integração react-hook-form + Zod |

---

## Detalhamento das Camadas

### 1. `endpoints.ts` — Mapa de Endpoints

Centraliza todos os caminhos de API em um único lugar. Ao mudar uma URL, só mexe aqui.

```ts
export const endpoints = {
  dividaAtiva: {
    listar: "/api/divida-ativa",
    buscar: (id: string) => `/api/divida-ativa/${id}`,
  },
} as const;
```

---

### 2. `api-client.ts` — Cliente HTTP (lado cliente)

Faz `fetch` para as API Routes do Next.js. Lança `ApiError` em caso de falha e retorna `data` tipado em caso de sucesso.

```ts
const dados = await apiClient<DividaAtiva[]>(endpoints.dividaAtiva.listar);
```

**Comportamento:**
- Envia e recebe sempre JSON
- Em `{ success: false }` → lança `ApiError(statusCode, message)`
- Em `{ success: true }` → retorna `data` diretamente

---

### 3. `api-error.ts` — Classe de Erro

```ts
throw new ApiError(404, "Dívida não encontrada");

// captura:
catch (error) {
  if (error instanceof ApiError) {
    toast.error(error.message); // statusCode disponível em error.statusCode
  }
}
```

---

### 4. Parsers de Resposta do Backend (lado servidor)

Usados **dentro das API Routes** para normalizar respostas do backend externo.

| Parser | Quando usar |
|---|---|
| `parseBackendJsonPayload<T>` | Backend retorna JSON estruturado |
| `parseBackendTextPayload` | Backend retorna texto puro, HTML ou mensagem simples |
| `parseBackendErrorResponse` | Backend retornou status de erro (4xx, 5xx) |

```ts
// dentro de uma API Route:
const { data } = await parseBackendJsonPayload<DividaAtiva[]>(response);
```

---

### 5. `backend.ts` — Proxy Autenticado (lado servidor)

Função central de cada domínio de API. Responsável por:

1. Obter a sessão do usuário via `getServerSession()`
2. Injetar `Authorization: Bearer <token>` na requisição
3. Tratar 204 No Content, erros e falhas de rede
4. Normalizar tudo no formato `ApiResponse<T>`

```ts
// GET /api/divida-ativa/route.ts
export async function GET() {
  return requestDividaAtivaBackend<DividaAtiva[]>("/divida-ativa");
}

// POST com body:
export async function POST(request: NextRequest) {
  const body = await request.json();
  return requestDividaAtivaBackend<DividaAtiva>("/divida-ativa", {
    method: "POST",
    body: JSON.stringify(body),
  });
}
```

---

### 6. `*-service.ts` — Serviço de Domínio (lado cliente)

Agrupa as chamadas de um domínio usando `apiClient` + `endpoints`.

```ts
export const dividaAtivaService = {
  listar(): Promise<DividaAtiva[]> {
    return apiClient<DividaAtiva[]>(endpoints.dividaAtiva.listar);
  },
  buscar(id: string): Promise<DividaAtiva> {
    return apiClient<DividaAtiva>(endpoints.dividaAtiva.buscar(id));
  },
};
```

---

### 7. Hooks (TanStack Query)

Encapsulam o `useQuery`/`useMutation` para cada operação. São os únicos pontos de entrada nos componentes React.

```ts
// leitura
export function useDividaAtiva() {
  return useQuery({
    queryKey: ["divida-ativa"],
    queryFn: () => dividaAtivaService.listar(),
  });
}

// uso no componente:
const { data, isLoading, error } = useDividaAtiva();
```

---

### 8. `query-provider.tsx` — Provider Global

Registrado no `layout.tsx` raiz para disponibilizar o `QueryClient` em toda a aplicação.

```tsx
// src/app/layout.tsx
<QueryProvider>
  {children}
</QueryProvider>
```

---

## Tipos Globais (`src/types/index.d.ts`)

```ts
type ApiSuccessResponse<T> = { success: true; data: T };
type ApiErrorResponse     = { success: false; error: string; statusCode?: number; backendBody?: unknown };
type ApiResponse<T>       = ApiSuccessResponse<T> | ApiErrorResponse;
type BackendErrorBody     = { mensagem?: string; message?: string; error?: string; errors?: unknown };
```

---

## Como Adicionar um Novo Domínio

1. **Adicionar endpoint** em `src/lib/api/endpoints.ts`:
   ```ts
   meuDominio: {
     listar: "/api/meu-dominio",
     buscar: (id: string) => `/api/meu-dominio/${id}`,
   }
   ```

2. **Criar a API Route BFF** em `src/app/api/meu-dominio/`:
   - Copiar `lib/backend.ts` de outro domínio e ajustar `API_MEU_DOMINIO_URL` e o nome da função
   - Criar `route.ts` e `[id]/route.ts` conforme necessário

3. **Criar o service** em `src/features/meu-dominio/meu-dominio-service.ts`

4. **Criar os hooks** em `src/features/meu-dominio/hooks/`

5. **Adicionar o tipo de domínio** em `src/types/index.d.ts`

6. **Adicionar a variável de ambiente** do backend em `.env.local` e em `src/lib/env.ts`

---

## Tratamento de Erros nos Componentes

```tsx
"use client";

import { useDividaAtiva } from "@/features/divida-ativa/hooks/use-divida-ativa";
import { ApiError } from "@/lib/api";
import { toast } from "sonner";

export function ListaDividas() {
  const { data, isLoading, error } = useDividaAtiva();

  if (isLoading) return <p>Carregando...</p>;

  if (error) {
    const msg = error instanceof ApiError ? error.message : "Erro inesperado";
    toast.error(msg);
    return null;
  }

  return (
    <ul>
      {data?.map((d) => <li key={d.id}>{d.nomeDevedor}</li>)}
    </ul>
  );
}
```
