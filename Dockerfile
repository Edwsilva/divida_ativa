# Etapa 1: Instalação das dependências e build
FROM node:20.12.1-alpine AS builder
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY . .

RUN corepack enable && corepack prepare pnpm@latest --activate
COPY package.json pnpm-lock.yaml ./

# Adicione o comando para limpar o cache
ENV CI=true
RUN pnpm install --frozen-lockfile --verbose

# Build da aplicação
RUN pnpm build

RUN pwd
RUN ls -la /app/.next/

# Etapa 2: Imagem final para produção
FROM node:20.12.1-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Cria o usuário não-root
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001

# Instala utilitários (opcional)
RUN apk add --no-cache --upgrade bash lsof nmap

# Copia os artefatos necessários do standalone
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Copia scripts e variáveis
# COPY --from=builder /app/replace_variable.sh .
# COPY --from=builder /app/.env .

# Ajusta as permissões ANTES de trocar de usuário
RUN chmod -R 777 ./.next
# RUN ["chmod", "+x", "./replace_variable.sh"]

# Troca o usuário para um não-root para segurança
USER nextjs

EXPOSE 3000
ENV PORT=3000

# Altera o comando de inicialização para usar o server.js
CMD ["/bin/bash", "-c", "node server.js"]
