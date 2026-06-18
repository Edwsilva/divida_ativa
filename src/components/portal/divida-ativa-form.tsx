"use client";

import { useState } from "react";
import { toast } from "sonner";
import {
  FileCheck,
  FileClock,
  FileStack,
  CalendarClock,
  Layers,
  ClipboardList,
  FileText,
  ArrowRight,
} from "lucide-react";
import type { LucideIcon } from "lucide-react";

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
  icon: LucideIcon;
  hasDocButton?: boolean;
}

const OPCOES: Opcao[] = [
  {
    value: "consultarAvulsaDam",
    label: "Emitir guia à vista ou liquidar débitos",
    icon: FileCheck,
  },
  {
    value: "consultarRegularizacaoDam",
    label: "Emitir guias — parcela em atraso (regularização)",
    icon: FileClock,
  },
  {
    value: "consultar2aViaGuiaDam",
    label: "Emitir segunda via de guia de parcelamento",
    icon: FileStack,
  },
  {
    value: "consultarAdiantamentoDam",
    label: "Emitir adiantamento de cotas de parcelamento",
    icon: CalendarClock,
  },
  {
    value: "consultarParcelamentoDam",
    label: "Parcelar débitos",
    icon: Layers,
    hasDocButton: true,
  },
  {
    value: "consultarRequerimentosParcelamentoDam",
    label: "Acompanhar requerimento de parcelamento",
    icon: ClipboardList,
  },
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
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
          {OPCOES.map((op) => (
            <label
              key={op.value}
              htmlFor={op.value}
              className={cn(
                "flex cursor-pointer flex-col gap-3 rounded-xl border p-4 transition-all duration-300 ease-out hover:-translate-y-1 hover:scale-[1.02] hover:shadow-md",
                opcao === op.value
                  ? "border-sky-500/60 bg-sky-500/8 shadow-sm dark:border-sky-400/50 dark:bg-sky-500/15"
                  : "border-sky-500/30 bg-sky-500/5 hover:border-sky-500/50 hover:bg-sky-500/8 dark:border-sky-400/20 dark:bg-sky-500/5",
              )}
            >
              <input
                type="radio"
                id={op.value}
                name="opcaoDAM"
                value={op.value}
                checked={opcao === op.value}
                onChange={() => setOpcao(op.value)}
                className="sr-only"
                aria-label={op.label}
              />
              <op.icon
                className={cn(
                  "h-5 w-5 transition-colors",
                  opcao === op.value ? "text-primary" : "text-muted-foreground",
                )}
                aria-hidden="true"
              />
              <span className="text-xs font-medium leading-snug text-foreground">
                {op.label}
              </span>
              {op.hasDocButton && (
                <button
                  type="button"
                  onClick={(e) => {
                    e.preventDefault();
                    setModalAberto(true);
                  }}
                  className="inline-flex w-fit items-center gap-1.5 rounded-md bg-primary px-2.5 py-1 text-[11px] font-semibold text-white transition-colors hover:bg-primary/90"
                  aria-label="Ver documentos necessários para parcelamento"
                >
                  <FileText className="h-3 w-3 shrink-0" />
                  Documentos necessários
                </button>
              )}
            </label>
          ))}
        </div>

        <Button
          type="submit"
          className="bg-primary hover:bg-primary/90 text-white"
        >
          Confirmar
          <ArrowRight className="ml-2 h-4 w-4" />
        </Button>
      </form>

      <DocumentosParcelamentoModal
        open={modalAberto}
        onClose={() => setModalAberto(false)}
      />
    </>
  );
}
