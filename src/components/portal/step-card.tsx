import type { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

export type StepAccent = "primary" | "secondary" | "amber" | "violet";

export interface StepCardProps {
  step: number;
  title: string;
  description: string;
  icon: LucideIcon;
  accent?: StepAccent;
}

const accentIconStyles: Record<StepAccent, string> = {
  primary: "bg-primary/10 text-primary",
  secondary: "bg-secondary/10 text-secondary",
  amber: "bg-amber-500/10 text-amber-600 dark:text-amber-400",
  violet: "bg-violet-500/10 text-violet-600 dark:text-violet-400",
};

const accentBorderStyles: Record<StepAccent, string> = {
  primary: "hover:border-primary/40",
  secondary: "hover:border-secondary/40",
  amber: "hover:border-amber-500/40",
  violet: "hover:border-violet-500/40",
};

export function StepCard({ step, title, description, icon: Icon, accent = "primary" }: StepCardProps) {
  return (
    <div
      className={cn(
        "group relative flex flex-col gap-4 rounded-2xl border border-border bg-card p-6 transition-all duration-200 hover:-translate-y-1 hover:shadow-lg",
        accentBorderStyles[accent],
      )}
    >
      <div className="flex items-center justify-between">
        <span
          className={cn(
            "flex size-12 items-center justify-center rounded-xl",
            accentIconStyles[accent],
          )}
        >
          <Icon className="size-6" aria-hidden="true" />
        </span>
        <span
          className="text-2xl font-semibold tabular-nums text-muted-foreground/40"
          aria-hidden="true"
        >
          {String(step).padStart(2, "0")}
        </span>
      </div>

      <div className="space-y-1">
        <h3 className="text-base font-semibold text-foreground">{title}</h3>
        <p className="text-sm leading-relaxed text-muted-foreground">{description}</p>
      </div>
    </div>
  );
}
