"use client";

import { Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useExcluirImovel } from "@/features/imoveis/hooks/use-excluir-imovel";
import type { Imovel } from "@/types";

interface ImovelItemProps {
  imovel: Imovel;
}

/**
 * Aplica a máscara #.###.###-# a uma string de dígitos.
 * Preenche com zeros à esquerda se necessário para atingir 8 dígitos.
 */
function formatarInscricao(valor: string): string {
  const digits = valor.replace(/\D/g, "").padStart(8, "0").slice(0, 8);
  return `${digits[0]}.${digits.slice(1, 4)}.${digits.slice(4, 7)}-${digits[7]}`;
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
          {formatarInscricao(imovel.numInscricao)}
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
