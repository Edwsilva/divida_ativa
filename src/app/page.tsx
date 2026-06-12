import Link from "next/link";
import { ExternalLink } from "lucide-react";

import Container from "@/components/layout/container";
import { SidebarImoveis } from "@/components/portal/sidebar-imoveis";
import { DamInfoCard } from "@/components/portal/dam-info-card";
import { DividaAtivaForm } from "@/components/portal/divida-ativa-form";

export default function Home() {
  return (
    <Container>
      <div className="flex flex-col gap-6 lg:flex-row">
        <div className="w-full shrink-0 lg:w-72">
          <SidebarImoveis />
        </div>

        <div className="flex flex-1 flex-col gap-6 xl:flex-row">
          <section className="flex-1 space-y-5">
            <h1 className="font-heading text-xl font-bold uppercase tracking-tight text-foreground sm:text-2xl">
              Dívida Ativa: entenda como funciona
            </h1>

            <p className="text-sm leading-relaxed text-foreground/80">
              Quando o Município não recebe a comprovação do pagamento de determinado tributo ou multa
              administrativa, a dívida permanece registrada nos arquivos do órgão lançador, em geral, a
              Secretaria Municipal de Fazenda. Transcorrido o prazo para pagamento no órgão de origem, o
              cadastro dos devedores é encaminhado à Procuradoria para que a dívida seja cobrada. É aí
              que esse débito passa a estar inscrito em dívida ativa (débitos relativos a IPTU, taxas
              municipais, ISS, ITBI e multas). A PGM dispõe de uma equipe dedicada à cobrança desses
              débitos, a Procuradoria da Dívida Ativa (PG/PDA). Em primeiro lugar, a PDA cobra
              amigavelmente a dívida, mediante o envio de cartas aos contribuintes. As cartas informam a
              existência do débito e fornecem os meios e/ou instruções para o seu pagamento.
            </p>

            <p className="text-sm leading-relaxed text-foreground/80">
              Para ter acesso aos serviços relacionados à dívida ativa imobiliária,{" "}
              <strong className="font-semibold text-foreground">
                cadastre seus imóveis, na seção &ldquo;Meus Imóveis&rdquo; presente na lateral esquerda
                desta tela.
              </strong>
            </p>

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
