import Link from "next/link";
import { ExternalLink, House, SearchCheck, FileText, CreditCard } from "lucide-react";

import Container from "@/components/layout/container";
import { SidebarImoveis } from "@/components/portal/sidebar-imoveis";
import { DamInfoCard } from "@/components/portal/dam-info-card";
import { DividaAtivaForm } from "@/components/portal/divida-ativa-form";
import { StepCard, type StepCardProps } from "@/components/portal/step-card";

const steps: Omit<StepCardProps, "step">[] = [
  {
    title: "Cadastre seus imóveis",
    description:
      "Adicione na lateral esquerda os imóveis dos quais você é contribuinte, informando o número da inscrição imobiliária.",
    icon: House,
    accent: "primary",
  },
  {
    title: "Consulte sua dívida",
    description:
      "Verifique os débitos inscritos em dívida ativa referentes a IPTU, taxas municipais, ISS, ITBI e multas.",
    icon: SearchCheck,
    accent: "secondary",
  },
  {
    title: "Emita o DAM",
    description:
      "Gere o Documento de Arrecadação Municipal (DAM) com o valor atualizado para pagamento do débito selecionado.",
    icon: FileText,
    accent: "amber",
  },
  {
    title: "Efetue o pagamento",
    description:
      "Pague o DAM em qualquer agência bancária, internet banking ou mediante débito automático.",
    icon: CreditCard,
    accent: "violet",
  },
];

export default function Home() {
  return (
    <Container>
      <div className="flex flex-col gap-6 lg:flex-row">
        <div className="w-full shrink-0 lg:w-72">
          <SidebarImoveis />
        </div>

        <div className="flex flex-1 flex-col gap-6 xl:flex-row">
          <section className="flex-1 space-y-6">
            <div>
              <h1 className="font-heading text-xl font-bold uppercase tracking-tight text-foreground sm:text-2xl">
                Dívida Ativa: entenda como funciona
              </h1>
              <p className="mt-3 text-sm leading-relaxed text-foreground/80">
                Quando o Município não recebe a comprovação do pagamento de determinado tributo ou
                multa administrativa, a dívida é encaminhada à Procuradoria Geral do Município
                (PGM), onde passa a ser inscrita em dívida ativa — abrangendo débitos de IPTU,
                taxas municipais, ISS, ITBI e multas.
              </p>
            </div>

            {/* Como funciona */}
            <div className="space-y-4">
              <div>
                <h2 className="text-base font-semibold text-foreground sm:text-lg">
                  Como funciona
                </h2>
                <p className="mt-1 text-sm text-muted-foreground">
                  Em poucos passos você consulta e regulariza seus débitos.
                </p>
              </div>

              <div className="grid gap-4 sm:grid-cols-2">
                {steps.map((step, index) => (
                  <StepCard key={step.title} step={index + 1} {...step} />
                ))}
              </div>
            </div>

            <DividaAtivaForm />

            <p className="text-sm text-muted-foreground">
              Clique{" "}
              <Link
                href="https://daminternet.rio.rj.gov.br/FAQ/DividaAtiva"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-1 font-semibold text-primary underline underline-offset-2 hover:text-primary/70"
              >
                aqui
                <ExternalLink className="h-3 w-3" />
              </Link>{" "}
              para acessar perguntas frequentes relacionadas à dívida ativa.
            </p>
          </section>

          <div className="w-full shrink-0 xl:w-64">
            <DamInfoCard />
          </div>
        </div>
      </div>
    </Container>
  );
}
