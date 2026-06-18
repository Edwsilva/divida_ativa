import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: ["class"],
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    container: {
      center: true,
      padding: "1rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      fontFamily: {
        sans: ["var(--font-sans)", "sans-serif"],
        heading: ["var(--font-sans)", "sans-serif"],
      },
      colors: {
        border: "var(--border)",
        input: "var(--input)",
        ring: "var(--ring)",
        background: "var(--background)",
        foreground: "var(--foreground)",
        primary: {
          DEFAULT: "color-mix(in srgb, var(--primary) calc(<alpha-value> * 100%), transparent)",
          foreground: "var(--primary-foreground)",
        },
        secondary: {
          DEFAULT: "color-mix(in srgb, var(--secondary) calc(<alpha-value> * 100%), transparent)",
          foreground: "var(--secondary-foreground)",
        },
        muted: {
          DEFAULT: "color-mix(in srgb, var(--muted) calc(<alpha-value> * 100%), transparent)",
          foreground: "var(--muted-foreground)",
        },
        accent: {
          DEFAULT: "color-mix(in srgb, var(--accent) calc(<alpha-value> * 100%), transparent)",
          foreground: "var(--accent-foreground)",
        },
        card: {
          DEFAULT: "var(--card)",
          foreground: "var(--card-foreground)",
        },
        popover: {
          DEFAULT: "var(--popover)",
          foreground: "var(--popover-foreground)",
        },
        destructive: {
          DEFAULT: "color-mix(in srgb, var(--destructive) calc(<alpha-value> * 100%), transparent)",
          foreground: "var(--destructive-foreground)",
        },
      },
      boxShadow: {
        soft: "0 24px 80px -40px rgba(15, 23, 42, 0.45)",
      },
    },
  },
  plugins: [],
};

export default config;
