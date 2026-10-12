---
name: task-runner
description: Seleciona e processa estritamente a próxima tarefa sequencial de tasks/pendentes/, garantindo isolamento total de contexto, leitura prévia obrigatória e movimentação de ciclo de vida.
---

# Task Runner Protocol

## Objetivo
Executar de forma isolada, determinística e atômica a tarefa com menor índice sequencial pendente, mantendo o agente focado exclusivamente no arquivo selecionado.

## Invariantes e Regras Mandatórias
- **Isolamento de Contexto:** É proibido ler, listar, inspecionar ou alterar qualquer outro arquivo além da tarefa atômica selecionada.
- **Fail-Fast de Planejamento:** É proibido gerar TODO, planos de ação ou suposições antes de ler o conteúdo completo da tarefa ativa.
- **Transição Atômica de Estado:** O arquivo deve mudar de pasta conforme os marcos de progresso.

## Ciclo de Execução

1. **Identificação e Bloqueio:**
   - Execute o script auxiliar da skill ou liste `tasks/pendentes/` ordenando por versão natural (`sort -V`).
   - Identifique apenas o primeiro arquivo (menor índice sequencial).
   - Mova o arquivo identificado de `tasks/pendentes/` para `tasks/em_andamento/`.

2. **Leitura de Contexto:**
   - Abra e leia o conteúdo integral do arquivo em `tasks/em_andamento/<arquivo>`.

3. **Planejamento Vinculado:**
   - Somente após concluir a leitura, formule o checklist/TODO operacional exclusivamente baseado no conteúdo lido.

4. **Execução:**
   - Execute as tarefas delimitadas no TODO até a conclusão de todos os itens.

5. **Finalização:**
   - Mova o arquivo de `tasks/em_andamento/<arquivo>` para `tasks/concluidas/`.
   - Encerre a resposta sem iniciar novos processamentos.
   - Formato de resposta final: Responda estritamente com uma única linha no padrão `DONE: <nome_do_arquivo>`.
