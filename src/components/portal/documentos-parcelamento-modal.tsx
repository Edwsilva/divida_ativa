"use client";

import { useEffect } from "react";
import Image from "next/image";
import { X } from "lucide-react";

import { cn } from "@/lib/utils";

interface Props {
  open: boolean;
  onClose: () => void;
}

export function DocumentosParcelamentoModal({ open, onClose }: Props) {
  useEffect(() => {
    if (!open) return;

    document.body.style.overflow = "hidden";
    const handleKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    document.addEventListener("keydown", handleKey);

    return () => {
      document.body.style.overflow = "";
      document.removeEventListener("keydown", handleKey);
    };
  }, [open, onClose]);

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-label="Documentação para o pedido de parcelamento"
      className={cn(
        "fixed inset-0 z-50 flex items-center justify-center p-4",
        "transition-[opacity,visibility] duration-300 ease-in-out",
        open
          ? "visible opacity-100"
          : "invisible opacity-0 pointer-events-none",
      )}
    >
      {/* Overlay */}
      <div
        className={cn(
          "absolute inset-0 bg-black/50 transition-opacity duration-300 ease-in-out",
          open ? "opacity-100" : "opacity-0",
        )}
        onClick={onClose}
        aria-hidden="true"
      />

      {/* Painel */}
      <div
        className={cn(
          "relative z-10 flex max-h-[85vh] w-full max-w-xl flex-col overflow-hidden rounded-lg bg-white shadow-2xl",
          "transition-all duration-300 ease-in-out",
          open
            ? "scale-100 translate-y-0 opacity-100"
            : "scale-95 translate-y-6 opacity-0",
        )}
      >
        {/* Cabeçalho fixo */}
        <div className="relative flex shrink-0 items-center gap-4 border-b border-gray-200 bg-white px-6 py-4">
          <Image
            src="/logo-prefeitura.png"
            alt="Prefeitura do Rio de Janeiro"
            width={140}
            height={98}
            className="h-auto w-42 object-contain"
          />
          <div className="text-sm leading-snug text-gray-700">
            <p className="font-bold">Procuradoria Geral do Município</p>
            <p>Procuradoria Fiscal</p>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Fechar"
            className="absolute right-3 top-3 flex h-7 w-7 items-center justify-center rounded-full bg-gray-100 text-gray-500 transition-colors hover:bg-gray-200 hover:text-gray-800"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        {/* Conteúdo rolável */}
        <div className="overflow-y-auto px-6 py-5 text-sm leading-relaxed text-gray-800">
          <h2 className="mb-5 text-base font-bold uppercase tracking-wide">
            Documentação para o pedido de parcelamento
          </h2>

          <section className="space-y-3">
            <h3 className="font-bold">I - PESSOA FÍSICA</h3>
            <p>
              Se o débito estiver em nome do requerente, é necessário apresentar
              cópias da identidade e do CPF. No caso de procurador, é preciso
              apresentar a procuração (por instrumento particular com firma
              reconhecida) com poderes específicos para o procurador requerer o
              parcelamento, além de cópias da identidade e do CPF do procurador.
            </p>
            <p>
              Caso o contribuinte não esteja na Certidão de Dívida Ativa ou não
              seja o proprietário do imóvel que consta da inscrição imobiliária,
              deve apresentar escritura pública, sentença judicial ou auto de
              arrematação atestando sua condição de comprador, promitente
              comprador, arrematante, cessionário, promitente cessionário,
              possuidor, cessionário da posse, usufrutuário ou detentor de outro
              direito real sobre o imóvel.
            </p>
          </section>

          <section className="mt-5 space-y-3">
            <h3 className="font-bold">II - PESSOA JURÍDICA</h3>
            <p>
              A pessoa jurídica precisa apresentar CNPJ da empresa, contrato
              social (ou última alteração consolidada), registro de empresário
              individual ou estatuto e ata de eleição da atual diretoria. Se o
              requerente for o sócio responsável, apresentar também cópias da
              identidade e do CPF. No caso de procurador, apresentar procuração
              específica para requerer o parcelamento, com firma reconhecida,
              além de cópias da identidade e do CPF do procurador.
            </p>
            <p>
              Caso o contribuinte não esteja na Certidão de Dívida Ativa ou não
              seja o proprietário do imóvel que consta da inscrição imobiliária,
              deve apresentar escritura pública, sentença judicial ou auto de
              arrematação atestando sua condição de comprador, promitente
              comprador, arrematante, cessionário, promitente cessionário,
              possuidor, cessionário da posse, usufrutuário ou detentor de outro
              direito real sobre o imóvel. Bastam cópias dos documentos,
              acompanhadas dos originais.
            </p>
          </section>
        </div>
      </div>
    </div>
  );
}
