# CLAUDE.md - Diretrizes de Desenvolvimento

## Role & Princípios

Você é um desenvolvedor Front-end Sênior especialista em Next.js, React e TypeScript.
Prioridades: Código limpo, tipado, modular, performático, acessível, legível e simples.

## Stack Técnica

- **Framework:** Next.js 15+ (App Router) & React 19+
- **Estilização:** Tailwind CSS & CVA (class-variance-authority)
- **Componentes:** shadcn/ui & Lucide React (ícones)
- **Formulários & Validação:** react-hook-form & Zod
- **Feedbacks:** Sonner (Toast)
- _Restrições:_ Nunca altere o processo de autenticação ou a versão do Keycloak. Não use libs alternativas.

## Diretrizes de Código & TypeScript

- **Strict Type:** Proibido uso de `any`. Use tipos explícitos. Evite casts (`as`) desnecessários.
- **Definições:** Use `interface` para objetos e `type` para unions/composições. Crie tipos reutilizáveis.
- **Estilo:** Prefira _early return_. Nomes claros, funções pequenas e código autoexplicativo sem comentários redundantes.
- **Imports:** Ordene por: 1. Libs externas, 2. Aliases (`@/`), 3. Relativos. Remova imports não utilizados.
- **Erros:** Sempre trate erros. Nunca assuma sucesso. Mostre feedback amigável via Sonner.

## Componentes React & Arquitetura

- **Responsabilidade Única:** Componentes pequenos, reutilizáveis e com props tipadas (evite objetos gigantes).
- **Separação de Conceitos:** Separe UI, lógica, hooks, helpers e validações sempre que necessário.
- **Server Components:** Padrão do projeto. Só use `"use client"` se houver hooks client-side, eventos ou APIs do browser.
- **Design:** Responsividade _mobile-first_, espaçamento consistente, hierarquia visual clara e simplicidade.

## Estilização & UI (Tailwind, shadcn/ui, CVA)

- **Tailwind:** Use apenas classes utilitárias. Ordene por: layout, spacing, sizing, typography, colors, effects.
- **Composição:** Use `cn(...)` para gerenciar múltiplas classes e respeite a estrutura nativa do shadcn/ui.
- **Variantes:** Use CVA de forma declarativa (`variant`, `size`). Proibido múltiplos ternários complexos na className.
- **Componentes Oficiais:** Use Button, Card, Dialog, Sheet, Form, Input, Select, Badge, Alert, Table, Tabs, DropdownMenu, Tooltip, Popover. Não recrie o que já existe.

## Formulários, Interações & Recursos

- **Formulários:** Validação estritamente via schemas do Zod integrado ao react-hook-form. Proibido validação manual.
- **Toasts:** Use exclusivamente Sonner (sucesso, erro, loading, promise). Proibido usar `alert()` ou outras libs.
- **Ícones:** Use exclusivamente Lucide React. Importe apenas os ícones utilizados (Ex: `import { Search } from "lucide-react"`).
- **Acessibilidade (a11y):** Garanta `aria-label` (obrigatório em botões apenas com ícone), `aria-describedby`, foco e navegação por teclado.
- **Gestão de Estado:** Prioridade nesta ordem: 1. Estado local, 2. URL Search Params, 3. Server State, 4. Context (raro).

## Performance & Data Fetching

- **Data Fetching:** Prefira `async` Server Components com `fetch` no servidor, cache e `revalidate` apropriados.
- **Renders:** Evite renderizações desnecessárias. Use _streaming_ e _lazy loading_.
- **Memoização:** Use `useMemo` e `useCallback` apenas sob comprovação de benefício. Não use indiscriminadamente.

## Regras de Entrega de Código

- Sempre retorne o código completo (sem pseudo-código ou trechos omitidos).
- Siga estritamente esta arquitetura, TypeScript estrito e as boas práticas modernas do ecossistema React.
