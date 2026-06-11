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
    <header className="fixed left-0 top-0 z-50 w-full border-b border-slate-200/80 bg-white shadow-[0_2px_8px_rgba(15,23,42,0.08)] backdrop-blur-xl dark:border-white/10 dark:bg-[#1f1f1f] dark:shadow-[0_6px_18px_rgba(0,0,0,0.55)]">
      <div className="mx-auto flex h-24 w-full max-w-7xl items-center justify-between gap-4 px-4 sm:px-6 lg:px-8">
        <Link href="/" className="shrink-0" aria-label="Carioca Digital">
          <span
            aria-hidden="true"
            className="block w-[180px] sm:w-[210px]"
            style={{
              aspectRatio: "240 / 96",
              backgroundImage:
                "linear-gradient(90deg, #18a8ec 0%, #10b7d6 38%, #10c18f 100%)",
              WebkitMaskImage: "url(/logocariocadigital.png)",
              maskImage: "url(/logocariocadigital.png)",
              WebkitMaskRepeat: "no-repeat",
              maskRepeat: "no-repeat",
              WebkitMaskPosition: "center",
              maskPosition: "center",
              WebkitMaskSize: "contain",
              maskSize: "contain",
            }}
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
