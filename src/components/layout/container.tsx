import { ReactNode } from "react";

import { cn } from "@/lib/utils";

type Props = {
  children: ReactNode;
  className?: string;
};

const Container = ({ children, className }: Props) => {
  return (
    <div
      className={cn(
        "mx-auto w-full max-w-7xl px-4 pb-10 sm:px-6 lg:px-8",
        className,
      )}
    >
      {children}
    </div>
  );
};

export default Container;
