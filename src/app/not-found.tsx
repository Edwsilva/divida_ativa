import Link from "next/link";
import Container from "@/app/components/Layout/Container";
import { Button } from "@/components/ui/button";

export default function NotFound() {
  return (
    <Container className="flex min-h-[60vh] items-center justify-center">
      <div className="mx-auto flex max-w-xl flex-col items-center gap-4 rounded-3xl border border-border/70 bg-card/90 px-8 py-10 text-center shadow-soft">
        <p className="font-heading text-6xl font-bold tracking-tight text-primary sm:text-7xl">
          404
        </p>
        <h1 className="font-heading text-2xl font-semibold text-foreground sm:text-3xl">
          Pagina nao encontrada
        </h1>
        <p className="text-sm leading-6 text-muted-foreground sm:text-base">
          A URL acessada nao existe ou nao esta mais disponivel.
        </p>
        <Button asChild className="mt-2">
          <Link href="/">Ir para inicio</Link>
        </Button>
      </div>
    </Container>
  );
}
