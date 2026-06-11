import Link from "next/link";
import Image from "next/image";

const Footer = () => {
  return (
    <footer className="mt-auto border-t border-white/15 bg-[#004a80] px-4 py-6 text-center text-sm text-white shadow-[0_-2px_0_rgba(255,255,255,0.25)] dark:border-border/60 dark:bg-card/80 dark:text-muted-foreground">
      <div className="mx-auto flex max-w-7xl flex-col items-center gap-4 text-center">
        <Link
          href="/"
          className="flex shrink-0 items-center justify-center rounded-2xl bg-white/10 p-2 shadow-sm ring-1 ring-white/15 backdrop-blur-sm dark:bg-background/80 dark:ring-border/60"
        >
          <Image
            className="h-auto w-28"
            src="/logoPrefeitura.png"
            width={160}
            height={110}
            alt="Logo"
          />
        </Link>
        <p className="max-w-3xl text-balance leading-6 text-white/90 dark:text-muted-foreground">
          Prefeitura da Cidade do Rio de Janeiro Sede: Rua Afonso Cavalcanti,
          455 - Cidade Nova - 20211-110
        </p>
      </div>
    </footer>
  );
};

export default Footer;
