import Link from "next/link";
import { ExternalLink } from "lucide-react";

import Container from "@/components/layout/container";
import { SidebarImoveis } from "@/components/portal/sidebar-imoveis";
import { DamInfoCard } from "@/components/portal/dam-info-card";
import { DividaAtivaForm } from "@/components/portal/divida-ativa-form";
import { StepCarousel } from "@/components/portal/step-carousel";

export default function Home() {
  return (
    <Container className="space-y-8 py-6">
      {/* Hero */}
      <section>
        <div className="overflow-hidden rounded-2xl border border-primary/15 bg-gradient-to-br from-primary/10 to-secondary/10 p-8 md:p-12 dark:border-primary/30 dark:from-primary/30 dark:to-secondary/20">
          <div className="max-w-2xl">
            <span className="inline-flex items-center rounded-full bg-primary/10 px-3 py-1 text-xs font-medium uppercase tracking-wider text-primary dark:border dark:border-primary">
              Procuradoria Geral do Município — PGM
            </span>
            <h1 className="mt-4 text-3xl font-semibold text-foreground md:text-4xl">
              Dívida Ativa Municipal
            </h1>
            <p className="mt-3 text-muted-foreground md:text-lg">
              Consulte e regularize seus débitos inscritos em dívida ativa — IPTU, taxas municipais, ISS, ITBI e multas —
              de forma rápida e segura diretamente pelo portal.
            </p>
          </div>
        </div>
      </section>

      {/* Como funciona + Serviços */}
      <section className="space-y-5">
        <div>
          <h2 className="text-lg font-semibold text-foreground sm:text-xl">Como funciona</h2>
          <p className="mt-1 text-sm text-muted-foreground">
            Em poucos passos você consulta e regulariza seus débitos.
          </p>
        </div>

        <StepCarousel />

        {/* Serviços abaixo dos slides */}
        <div className="space-y-3 rounded-2xl border border-border/25 bg-card p-6 shadow-sm">
          <div>
            <h3 className="text-base font-semibold text-foreground">Serviços disponíveis</h3>
            <p className="mt-0.5 text-sm text-muted-foreground">
              Selecione o serviço desejado e clique em <strong className="text-foreground">Confirmar</strong>.
            </p>
          </div>

          <DividaAtivaForm />

          <p className="border-t border-border/50 pt-4 text-sm text-muted-foreground">
            Clique{" "}
            <Link
              href="https://daminternet.rio.rj.gov.br/FAQ/DividaAtiva"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1 font-semibold text-primary underline underline-offset-2 hover:text-primary/90"
            >
              aqui
              <ExternalLink className="h-3 w-3" />
            </Link>{" "}
            para acessar perguntas frequentes relacionadas à dívida ativa.
          </p>
        </div>
      </section>

      {/* Sidebar + DamInfoCard */}
      <section className="pb-4">
        <div className="grid gap-4 sm:grid-cols-3">
          <SidebarImoveis />
          <DamInfoCard />
        </div>
      </section>
    </Container >
  );
}
