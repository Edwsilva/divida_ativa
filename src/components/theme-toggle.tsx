"use client";

import { MoonStar, SunMedium } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { useTheme } from "next-themes";

const ANIMATION_DURATION = 100;

export function ThemeToggle() {
  const { resolvedTheme, setTheme } = useTheme();

  const [mounted, setMounted] = useState(false);

  // Estado que controla APENAS a posição do thumb
  const [thumbDark, setThumbDark] = useState(false);

  const isAnimating = useRef(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  // Sincroniza o thumb quando o tema mudar externamente
  useEffect(() => {
    if (!mounted || isAnimating.current) return;

    setThumbDark(resolvedTheme === "dark");
  }, [resolvedTheme, mounted]);

  if (!mounted) {
    return (
      <div className="h-8 w-14 rounded-full border border-slate-200 bg-slate-100 dark:border-slate-700 dark:bg-slate-800" />
    );
  }

  function handleToggle() {
    if (isAnimating.current) return;

    isAnimating.current = true;

    const nextDark = !thumbDark;

    // Anima o thumb imediatamente
    setThumbDark(nextDark);

    // Só troca o tema quando a animação terminar
    window.setTimeout(() => {
      const nextTheme = nextDark ? "dark" : "light";

      if (!document.startViewTransition) {
        setTheme(nextTheme);
      } else {
        document.startViewTransition(() => {
          setTheme(nextTheme);
        });
      }

      isAnimating.current = false;
    }, ANIMATION_DURATION);
  }

  return (
    <button
      onClick={handleToggle}
      aria-label={thumbDark ? "Ativar tema claro" : "Ativar tema escuro"}
      aria-pressed={thumbDark}
      className="relative flex h-8 w-14 items-center rounded-full border border-slate-200 bg-white dark:border-slate-700 dark:bg-slate-800"
    >
      {/* Ícones */}
      <span className="pointer-events-none absolute inset-0 flex items-center justify-between px-[6px]">
        <SunMedium className="h-3.5 w-3.5 text-white" />

        <MoonStar
          className="h-3.5 w-3.5 transition-all duration-300"
          style={{
            color: thumbDark ? "#fff" : "#0f172a",
            fill: thumbDark ? "transparent" : "#0f172a",
          }}
        />
      </span>

      {/* Thumb */}
      <span
        aria-hidden="true"
        className="absolute top-1 h-6 w-6 rounded-full bg-primary shadow-[0_2px_8px_rgba(14,165,233,0.5)] transition-[left] duration-500"
        style={{
          left: thumbDark ? "calc(100% - 28px)" : "4px",
          transitionTimingFunction: "cubic-bezier(0.34, 1.56, 0.64, 1)",
        }}
      />
    </button>
  );
}
