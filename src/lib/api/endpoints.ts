export const endpoints = {
  dividaAtiva: {
    listar: "/api/divida-ativa",
    buscar: (id: string) => `/api/divida-ativa/${id}`,
  },
  imoveis: {
    listar: "/api/imoveis",
    buscar: (id: string) => `/api/imoveis/${id}`,
  },
} as const;
