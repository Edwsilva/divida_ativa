import { requestDividaAtivaBackend } from "../lib/backend";
import type { DividaAtiva } from "@/types";

type RouteContext = {
  params: Promise<{ id: string }>;
};

export async function GET(_request: Request, context: RouteContext) {
  const { id } = await context.params;
  return requestDividaAtivaBackend<DividaAtiva>(
    `/divida-ativa/${encodeURIComponent(id)}`,
  );
}
