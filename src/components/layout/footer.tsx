import Image from "next/image";
import Link from "next/link";
import Container from "./container";

export type FooterLinkItem = {
  label: string;
  href: string;
};

const DEFAULT_LINKS: FooterLinkItem[] = [
  { label: "Prefeitura do Rio", href: "https://www.rio.rj.gov.br/" },
  { label: "Carioca Digital", href: "https://home.carioca.rio" },
];

export type FooterProps = {
  links?: FooterLinkItem[];
};

export default function Footer({ links = DEFAULT_LINKS }: FooterProps) {
  const year = new Date().getFullYear();

  return (
    <footer className="mt-auto bg-[#013a61] text-white">
      <Container>
        <div className="flex flex-col gap-8 py-10">
          <div className="flex flex-col items-center gap-6 md:flex-row md:items-center md:justify-between">
            <Link href="/" className="inline-block leading-none">
              <Image
                src="/logoPrefeitura.png"
                width={100}
                height={60}
                alt="Prefeitura da Cidade do Rio de Janeiro"
                className="h-auto w-[100px]"
              />
            </Link>

            <nav aria-label="Links institucionais">
              <ul className="flex flex-wrap items-center justify-center gap-x-6 gap-y-2">
                {links.map((item) => (
                  <li key={item.href}>
                    <a
                      href={item.href}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-sm font-medium text-white/70 transition-colors hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/60 focus-visible:ring-offset-2 focus-visible:ring-offset-[#013a61]"
                    >
                      {item.label}
                    </a>
                  </li>
                ))}
              </ul>
            </nav>
          </div>

          <div className="border-t border-white/10 pt-6 text-center text-sm text-white/60 md:text-left">
            © {year} Prefeitura da Cidade do Rio de Janeiro. Todos os direitos reservados.
          </div>
        </div>
      </Container>
    </footer>
  );
}
