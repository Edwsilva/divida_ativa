"use client";
import { LogOut } from "lucide-react";
import { useState } from "react";
import { userInfo } from "os";
import { cn } from "@/lib/utils";

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

      iframe.src = "/logout-govbr-url";
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
      window.location.href = "/logout";
    } catch (error) {
      console.error("[handleLogout] Erro no fluxo de logout", error);
      setIsLoggingOut(false);
    }
  };

  if (isLoggingOut) {
    return <span className="font-semibold">Carregando...</span>;
  }

  if (!isLogged) {
    return null;
  }

  return (
    <div className="flex items-center gap-1.5">
      {isLoggingOut ? (
        <span className="font-semibold">Saindo...</span>
      ) : (
        <span className="font-semibold">Olá, {givenName}</span>
      )}
      <button
        type="button"
        className={cn(
          "flex cursor-pointer items-center justify-start gap-1.5 border-0 bg-transparent text-base text-foreground transition-colors",
          "hover:text-primary",
          "disabled:cursor-not-allowed disabled:text-muted-foreground disabled:opacity-50"
        )}
        onClick={handleLogout}
        disabled={isLoggingOut}
        aria-label="Sair"
      >
        <LogOut size={25} aria-hidden="true" />
      </button>
    </div>
  );
}
