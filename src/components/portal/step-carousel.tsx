"use client";

import { useState } from "react";
import {
  ChevronLeft,
  ChevronRight,
  House,
  SearchCheck,
  FileText,
  CreditCard,
} from "lucide-react";
import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

interface SlideItem {
  title: string;
  description: string;
  actionLabel: string;
  icon: LucideIcon;
}

const SLIDES: SlideItem[] = [
  {
    title: "Cadastre seus imóveis",
    description: "Vincule seus imóveis pelo número da inscrição imobiliária.",
    actionLabel: "Saiba mais",
    icon: House,
  },
  {
    title: "Consulte sua dívida",
    description: "Verifique débitos de IPTU, ISS, taxas e multas municipais.",
    actionLabel: "Consultar",
    icon: SearchCheck,
  },
  {
    title: "Emita o DAM",
    description: "Gere o documento de arrecadação com valor atualizado.",
    actionLabel: "Emitir",
    icon: FileText,
  },
  {
    title: "Efetue o pagamento",
    description: "Pague em bancos, internet banking ou débito automático.",
    actionLabel: "Ver opções",
    icon: CreditCard,
  },
];

export function StepCarousel() {
  const [current, setCurrent] = useState(0);

  const canPrev = current > 0;
  const canNext = current < SLIDES.length - 1;

  return (
    <div className="space-y-3">
      {/* Slider */}
      <div className="relative h-36 overflow-hidden">
        {SLIDES.map((slide, index) => {
          const offset = index - current;

          // Posições baseadas no offset
          const left =
            offset === 0
              ? "0%"
              : offset === 1
                ? "52%"
                : offset < 0
                  ? "-54%"
                  : "106%";

          const top = offset === 0 ? "0px" : "8px";
          const width = "48%";
          const height = offset === 0 ? "100%" : "calc(100% - 8px)";
          const zIndex = offset === 0 ? 20 : offset === 1 ? 10 : 0;
          const opacity = Math.abs(offset) <= 1 ? 1 : 0;

          return (
            <div
              key={slide.title}
              className="absolute overflow-hidden rounded-xl p-4 bg-primary/90"
              style={{
                left,
                top,
                width,
                height,
                zIndex,
                opacity,
                transition: "all 0.4s cubic-bezier(0.4, 0, 0.2, 1)",
              }}
            >
              {/* Conteúdo */}
              <div className="relative z-10 flex h-full flex-col justify-between">
                <div className="space-y-1">
                  <h3 className="text-base font-bold leading-snug text-white">
                    {slide.title}
                  </h3>
                  <p className="text-sm leading-relaxed text-white/70">
                    {slide.description}
                  </p>
                </div>
                <button
                  type="button"
                  className="mt-2 w-fit rounded-md border border-white/30 bg-white/15 px-3 py-1 text-xs font-semibold text-white backdrop-blur-sm transition-colors hover:bg-white/25"
                >
                  {slide.actionLabel}
                </button>
              </div>

              {/* Ícone decorativo */}
              <slide.icon
                className="absolute -bottom-2 -right-2 h-20 w-20 text-white opacity-10"
                aria-hidden="true"
              />
            </div>
          );
        })}
      </div>

      {/* Setas de navegação */}
      <div className="flex items-center gap-1.5">
        <button
          type="button"
          onClick={() => canPrev && setCurrent((i) => i - 1)}
          disabled={!canPrev}
          aria-label="Card anterior"
          className={cn(
            "flex h-6 w-6 items-center justify-center rounded-full border border-border/30 text-foreground transition-colors",
            canPrev ? "hover:bg-muted" : "cursor-not-allowed opacity-30",
          )}
        >
          <ChevronLeft className="h-3.5 w-3.5" />
        </button>
        <button
          type="button"
          onClick={() => canNext && setCurrent((i) => i + 1)}
          disabled={!canNext}
          aria-label="Próximo card"
          className={cn(
            "flex h-6 w-6 items-center justify-center rounded-full border border-border/30 text-foreground transition-colors",
            canNext ? "hover:bg-muted" : "cursor-not-allowed opacity-30",
          )}
        >
          <ChevronRight className="h-3.5 w-3.5" />
        </button>
      </div>
    </div>
  );
}
