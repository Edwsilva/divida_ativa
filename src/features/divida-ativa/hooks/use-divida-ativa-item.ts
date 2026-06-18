"use client";

import { useQuery } from "@tanstack/react-query";
import { dividaAtivaService } from "../divida-ativa-service";

export function useDividaAtivaItem(id: string) {
  return useQuery({
    queryKey: ["divida-ativa", id],
    queryFn: () => dividaAtivaService.buscar(id),
    enabled: Boolean(id),
  });
}
