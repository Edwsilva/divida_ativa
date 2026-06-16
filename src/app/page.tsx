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
        <div className="overflow-hidden rounded-2xl border border-sky-500/15 bg-gradient-to-br from-sky-500/10 via-background to-emerald-500/10 p-8 md:p-10 dark:border-sky-500/25 dark:from-sky-500/20 dark:to-emerald-500/15">
          <span className="inline-flex items-center rounded-full bg-sky-500/10 px-3 py-1 text-xs font-medium uppercase tracking-wider text-sky-600 dark:border dark:border-sky-500/40 dark:text-sky-400">
            Procuradoria Geral do Município — PGM
          </span>
          <h1 className="font-heading mt-4 text-2xl font-bold uppercase tracking-tight text-foreground sm:text-3xl">
            Dívida Ativa Municipal
          </h1>
          <p className="mt-3 max-w-2xl text-sm leading-relaxed text-foreground/70 md:text-base">
            Consulte e regularize seus débitos inscritos em dívida ativa — IPTU, taxas municipais, ISS, ITBI e multas —
            de forma rápida e segura diretamente pelo portal.
          </p>
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
        <div className="space-y-3 rounded-2xl border border-border/60 bg-card p-6 shadow-sm">
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
              className="inline-flex items-center gap-1 font-semibold text-sky-600 underline underline-offset-2 hover:text-sky-500 dark:text-sky-400 dark:hover:text-sky-300"
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
    </Container>
  );
}
