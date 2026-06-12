# Boilerplate de Componente e Server Components

## Padrão de Arquitetura de Componentes

Sempre que criar um componente complexo, separe a UI da lógica e use TypeScript estrito.

### Exemplo: Componente de Lista de Usuários (Server/Client Híbrido)

```tsx
// 1. O COMPONENTE SERVER (Padrão/Entrada)
// src/components/user-list/index.tsx
import { UserListClient } from "./user-list-client";
import { fetchUsers } from "@/services/users";

export async function UserList() {
  const users = await fetchUsers(); // Fetch no servidor com cache nativo

  return (
    <section className="space-y-4">
      <div className="flex flex-col gap-1">
        <h2 className="text-2xl font-bold tracking-tight text-foreground">
          Usuários
        </h2>
        <p className="text-sm text-muted-foreground">
          Gerencie os membros da sua equipe.
        </p>
      </div>

      {/* Passa os dados do servidor para a interatividade no cliente */}
      <UserListClient initialUsers={users} />
    </section>
  );
}

// 2. O COMPONENTE CLIENT (Apenas para interatividade)
// src/components/user-list/user-list-client.tsx
"use client";

import { useState } from "react";
import { User } from "@/types/user";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Search } from "lucide-react";

interface UserListClientProps {
  initialUsers: User[];
}

export function UserListClient({ initialUsers }: UserListClientProps) {
  const [search, setSearch] = useState("");

  const filteredUsers = initialUsers.filter((user) =>
    user.name.toLowerCase().includes(search.toLowerCase()),
  );

  return (
    <div className="space-y-4">
      <div className="relative flex max-w-sm items-center">
        <Search className="absolute left-3 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Buscar usuário..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="pl-9"
          aria-label="Buscar usuário pelo nome"
        />
      </div>

      <ul className="grid gap-2 sm:grid-cols-2 lg:grid-cols-3">
        {filteredUsers.map((user) => (
          <li
            key={user.id}
            className="rounded-xl border bg-card p-4 text-card-foreground shadow-sm"
          >
            <p className="font-semibold">{user.name}</p>
            <p className="text-xs text-muted-foreground">{user.email}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}
```
