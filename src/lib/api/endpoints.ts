export const endpoints = {
  dividaAtiva: {
    listar: "/api/divida-ativa",
    buscar: (id: string) => `/api/divida-ativa/${id}`,
  },
} as const;
