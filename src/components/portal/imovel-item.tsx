"use client";

import { Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useExcluirImovel } from "@/features/imoveis/hooks/use-excluir-imovel";
import type { Imovel } from "@/types";

interface ImovelItemProps {
  imovel: Imovel;
}

export function ImovelItem({ imovel }: ImovelItemProps) {
  const { mutate: excluirImovel, isPending } = useExcluirImovel();

  return (
    <div className="flex items-center justify-between gap-2 border-b border-border/20 py-3 last:border-b-0">
      <button
        type="button"
        className="min-w-0 flex-1 text-left"
        aria-label={`Ver serviços do imóvel ${imovel.endereco}`}
      >
        <p className="truncate text-sm font-medium text-sky-600 hover:underline">
          {imovel.endereco}
        </p>
        <p className="mt-0.5 text-xs text-muted-foreground">
          {imovel.numInscricao}
        </p>
      </button>

      <Button
        type="button"
        size="icon"
        variant="destructive"
        disabled={isPending}
        onClick={() => excluirImovel(String(imovel.id))}
        aria-label={`Remover imóvel ${imovel.endereco}`}
        className="h-8 w-8 shrink-0"
      >
        <Trash2 className="h-4 w-4" />
      </Button>
    </div>
  );
}
