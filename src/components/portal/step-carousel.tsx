"use client";

import { useRef } from "react";
import {
  ChevronLeft,
  ChevronRight,
  House,
  SearchCheck,
  FileText,
  CreditCard,
} from "lucide-react";
import type { LucideIcon } from "lucide-react";

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
  const scrollRef = useRef<HTMLDivElement>(null);

  function scroll(dir: "left" | "right") {
    const el = scrollRef.current;
    if (!el) return;
    const card = el.querySelector("[data-card]") as HTMLElement | null;
    const w = (card?.offsetWidth ?? 320) + 16;
    el.scrollBy({ left: dir === "right" ? w : -w, behavior: "smooth" });
  }

  return (
    <div className="relative px-4">
      {/* Seta esquerda */}
      <button
        type="button"
        onClick={() => scroll("left")}
        aria-label="Card anterior"
        className="absolute left-0 top-1/2 z-10 -translate-y-1/2 text-muted-foreground transition-colors hover:text-foreground"
      >
        <ChevronLeft className="h-5 w-5" />
      </button>

      {/* Container com clip */}
      <div className="overflow-hidden">
        <div
          ref={scrollRef}
          className="flex gap-3 overflow-x-auto [scrollbar-width:none] [&::-webkit-scrollbar]:hidden"
          style={{ scrollSnapType: "x mandatory" }}
        >
          {SLIDES.map((slide, index) => (
            <div
              key={slide.title}
              data-card
              className="relative flex h-32 min-w-full flex-shrink-0 overflow-hidden rounded-xl bg-gradient-to-br from-indigo-600 via-blue-600 to-blue-500 p-4 sm:min-w-[calc(50%-6px)]"
              style={{ scrollSnapAlign: "start" }}
            >
              {/* Texto */}
              <div className="relative z-10 flex flex-col justify-between">
                <div className="space-y-0.5">
                  {/* <p className="text-[9px] font-bold uppercase tracking-widest text-white/50">
                    Passo {index + 1}
                  </p> */}
                  <h3 className="text-sm font-bold leading-snug text-white">
                    {slide.title}
                  </h3>
                  <p className="text-xs leading-relaxed text-white/70">
                    {slide.description}
                  </p>
                </div>
                <button
                  type="button"
                  className="mt-2 w-fit rounded-md border border-white/30 bg-white/15 px-3 py-1 text-[11px] font-semibold text-white backdrop-blur-sm transition-colors hover:bg-white/25"
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
          ))}
        </div>
      </div>

      {/* Seta direita */}
      <button
        type="button"
        onClick={() => scroll("right")}
        aria-label="Próximo card"
        className="absolute right-0 top-1/2 z-10 -translate-y-1/2 text-muted-foreground transition-colors hover:text-foreground"
      >
        <ChevronRight className="h-5 w-5" />
      </button>
    </div>
  );
}
