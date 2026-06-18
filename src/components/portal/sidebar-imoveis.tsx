"use client";

import { useState } from "react";
import { toast } from "sonner";
import Image from "next/image";
import { Building2, Plus } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { cn } from "@/lib/utils";

export function SidebarImoveis() {
  const [inscricao, setInscricao] = useState("");

  function handleSalvar(e: React.FormEvent) {
    e.preventDefault();
    console.log("Salvar imóvel com inscrição:", inscricao);
    if (!inscricao.trim()) {
      toast.error("Informe a Inscrição Imobiliária.");
      return;
    }
    toast.success("Imóvel incluído com sucesso!");
    setInscricao("");
  }

  return (
    <aside className="contents">
      {/* Card Meus Imóveis */}
      <Card className="border-border/30 shadow-sm transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_22px_4px_rgba(14,165,233,0.3)]">
        <CardHeader className="border-b border-border/20 pb-3">
          <CardTitle className="flex items-center gap-2 text-sm font-bold uppercase tracking-widest text-foreground">
            <Building2 className="h-4 w-4 shrink-0 text-sky-500" />
            Meus Imóveis
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4 pt-4">
          <p className="text-sm text-muted-foreground">
            Cadastre seu imóvel para consultar 2ª via do IPTU, cotas em atraso e
            pagamentos efetuados.
          </p>
          <p className="rounded-lg bg-muted/60 px-3 py-2 text-xs text-muted-foreground">
            Nenhum imóvel cadastrado. Informe a inscrição imobiliária abaixo
            para começar.
          </p>

          <form onSubmit={handleSalvar} className="space-y-3">
            <div className="space-y-1.5">
              <label
                htmlFor="inscricao-imobiliaria"
                className="text-xs font-semibold text-foreground"
              >
                Incluir novo imóvel
              </label>
              <input
                id="inscricao-imobiliaria"
                type="text"
                inputMode="numeric"
                maxLength={8}
                value={inscricao}
                onChange={(e) =>
                  setInscricao(e.target.value.replace(/\D/g, "").slice(0, 8))
                }
                placeholder="Inscrição imobiliária"
                aria-label="Inscrição imobiliária do imóvel"
                className={cn(
                  "w-full rounded-md border border-input bg-background px-3 py-2 text-sm text-foreground",
                  "placeholder:text-muted-foreground",
                  "focus:outline-none focus:ring-2 focus:ring-sky-500/50 focus:ring-offset-1",
                  "transition-colors",
                )}
              />
            </div>
            <Button
              type="submit"
              size="sm"
              className="w-full bg-primary hover:bg-primary/90 text-white"
            >
              <Plus className="mr-1.5 h-3.5 w-3.5" />
              Salvar imóvel
            </Button>
          </form>
        </CardContent>
      </Card>

      {/* Card Nota Carioca */}
      <Card className="overflow-hidden border-border/30 shadow-sm transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_22px_4px_rgba(14,165,233,0.3)]">
        <div className="bg-muted/30">
          <Image
            src="/nota-carioca.jpg"
            alt="Nota Carioca"
            width={260}
            height={200}
            className="h-auto w-full object-contain"
          />
        </div>
        <CardContent className="space-y-3 pt-4">
          <p className="text-sm leading-snug text-foreground/80">
            Você não está cadastrado no Nota Carioca. Clique abaixo para se
            cadastrar.
          </p>
          <Button
            type="button"
            size="sm"
            className="w-full bg-primary hover:bg-primary/90 text-white"
            onClick={() => toast.info("Redirecionando para o Nota Carioca...")}
          >
            Ver notas recebidas no mês
          </Button>
        </CardContent>
      </Card>
    </aside>
  );
}
