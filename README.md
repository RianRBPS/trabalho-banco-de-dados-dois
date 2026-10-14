# Trabalho de Banco de Dados II

Banco PostgreSQL para uma plataforma de streaming, baseado no documento encontrado em Downloads e preservado em `docs/originais/trabalho-pratico.docx`. O grupo deve confirmar que esta é a versão vigente. O enunciado completo da disciplina ainda não foi identificado.

## Arquivos

- `docs/originais/`: documento original, sem alterações.
- `docs/diagramas/`: imagens extraídas do original.
- `docs/decisoes.md`: origem, decisões e pontos de revisão.
- `sql/00_criar_banco.sql`: criação do banco.
- `sql/01_schema.sql`: tabelas, chaves e restrições (passo 3).
- `sql/02_dados_exemplo.sql`: dados fictícios para demonstração.
- `sql/03_consultas.sql`: três consultas com junções (passo 4).

## Executar no PostgreSQL

É necessário ter PostgreSQL instalado e um usuário com permissão para criar bancos. A senha deve ser informada no prompt ou configurada localmente, sem entrar no Git.

```powershell
psql -U postgres -d postgres -v ON_ERROR_STOP=1 -f sql/00_criar_banco.sql
psql -U postgres -d bd2_streaming -v ON_ERROR_STOP=1 -f sql/01_schema.sql
psql -U postgres -d bd2_streaming -v ON_ERROR_STOP=1 -f sql/02_dados_exemplo.sql
psql -U postgres -d bd2_streaming -v ON_ERROR_STOP=1 -f sql/03_consultas.sql
```

No pgAdmin, execute o arquivo 00 conectado ao banco `postgres`, fora de uma transação. Depois conecte ao novo banco e execute 01, 02 e 03 em ordem. Os scripts 00, 01 e 02 são para uma instalação inicial e não devem ser repetidos em um banco já preenchido.

## Colaboração

Após clonar o repositório, atualize a branch principal antes de iniciar uma tarefa. Cada integrante trabalha em uma branch, registra commits e abre um pull request para revisão do grupo.

```powershell
git switch main
git pull --ff-only
git switch -c codex/minha-tarefa
# editar e validar
git add .
git commit -m "Descreve a alteração"
git push -u origin codex/minha-tarefa
```

Na revisão, conferir correspondência com o modelo, integridade referencial, utilidade das consultas e resultados com dados de exemplo. Mudanças de requisitos devem constar em `docs/decisoes.md`. O GitHub armazena os arquivos; cada integrante executa o banco no PostgreSQL.
