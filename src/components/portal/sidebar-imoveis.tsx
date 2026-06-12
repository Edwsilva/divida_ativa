"use client";

import { useState } from "react";
import { toast } from "sonner";
import Image from "next/image";
import { Building2 } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { cn } from "@/lib/utils";

export function SidebarImoveis() {
  const [inscricao, setInscricao] = useState("");

  function handleSalvar(e: React.FormEvent) {
    e.preventDefault();
    if (!inscricao.trim()) {
      toast.error("Informe a Inscrição Imobiliária.");
      return;
    }
    toast.success("Imóvel incluído com sucesso!");
    setInscricao("");
  }

  return (
    <aside className="space-y-4">
      <Card className="border-border/70 shadow-sm">
        <CardHeader className="border-b border-border/50 pb-3">
          <CardTitle className="flex items-center gap-2 text-sm font-bold uppercase tracking-widest text-foreground">
            <Building2 className="h-4 w-4 shrink-0 text-primary" />
            Meus Imóveis
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4 pt-4 text-sm text-muted-foreground">
          <p>
            Cadastre o seu imóvel para consultar 2ª via do seu IPTU, as cotas em
            atraso e pagamentos efetuados.
          </p>
          <p className="text-xs">
            Você não tem nenhum imóvel cadastrado. Favor informar os dados do
            imóvel para visualizar a cota do IPTU.
          </p>

          <form onSubmit={handleSalvar} className="space-y-3">
            <div className="space-y-1.5">
              <label
                htmlFor="inscricao-imobiliaria"
                className="text-xs font-semibold text-foreground"
              >
                Incluir novo Imóvel:
              </label>
              <input
                id="inscricao-imobiliaria"
                type="text"
                value={inscricao}
                onChange={(e) => setInscricao(e.target.value)}
                placeholder="Inscrição Imobiliária"
                className={cn(
                  "w-full rounded-md border border-input bg-background px-3 py-2 text-sm text-foreground",
                  "placeholder:text-muted-foreground",
                  "focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-1",
                  "transition-colors",
                )}
              />
            </div>
            <Button
              type="submit"
              size="sm"
              className="mt-3 w-full rounded px-3 py-1.5 text-xs font-bold uppercase tracking-wide text-white transition-opacity hover:opacity-90"
              style={{ backgroundColor: "#189abf" }}
            >
              Salvar
            </Button>
          </form>
        </CardContent>
      </Card>

      <div className="rounded border border-border/60 bg-card p-0 text-center shadow-sm">
        <Image
          src="/nota-carioca.jpg"
          alt="Nota Carioca"
          width={260}
          height={200}
          className="h-auto w-full rounded-t object-contain"
        />
        <div className="px-3 py-3">
          <p className="text-sm leading-snug text-foreground/80">
            Você não está cadastrado no Nota Carioca. Clique aqui para se
            cadastrar.
          </p>
          <button
            type="button"
            onClick={() => toast.info("Redirecionando para o Nota Carioca...")}
            className="mt-3 w-full rounded px-3 py-1.5 text-xs font-bold uppercase tracking-wide text-white transition-opacity hover:opacity-90"
            style={{ backgroundColor: "#189abf" }}
          >
            Ver notas recebidas no mês
          </button>
        </div>
      </div>
    </aside>
  );
}
