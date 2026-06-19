const fs = require("fs");

const INPUT = process.argv[2] || "sessao.json";
const OUTPUT = process.argv[3] || "sessao.md";

const data = JSON.parse(fs.readFileSync(INPUT, "utf8"));

const lines = [];

function add(text = "") {
  lines.push(text);
}

function codeBlock(lang, content) {
  add(`\`\`\`${lang}`);
  add(typeof content === "string" ? content : JSON.stringify(content, null, 2));
  add("```");
  add();
}

add("# Exportação OpenCode");
add();

if (data.info) {
  add("## Informações da Sessão");
  codeBlock("json", data.info);
}

const messages = data.messages || data.items || [];

add(`## Total de mensagens: ${messages.length}`);
add();

messages.forEach((message, index) => {
  const info = message.info || {};

  add("---");
  add();

  add(`# Mensagem ${index + 1}`);
  add();

  add(`**Role:** ${info.role || "desconhecido"}`);
  add();

  if (info.id) {
    add(`**Message ID:** \`${info.id}\``);
    add();
  }

  if (info.parentID) {
    add(`**Parent ID:** \`${info.parentID}\``);
    add();
  }

  if (info.sessionID) {
    add(`**Session ID:** \`${info.sessionID}\``);
    add();
  }

  if (info.agent) {
    add(`**Agent:** ${info.agent}`);
    add();
  }

  if (info.modelID) {
    add(`**Model:** ${info.modelID}`);
    add();
  }

  if (info.providerID) {
    add(`**Provider:** ${info.providerID}`);
    add();
  }

  if (info.cost !== undefined) {
    add(`**Cost:** ${info.cost}`);
    add();
  }

  if (info.tokens) {
    add("## Tokens");
    codeBlock("json", info.tokens);
  }

  if (info.time) {
    add("## Time");
    codeBlock("json", info.time);
  }

  const parts = message.parts || [];

  parts.forEach((part, partIndex) => {
    add(`## Parte ${partIndex + 1}`);
    add();

    add(`**Tipo:** ${part.type}`);
    add();

    if (part.id) {
      add(`**Part ID:** \`${part.id}\``);
      add();
    }

    switch (part.type) {
      case "text":
        add("### Conteúdo");
        add();
        add(part.text || "");
        add();
        break;

      case "tool":
        add(`### Tool: ${part.tool}`);
        add();

        if (part.callID) {
          add(`**Call ID:** \`${part.callID}\``);
          add();
        }

        if (part.state?.status) {
          add(`**Status:** ${part.state.status}`);
          add();
        }

        if (part.state?.input) {
          add("#### Input");
          codeBlock("json", part.state.input);
        }

        if (part.state?.output) {
          add("#### Output");

          if (typeof part.state.output === "string") {
            codeBlock("text", part.state.output);
          } else {
            codeBlock("json", part.state.output);
          }
        }

        if (part.state?.metadata) {
          add("#### Metadata");
          codeBlock("json", part.state.metadata);

          if (part.state.metadata.diff) {
            add("#### Diff");
            codeBlock("diff", part.state.metadata.diff);
          }

          if (part.state.metadata.filediff?.patch) {
            add("#### Patch");
            codeBlock("diff", part.state.metadata.filediff.patch);
          }
        }

        break;

      default:
        add("### Dados completos");
        codeBlock("json", part);
    }
  });

  add();
});

fs.writeFileSync(OUTPUT, lines.join("\n"), "utf8");

console.log(`Markdown gerado com sucesso: ${OUTPUT}`);
