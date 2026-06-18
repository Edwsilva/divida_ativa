import { requestImoveisBackend } from "../lib/backend";

type RouteContext = {
  params: Promise<{ id: string }>;
};

export async function DELETE(_request: Request, context: RouteContext) {
  const { id } = await context.params;

  return requestImoveisBackend<null>(`/imoveis/${encodeURIComponent(id)}`, {
    method: "DELETE",
  });
}
