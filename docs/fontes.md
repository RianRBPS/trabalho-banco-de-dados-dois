# Fontes compartilhadas

## Google Docs

Documento [trabalho prático](https://docs.google.com/document/d/1uOSx6CZz7muAc2Usmul6cbJXrX5FJOzD__RoBC1Do2k/edit), acessado pelo conector Google Drive em 14 de outubro de 2026. Última modificação informada: 14 de outubro de 2026, 18:21:50 UTC. A leitura textual confirmou descrição, escopo e entidades de streaming correspondentes ao DOCX local. A leitura textual não recupera o conteúdo das imagens; os diagramas locais continuam como referência inicial.

## Excalidraw

A sala colaborativa enviada pelo usuário abriu no navegador e apresentou o modelo conceitual de streaming, com assinante, plano, perfil, mídia, filme, série, temporada, episódios, gênero e artista. O endereço completo fica fora do repositório público porque inclui a chave da sala. Solicitar ao responsável uma exportação estática atualizada para versionamento.

Diferença visível: a relação `assina` apresenta `0..1` junto a plano na versão atual; a imagem do DOCX apresenta `1..N` nesse ponto. A proposta SQL exige exatamente um plano por assinante, seguindo a FK do modelo relacional local. Esta regra precisa ser conciliada com o integrante responsável pela etapa 3 antes de considerar a implementação definitiva.

## Estado da proposta

Numeração informada pelo grupo: 1 descrição do domínio, 2 conceitual, 3 relacional, 4 PostgreSQL, 5 consultas. Um integrante está elaborando a etapa 3. O schema e as consultas aqui são uma proposta validada tecnicamente, ainda sujeita à revisão e conciliação com esse modelo. Nenhuma mensagem privada ou número de telefone foi incluído.
