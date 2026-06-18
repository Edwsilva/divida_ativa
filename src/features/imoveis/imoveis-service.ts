import { apiClient } from "@/lib/api/api-client";
import { endpoints } from "@/lib/api/endpoints";
import type { CriarImovelDto, Imovel } from "@/types";

export const imoveisService = {
  listar(): Promise<Imovel[]> {
    return apiClient<Imovel[]>(endpoints.imoveis.listar);
  },

  buscar(id: string): Promise<Imovel> {
    return apiClient<Imovel>(endpoints.imoveis.buscar(id));
  },

  criar(payload: CriarImovelDto): Promise<Imovel> {
    return apiClient<Imovel>(endpoints.imoveis.listar, {
      method: "POST",
      body: JSON.stringify(payload),
    });
  },

  excluir(id: string): Promise<null> {
    return apiClient<null>(endpoints.imoveis.buscar(id), {
      method: "DELETE",
    });
  },
};
