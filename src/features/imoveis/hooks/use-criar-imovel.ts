"use client";

import { useMutation, useQueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { imoveisService } from "../imoveis-service";
import { ApiError } from "@/lib/api";
import type { CriarImovelDto } from "@/types";

export function useCriarImovel() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (payload: CriarImovelDto) => {
      console.log(payload);
      return imoveisService.criar(payload);
    },
    onSuccess: () => {
      toast.success("Imóvel incluído com sucesso!");
      queryClient.invalidateQueries({ queryKey: ["imoveis"] });
    },
    onError: (error) => {
      const msg =
        error instanceof ApiError
          ? error.message
          : "Erro ao salvar imóvel. Tente novamente.";
      toast.error(msg);
    },
  });
}
