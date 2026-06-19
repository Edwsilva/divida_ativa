"use client";

import { useQuery } from "@tanstack/react-query";
import { imoveisService } from "../imoveis-service";

export function useImoveis() {
  return useQuery({
    queryKey: ["imoveis"],
    queryFn: () => imoveisService.listar(),
  });
}
