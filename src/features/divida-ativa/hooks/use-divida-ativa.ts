"use client";

import { useQuery } from "@tanstack/react-query";
import { dividaAtivaService } from "../divida-ativa-service";

export function useDividaAtiva() {
  return useQuery({
    queryKey: ["divida-ativa"],
    queryFn: () => dividaAtivaService.listar(),
  });
}
