"use client";
import { LogOut } from "lucide-react";
import { useState } from "react";

import { Button } from "@/components/ui/button";

type LogoutButtonProps = {
  givenName?: string;
};

function logoutGovBr(): Promise<void> {
  return new Promise((resolve) => {
    try {
      const iframe = document.createElement("iframe");
      iframe.style.display = "none";

      const cleanup = () => {
        clearTimeout(fallback);
        if (iframe.parentNode) {
          document.body.removeChild(iframe);
        }
        resolve();
      };

      iframe.onload = cleanup;
      iframe.onerror = cleanup;
      const fallback = setTimeout(cleanup, 5000);

      iframe.src = "/api/auth/logout-govbr-url";
      document.body.appendChild(iframe);
    } catch (error) {
      console.error("[logoutGovBr] Falha no logout federado", error);
      resolve();
    }
  });
}

export default function LogoutButton({ givenName }: LogoutButtonProps) {
  const [isLoggingOut, setIsLoggingOut] = useState(false);
  const isLogged = Boolean(givenName);

  const handleLogout = async () => {
    setIsLoggingOut(true);
    try {
      await logoutGovBr();
      window.location.href = "/api/auth/logout";
    } catch (error) {
      console.error("[handleLogout] Erro no fluxo de logout", error);
      setIsLoggingOut(false);
    }
  };

  return (
    <Button
      type="button"
      variant="default"
      className="min-w-[210px] rounded-full border-slate-300 bg-white px-4 py-2 text-slate-700 shadow-[0_1px_2px_rgba(15,23,42,0.06)] transition hover:bg-slate-50 hover:text-slate-900 dark:border-white/15 dark:bg-white/5 dark:text-white dark:shadow-[0_0_0_1px_rgba(255,255,255,0.08)] dark:hover:bg-white/10"
      onClick={handleLogout}
      disabled={isLoggingOut}
    >
      <span className="flex items-center gap-2 text-sm font-semibold leading-none text-slate-700 dark:text-white">
        <span className="truncate">
          {isLoggingOut
            ? "Carregando..."
            : isLogged
              ? `Olá, ${givenName}`
              : "Sair"}
        </span>
        {!isLoggingOut && (
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-cyan-900 bg-white  text-cyan-900 shadow-sm dark:border-white/20 dark:bg-white/5 dark:text-white">
            <LogOut className="h-4 w-4" />
          </span>
        )}
      </span>
    </Button>
  );
}
