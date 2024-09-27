# Etapa 1: Construção da aplicação
FROM node:18-alpine AS build

WORKDIR /app

# Copie os arquivos de dependências
COPY package.json pnpm-lock.yaml ./

# Instale o pnpm globalmente
RUN npm install -g pnpm

# Instale todas as dependências (incluindo devDependencies)
RUN pnpm install

# Copie todo o código-fonte para o contêiner
COPY . .

# Crie o build da aplicação (para TypeScript ou outros assets)
RUN pnpm build

# Etapa 2: Contêiner de Produção
FROM node:18-alpine

WORKDIR /app

# Copie apenas o build e as dependências de produção
COPY --from=build /app/dist /app/dist
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package.json /app/pnpm-lock.yaml ./

RUN npm install -g pnpm

# Exponha a porta da API
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["pnpm", "start"]
