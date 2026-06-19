"use client";

import { useMutation, useQueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { imoveisService } from "../imoveis-service";
import { ApiError } from "@/lib/api";

export function useExcluirImovel() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (id: string) => imoveisService.excluir(id),
    onSuccess: () => {
      toast.success("Imóvel removido com sucesso!");
      queryClient.invalidateQueries({ queryKey: ["imoveis"] });
    },
    onError: (error) => {
      const msg =
        error instanceof ApiError
          ? error.message
          : "Erro ao remover imóvel. Tente novamente.";
      toast.error(msg);
    },
  });
}
