# Boilerplate de Variantes Visuais com CVA

## Regras de Variantes de Componentes

- Use CVA para componentes com múltiplos estados visuais.
- Exporte os tipos das variantes para reutilização.
- Use a função `cn` para mesclar classes extras dinâmicas.

### Exemplo: Componente de Badge Customizado

```tsx
// src/components/ui/custom-badge.tsx
import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const badgeVariants = cva(
  "inline-flex items-center rounded-md px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
  {
    variants: {
      intent: {
        primary: "border-transparent bg-primary text-primary-foreground hover:bg-primary/80",
        secondary: "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
        danger: "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80",
        outline: "text-foreground border border-input bg-background hover:bg-accent hover:text-accent-foreground",
      },
      size: {
        sm: "text-[10px] px-2 py-0",
        md: "text-xs px-2.5 py-0.5",
        lg: "text-sm px-3 py-1",
      },
    },
    defaultVariants: {
      intent: "primary",
      size: "md",
    },
  }
);

export interface CustomBadgeProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof badgeVariants> {}

export function CustomBadge({ className, intent, size, ...props }: CustomBadgeProps) {
  return (
    <div className={cn(badgeVariants({ intent, size }), className)} {...props} />
  );
}
```
