import Image from "next/image";
import Link from "next/link";

import { Card, CardContent } from "@/components/ui/card";

export function DamInfoCard() {
  return (
    <Card className="border border-border/60 shadow-sm transition-all duration-300 hover:scale-[1.02] hover:shadow-[0_0_22px_4px_rgba(14,165,233,0.3)] dark:border-border/40">
      <CardContent className="flex flex-col items-center gap-4 py-6 text-center">
        <Image
          src="/municipio.png"
          alt="Imagem do município do Rio de Janeiro"
          width={160}
          height={162}
          className="h-auto w-40 object-contain"
        />
        <p className="text-sm leading-relaxed text-foreground/80">
          Acesse o{" "}
          <Link
            href="https://daminternet.rio.rj.gov.br/"
            target="_blank"
            rel="noopener noreferrer"
            className="font-semibold text-sky-600 hover:text-sky-500 dark:text-sky-400 dark:hover:text-sky-300"
          >
            DAM - SISTEMA DE DÍVIDA ATIVA MUNICIPAL
          </Link>{" "}
          para maiores informações sobre débitos de taxas municipais e certidões de
          situação fiscal, ou dirija-se à Procuradoria da Dívida Ativa ou a um de nossos
          Postos de Atendimento.
        </p>
      </CardContent>
    </Card>
  );
}
