import Container from "./components/Layout/Container";
import { getServerSession } from "./api/lib";
import { decodeJwt } from "@/utils/api";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

function formatLabel(value: string) {
  return value.replace(/_/g, " ");
}

function formatValue(value: unknown) {
  if (value === null) return "null";
  if (value === undefined) return "";
  if (typeof value === "object") return JSON.stringify(value, null, 2);
  return String(value);
}

export default async function Home() {
  const session = await getServerSession();
  const payload = session ? decodeJwt(session.accessToken) : {};
  const rows = Object.entries(payload).sort(([left], [right]) =>
    left.localeCompare(right),
  );

  return (
    <Container>
      <section className="mx-auto w-full max-w-7xl px-0 sm:px-2 lg:px-4">
        <Card className="overflow-hidden border-border/70 bg-card/90 shadow-soft dark:border-white/10 dark:bg-card/95 dark:shadow-[0_24px_80px_-40px_rgba(0,0,0,0.8)]">
          <CardHeader className="border-b border-slate-200/60 bg-slate-50/80 px-6 py-6 sm:px-8 dark:border-white/10 dark:bg-white/[0.03]">
            <p className="inline-flex w-fit items-center rounded-full border border-emerald-500/20 bg-emerald-500/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.24em] text-emerald-700 dark:text-emerald-300">
              Autenticado via Keycloak
            </p>
            <CardTitle className="mt-3 font-heading text-3xl sm:text-4xl">
              Payload do JWT
            </CardTitle>
            <CardDescription className="max-w-2xl text-base text-muted-foreground sm:text-lg">
              Dados decodificados do access token recebido apos o retorno do
              SSO.
            </CardDescription>
          </CardHeader>
          <CardContent className="p-0">
            <div className="overflow-x-auto">
              <table className="min-w-full border-separate border-spacing-0">
                <thead className="sticky top-0 z-10 bg-white/95 backdrop-blur dark:bg-card/95">
                  <tr>
                    <th className="border-b border-slate-200/60 px-6 py-4 text-left text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground sm:px-8 dark:border-white/10">
                      Campo
                    </th>
                    <th className="border-b border-slate-200/60 px-6 py-4 text-left text-xs font-semibold uppercase tracking-[0.18em] text-muted-foreground sm:px-8 dark:border-white/10">
                      Valor
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {rows.map(([key, value], index) => (
                    <tr
                      key={key}
                      className={
                        index % 2 === 0
                          ? "bg-slate-50/60 dark:bg-white/[0.03]"
                          : "bg-transparent"
                      }
                    >
                      <td className="w-[280px] border-b border-slate-200/60 px-6 py-5 align-top text-sm font-semibold text-primary sm:px-8 dark:border-white/10 dark:text-cyan-300">
                        {formatLabel(key)}
                      </td>
                      <td className="border-b border-slate-200/60 px-6 py-5 align-top text-sm text-foreground sm:px-8 dark:border-white/10 dark:text-slate-100">
                        <pre className="max-w-full whitespace-pre-wrap break-words font-mono text-[0.92rem] leading-6 text-foreground/90 dark:text-slate-100/90">
                          {formatValue(value)}
                        </pre>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </CardContent>
        </Card>
      </section>
    </Container>
  );
}
