"use client";

import { useState } from "react";
import { toast } from "sonner";
import { FileText, ArrowRight } from "lucide-react";

import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { DocumentosParcelamentoModal } from "./documentos-parcelamento-modal";

type OpcaoValue =
  | "consultarAvulsaDam"
  | "consultarRegularizacaoDam"
  | "consultar2aViaGuiaDam"
  | "consultarAdiantamentoDam"
  | "consultarParcelamentoDam"
  | "consultarRequerimentosParcelamentoDam";

interface Opcao {
  value: OpcaoValue;
  label: string;
  hasDocButton?: boolean;
}

const OPCOES: Opcao[] = [
  { value: "consultarAvulsaDam", label: "Emitir guia à vista ou liquidar débitos" },
  { value: "consultarRegularizacaoDam", label: "Emitir guias — parcela em atraso (regularização)" },
  { value: "consultar2aViaGuiaDam", label: "Emitir segunda via de guia de parcelamento" },
  { value: "consultarAdiantamentoDam", label: "Emitir adiantamento de cotas de parcelamento" },
  { value: "consultarParcelamentoDam", label: "Parcelar débitos", hasDocButton: true },
  { value: "consultarRequerimentosParcelamentoDam", label: "Acompanhar requerimento de parcelamento" },
];

export function DividaAtivaForm() {
  const [opcao, setOpcao] = useState<OpcaoValue>("consultarAvulsaDam");
  const [modalAberto, setModalAberto] = useState(false);

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    toast.info("Redirecionando para o serviço selecionado...");
  }

  return (
    <>
      <form onSubmit={handleSubmit} className="space-y-2">
        {OPCOES.map((op) => (
          <label
            key={op.value}
            htmlFor={op.value}
            className={cn(
              "flex cursor-pointer items-start gap-3 rounded-xl border p-3.5 transition-all duration-150",
              opcao === op.value
                ? "border-sky-500/50 bg-sky-500/5 shadow-sm dark:border-sky-400/40 dark:bg-sky-500/10"
                : "border-border/60 bg-background hover:border-border hover:bg-muted/40",
            )}
          >
            <input
              type="radio"
              id={op.value}
              name="opcaoDAM"
              value={op.value}
              checked={opcao === op.value}
              onChange={() => setOpcao(op.value)}
              className="mt-0.5 h-4 w-4 shrink-0 cursor-pointer accent-sky-500"
              aria-label={op.label}
            />
            <span className="flex flex-wrap items-center gap-2 text-sm leading-snug text-foreground/90">
              {op.label}
              {op.hasDocButton && (
                <button
                  type="button"
                  onClick={(e) => {
                    e.preventDefault();
                    setModalAberto(true);
                  }}
                  className="inline-flex items-center gap-1.5 rounded-md bg-sky-500 px-2.5 py-1 text-xs font-semibold text-white transition-colors hover:bg-sky-600"
                  aria-label="Ver documentos necessários para parcelamento"
                >
                  <FileText className="h-3 w-3 shrink-0" />
                  Documentos necessários
                </button>
              )}
            </span>
          </label>
        ))}

        <div className="pt-2">
          <Button
            type="submit"
            className="bg-sky-500 hover:bg-sky-600 dark:bg-sky-600 dark:hover:bg-sky-700"
          >
            Confirmar
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </form>

      <DocumentosParcelamentoModal
        open={modalAberto}
        onClose={() => setModalAberto(false)}
      />
    </>
  );
}
