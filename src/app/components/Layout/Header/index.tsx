import Image from "next/image";
import Link from "next/link";
import LogoutButton from "../LogoutButton";
import { getServerSession } from "@/app/api/lib";
import { decodeJwt } from "@/utils/api";
import { ThemeToggle } from "@/components/theme-toggle";

const Header = async () => {
  const session = await getServerSession();
  const payload = session ? decodeJwt(session.accessToken) : undefined;
  const givenName =
    typeof payload?.given_name === "string" ? payload.given_name : undefined;

  return (
    <header className="fixed left-0 top-0 z-50 w-full border-b border-slate-200/80 bg-white shadow-[0_2px_8px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-border/60 dark:bg-[#004a80] dark:shadow-[0_8px_30px_rgba(15,23,42,0.28)]">
      <div className="mx-auto flex h-24 w-full max-w-7xl items-center justify-between gap-4 px-4 sm:px-6 lg:px-8">
        <Link href="/" className="shrink-0">
          <Image
            className="h-auto w-[180px] sm:w-[210px] [filter:brightness(0)_saturate(100%)_invert(42%)_sepia(98%)_saturate(605%)_hue-rotate(131deg)_brightness(95%)_contrast(92%)] dark:[filter:none]"
            src="/logocariocadigital.png"
            width={240}
            height={96}
            alt="Logo"
            priority
          />
        </Link>
        <div className="flex items-center gap-2 sm:gap-3">
          <ThemeToggle />
          <LogoutButton givenName={givenName} />
        </div>
      </div>
    </header>
  );
};

export default Header;
