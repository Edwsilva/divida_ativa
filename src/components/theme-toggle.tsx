"use client";

import { MoonStar, SunMedium } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { useTheme } from "next-themes";

export function ThemeToggle() {
  const { resolvedTheme, setTheme } = useTheme();

  const [mounted, setMounted] = useState(false);

  // Controla apenas a posição do thumb
  const [thumbDark, setThumbDark] = useState(false);

  // Tema que será aplicado quando a animação terminar
  const nextTheme = useRef<"light" | "dark" | null>(null);

  const animating = useRef(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!mounted || animating.current) return;

    setThumbDark(resolvedTheme === "dark");
  }, [resolvedTheme, mounted]);

  if (!mounted) {
    return (
      <div className="h-8 w-14 rounded-full border border-slate-200 bg-slate-100 dark:border-slate-700 dark:bg-slate-800" />
    );
  }

  function handleToggle() {
    const nextTheme = thumbDark ? "light" : "dark";

    // Anima o botão
    setThumbDark(!thumbDark);

    // Anima a página inteira
    if (document.startViewTransition) {
      document.startViewTransition(() => {
        setTheme(nextTheme);
      });
    } else {
      setTheme(nextTheme);
    }
  }

  function handleTransitionEnd() {
    if (!animating.current || !nextTheme.current) return;

    if (!document.startViewTransition) {
      setTheme(nextTheme.current);
    } else {
      document.startViewTransition(() => {
        setTheme(nextTheme.current!);
      });
    }

    animating.current = false;
    nextTheme.current = null;
  }

  return (
    <button
      onClick={handleToggle}
      aria-label={thumbDark ? "Ativar tema claro" : "Ativar tema escuro"}
      aria-pressed={thumbDark}
      className="
        relative
        flex
        h-8
        w-14
        items-center
        overflow-hidden
        rounded-full
        border
        border-slate-200
        bg-white
        dark:border-slate-700
        dark:bg-slate-800
      "
    >
      {/* Ícones */}
      <span className="absolute inset-0 flex items-center justify-between px-[6px]">
        <SunMedium className="h-3.5 w-3.5 text-white" />

        <MoonStar
          className="h-3.5 w-3.5"
          style={{
            color: thumbDark ? "#fff" : "#0f172a",
            fill: thumbDark ? "transparent" : "#0f172a",
          }}
        />
      </span>

      {/* Thumb */}
      <span
        className="
          absolute
          left-1
          top-1
          h-6
          w-6
          rounded-full
          bg-sky-500
          will-change-transform
          transition-transform
          duration-500
        "
        style={{
          transform: thumbDark ? "translateX(24px)" : "translateX(0)",
          transitionTimingFunction: "cubic-bezier(0.34, 1.56, 0.64, 1)",
        }}
      />
    </button>
  );
}
