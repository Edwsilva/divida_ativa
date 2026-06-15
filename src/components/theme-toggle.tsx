"use client";

import { MoonStar, SunMedium } from "lucide-react";
import { useEffect, useState } from "react";
import { useTheme } from "next-themes";

import { Switch, SwitchThumb } from "./ui/switch";
import { cn } from "@/lib/utils";

export function ThemeToggle() {
  const [mounted, setMounted] = useState(false);
  const { resolvedTheme, setTheme } = useTheme();
  const [checked, setChecked] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  // Sincroniza o estado local com o tema atual
  useEffect(() => {
    if (mounted) {
      setChecked(resolvedTheme === "dark");
    }
  }, [resolvedTheme, mounted]);

  if (!mounted) {
    return (
      <Switch
        checked={false}
        disabled
        aria-label="Tema"
        className="pointer-events-none border border-slate-300/80 bg-slate-100 dark:border-slate-600/80 dark:bg-slate-800"
      >
        <SwitchThumb />
      </Switch>
    );
  }

  const isDark = checked;

  function handleThemeChange(value: boolean) {
    // Move o botão imediatamente
    setChecked(value);

    const next = value ? "dark" : "light";

    // Aguarda a animação do switch terminar
    setTimeout(() => {
      if (!document.startViewTransition) {
        setTheme(next);
        return;
      }

      document.startViewTransition(() => {
        setTheme(next);
      });
    }, 250); // ajuste entre 200 e 300ms conforme desejar
  }

  return (
    <div className="relative inline-flex items-center">
      <span className="pointer-events-none absolute inset-0 z-0 flex items-center justify-between px-2.5">
        <SunMedium
          className={cn(
            "h-3.5 w-3.5 transition-colors duration-300",
            isDark ? "text-slate-500" : "text-amber-400",
          )}
        />
        <MoonStar
          className={cn(
            "h-3.5 w-3.5 transition-all duration-300",
            isDark
              ? "text-slate-200 fill-transparent"
              : "text-black fill-black",
          )}
        />
      </span>

      <Switch
        checked={checked}
        onCheckedChange={handleThemeChange}
        aria-label={checked ? "Ativar tema claro" : "Ativar tema escuro"}
        className="bg-transparent"
      >
        <SwitchThumb className="transition-transform duration-300 ease-in-out" />
      </Switch>
    </div>
  );
}
