# Fontes compartilhadas

## Google Docs

Documento [trabalho prático](https://docs.google.com/document/d/1uOSx6CZz7muAc2Usmul6cbJXrX5FJOzD__RoBC1Do2k/edit), acessado pelo conector Google Drive em 14 de outubro de 2026. Última modificação informada: 14 de outubro de 2026, 18:21:50 UTC. A leitura textual confirmou descrição, escopo e entidades de streaming correspondentes ao DOCX local. A leitura textual não recupera o conteúdo das imagens; os diagramas locais continuam como referência inicial.

## Excalidraw

A sala colaborativa enviada pelo usuário abriu no navegador e apresentou o modelo conceitual de streaming, com assinante, plano, perfil, mídia, filme, série, temporada, episódios, gênero e artista. O endereço completo fica fora do repositório público porque inclui a chave da sala. Solicitar ao responsável uma exportação estática atualizada para versionamento.

Diferença visível: a relação `assina` apresenta `0..1` junto a plano na versão atual; a imagem do DOCX apresenta `1..N` nesse ponto. A proposta SQL exige exatamente um plano por assinante, seguindo a FK do modelo relacional local. Esta regra precisa ser conciliada com o integrante responsável pela etapa 3 antes de considerar a implementação definitiva.

## Estado da proposta

Numeração informada pelo grupo: 1 descrição do domínio, 2 conceitual, 3 relacional, 4 PostgreSQL, 5 consultas. Um integrante está elaborando a etapa 3. O schema e as consultas aqui são uma proposta validada tecnicamente, ainda sujeita à revisão e conciliação com esse modelo. Nenhuma mensagem privada ou número de telefone foi incluído.

## Imagem relacional enviada pelo usuário

Conferida em 14 de outubro de 2026. A imagem recebida possui 1600 × 1074 pixels; `diagramas/modelo-relacional.png`, extraída do DOCX, possui 2048 × 1374 pixels. A comparação visual confirmou o mesmo diagrama, com as mesmas 15 tabelas, disposição, atributos legíveis, chaves e conexões. Os arquivos têm hashes diferentes por resolução e codificação; não são cópias binariamente idênticas. Não foi adicionada uma cópia redundante nem alterado o SQL.

### Correspondência com o SQL

- As 15 tabelas e todos os atributos legíveis estão representados no schema. As PKs simples e compostas, FKs e unicidades de perfil por assinante, temporada por série e episódio por temporada foram mantidas.
- `decimal(8,2)` do preço foi implementado como `numeric(8,2)`, sinônimo no PostgreSQL. `serial`, `int`, `smallint`, `date`, `timestamp`, `boolean` e os comprimentos legíveis de `varchar` foram mantidos, exceto pelas adaptações descritas abaixo.
- CPF aparece como `char(11)` no diagrama e está como `varchar(11)` com CHECK de exatamente 11 dígitos no SQL. A diferença de tipo é explícita; para fidelidade literal, o grupo pode optar por `char(11)`. O schema atual aceita apenas os 11 dígitos, sem preenchimento por espaços.
- Os enums de tipo de título, classificações, status da conta, resolução e status de produção não exibem os valores permitidos. O SQL usa texto ou `smallint`, com CHECK quando houve uma convenção definida na proposta. Definir os valores e decidir entre enum nativo e CHECK continua pendente.
- O comprimento de `serie.emissora_produtora` está truncado na imagem. O `varchar(150)` do SQL é uma escolha da proposta, não uma transcrição confirmada. Solicitar o modelo editável ou exportação textual para confirmar esse comprimento e os enums.
- O SQL acrescenta `tipo` em filme e série, FK composta e unicidade técnica em título, além de triggers de especialização e CHECKs de integridade. Esses elementos não aparecem como colunas/restrições explícitas na imagem e precisam ser revisados como decisões de implementação.
- Os campos opcionais identificados por `?` foram preservados como anuláveis. PKs implicam NOT NULL mesmo quando a declaração SQL não o escreve explicitamente. Defaults de data, conta ativa e outros valores são escolhas de implementação, não especificações visíveis do desenho.

A imagem enviada não exige mudança estrutural imediata. A revisão deve concentrar-se nas adaptações acima e na divergência conceitual de assinante/plano já registrada. A equivalência com a referência não implica aprovação do SQL pelo grupo.
