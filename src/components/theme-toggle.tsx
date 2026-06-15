"use client";

import { MoonStar, SunMedium } from "lucide-react";
import { useEffect, useState } from "react";
import { useTheme } from "next-themes";

export function ThemeToggle() {
  const [mounted, setMounted] = useState(false);
  const [isDark, setIsDark] = useState(false);
  const { resolvedTheme, setTheme } = useTheme();

  useEffect(() => {
    setMounted(true);
    setIsDark(resolvedTheme === "dark");
  }, [resolvedTheme]);

  if (!mounted) {
    return (
      <div className="h-8 w-14 rounded-full border border-slate-200 bg-slate-100 dark:border-slate-700 dark:bg-slate-800" />
    );
  }

  function handleToggle() {
    const next = isDark ? "light" : "dark";
    setIsDark(!isDark);

    if (!document.startViewTransition) {
      setTheme(next);
      return;
    }
    document.startViewTransition(() => {
      setTheme(next);
    });
  }

  return (
    <button
      onClick={handleToggle}
      aria-label={isDark ? "Ativar tema claro" : "Ativar tema escuro"}
      aria-pressed={isDark}
      className="relative flex h-8 w-14 cursor-pointer items-center rounded-full border border-slate-200 bg-white px-1 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 focus-visible:ring-offset-2 dark:border-slate-700 dark:bg-slate-800"
    >
      {/* Ícones fixos */}
      <span className="pointer-events-none relative z-0 flex w-full items-center justify-between px-0.5">
        <SunMedium
          className="h-3.5 w-3.5 transition-colors duration-300"
          style={{ color: isDark ? "#fff" : "#fff" }}
        />
        <MoonStar
          className="h-3.5 w-3.5 transition-colors duration-300"
          style={{
            color: isDark ? "#fff" : "#0f172a",
            fill: isDark ? "transparent" : "#0f172a",
          }}
        />
      </span>

      {/* Thumb deslizante */}
      <span
        aria-hidden="true"
        className="pointer-events-none absolute top-0.7 h-5 w-5 rounded-full bg-sky-500 shadow-[0_2px_8px_rgba(14,165,233,0.5)]"
        style={{
          left: "2px",
          transform: isDark
            ? "translateX(calc(3.5rem - 1.835rem))"
            : "translateX(0px)",
          transition: "transform 450ms cubic-bezier(0.34, 1.56, 0.64, 1)",
        }}
      />
    </button>
  );
}
