import { defineConfig } from "astro/config";

const isProd = process.env.NODE_ENV === "production";

export default defineConfig({
  site: "https://rueceline.github.io",
  base: isProd ? "/reso_db/" : "/",
});
