"use client";

import { useState } from "react";
import { toast } from "sonner";
import { FileText } from "lucide-react";

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
  { value: "consultarRegularizacaoDam", label: "Emitir guias - parcela em atraso (regularização)" },
  { value: "consultar2aViaGuiaDam", label: "Emitir segunda via de guia de parcelamento" },
  { value: "consultarAdiantamentoDam", label: "Emitir adiantamento de cotas de parcelamento" },
  { value: "consultarParcelamentoDam", label: "Parcelar débitos", hasDocButton: true },
  {
    value: "consultarRequerimentosParcelamentoDam",
    label: "Acompanhar requerimento de parcelamento",
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
      <form onSubmit={handleSubmit} className="space-y-2.5">
        {OPCOES.map((op) => (
          <div key={op.value} className="flex items-center gap-2.5">
            <input
              type="radio"
              id={op.value}
              name="opcaoDAM"
              value={op.value}
              checked={opcao === op.value}
              onChange={() => setOpcao(op.value)}
              className="h-4 w-4 shrink-0 cursor-pointer accent-sky-600"
              aria-label={op.label}
            />
            <label
              htmlFor={op.value}
              className="flex cursor-pointer flex-wrap items-center gap-2 text-sm text-foreground/90"
            >
              {op.label}
              {op.hasDocButton && (
                <button
                  type="button"
                  onClick={() => setModalAberto(true)}
                  className="inline-flex items-center gap-1.5 rounded px-2.5 py-1 text-xs font-bold uppercase tracking-wide text-white transition-opacity hover:opacity-90"
                  style={{ backgroundColor: "#189abf" }}
                  aria-label="Ver documentos necessários para parcelamento"
                >
                  <FileText className="h-3 w-3 shrink-0" />
                  Veja os documentos necessários para realizar o parcelamento
                </button>
              )}
            </label>
          </div>
        ))}

        <div className="pt-2">
          <button
            type="submit"
            className="rounded px-6 py-1.5 text-sm font-semibold text-white transition-opacity hover:opacity-90"
            style={{ backgroundColor: "#189abf" }}
          >
            OK
          </button>
        </div>
      </form>

      <DocumentosParcelamentoModal
        open={modalAberto}
        onClose={() => setModalAberto(false)}
      />
    </>
  );
}
