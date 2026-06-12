# Boilerplate de Formulários e Validação (Zod + shadcn)

## Regras de Formulário

- Sempre use schemas do Zod.
- Feedback de erro em tempo real abaixo do campo.
- Feedback global de envio usando Sonner.

### Exemplo: Formulário de Cadastro de Produto

```tsx
// src/components/forms/product-form.tsx
"use client";

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { Loader2 } from "lucide-react";

import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";

const productSchema = z.object({
  name: z.string().min(3, "O nome deve ter pelo menos 3 caracteres"),
  price: z.coerce.number().min(0.01, "O preço deve ser maior que zero"),
});

type ProductFormValues = z.infer<typeof productSchema>;

export function ProductForm() {
  const form = useForm<ProductFormValues>({
    resolver: zodResolver(productSchema),
    defaultValues: { name: "", price: 0 },
  });

  const { isSubmitting } = form.formState;

  async function onSubmit(data: ProductFormValues) {
    try {
      // Simulação de API
      await new Promise((resolve) => setTimeout(resolve, 1000));
      toast.success("Produto criado com sucesso!");
      form.reset();
    } catch {
      toast.error("Erro ao criar o produto. Tente novamente.");
    }
  }

  return (
    <Form {...form}>
      <form
        onSubmit={form.handleSubmit(onSubmit)}
        className="space-y-4 max-w-md"
      >
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Nome do Produto</FormLabel>
              <FormControl>
                <Input placeholder="Ex: Teclado Mecânico" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="price"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Preço (R\$)</FormLabel>
              <FormControl>
                <Input
                  type="number"
                  step="0.01"
                  placeholder="0.00"
                  {...field}
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button type="submit" disabled={isSubmitting} className="w-full">
          {isSubmitting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
          Salvar Produto
        </Button>
      </form>
    </Form>
  );
}
```
