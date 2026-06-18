import { requestDividaAtivaBackend } from "./lib/backend";
import type { DividaAtiva } from "@/types";

export async function GET() {
  return requestDividaAtivaBackend<DividaAtiva[]>("/divida-ativa");
}
