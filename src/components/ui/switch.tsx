"use client";

import * as React from "react";
import * as SwitchPrimitive from "@radix-ui/react-switch";

import { cn } from "@/lib/utils";

const Switch = React.forwardRef<
  React.ElementRef<typeof SwitchPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof SwitchPrimitive.Root>
>(({ className, ...props }, ref) => (
  <SwitchPrimitive.Root
    ref={ref}
    className={cn(
      "peer inline-flex h-8 w-16 shrink-0 cursor-pointer items-center overflow-hidden rounded-full border border-transparent p-1 shadow-sm transition-colors duration-700 ease-in-out focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:ring-offset-background disabled:cursor-not-allowed disabled:opacity-50 data-[state=checked]:bg-slate-800 data-[state=unchecked]:bg-slate-100 dark:data-[state=unchecked]:bg-slate-800",
      className,
    )}
    {...props}
  />
));
Switch.displayName = SwitchPrimitive.Root.displayName;

const SwitchThumb = React.forwardRef<
  React.ElementRef<typeof SwitchPrimitive.Thumb>,
  React.ComponentPropsWithoutRef<typeof SwitchPrimitive.Thumb>
>(({ className, ...props }, ref) => (
  <SwitchPrimitive.Thumb
    ref={ref}
    className={cn(
      "pointer-events-none relative z-20 block h-6 w-6 rounded-full bg-sky-500 shadow-[0_2px_8px_rgba(14,165,233,0.45)] ring-0 transition-transform duration-700 ease-in-out data-[state=checked]:translate-x-8 data-[state=unchecked]:translate-x-0",
      className,
    )}
    {...props}
  />
));
SwitchThumb.displayName = SwitchPrimitive.Thumb.displayName;

export { Switch, SwitchThumb };
