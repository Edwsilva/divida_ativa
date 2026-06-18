import { apiClient } from "@/lib/api/api-client";
import { endpoints } from "@/lib/api/endpoints";
import type { DividaAtiva } from "@/types";

export const dividaAtivaService = {
  listar(): Promise<DividaAtiva[]> {
    return apiClient<DividaAtiva[]>(endpoints.dividaAtiva.listar);
  },

  buscar(id: string): Promise<DividaAtiva> {
    return apiClient<DividaAtiva>(endpoints.dividaAtiva.buscar(id));
  },
};
