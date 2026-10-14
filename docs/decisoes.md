# Fontes e decisões para revisão

## Fonte localizada em 14 de outubro de 2026

`C:/Users/riris/Downloads/trabalho prático.docx`, copiado sem alteração para `originais/trabalho-pratico.docx`. Contém descrição do streaming, escopo e duas imagens de modelos. As imagens foram extraídas para `diagramas/`. Nenhum enunciado completo da disciplina foi localizado. Os PDFs individuais de BD2 encontrados em Downloads descrevem outros domínios e não foram incorporados.

## Tradução para PostgreSQL

O modelo possui 15 tabelas: plano, assinante, perfil, titulo, filme, serie, temporada, episodio, genero, titulo_genero, artista, credito_producao, historico_reproducao, avaliacao e favorito.

- Classificação livre é representada por 0; demais valores: 10, 12, 14, 16 e 18. O diagrama indica enum, sem enumerar valores; esta convenção precisa de revisão.
- Tipo de título e status de conta usam texto com CHECK. Resolução e status de produção usam texto, pois seus valores permitidos não estão definidos na fonte.
- Filme e série têm coluna técnica `tipo` para garantir, por FK composta, que correspondem ao tipo do título. Triggers adiadas garantem especialização total ao terminar a transação.
- Cada reprodução aponta para exatamente um filme ou episódio, com CHECK exclusivo.
- Preservados nomes, tipos aproximados, atributos opcionais e unicidades visíveis no modelo. Adicionados CHECKs de duração, preço, nota e numeração positivos para integridade.
- Não implementados pagamentos, download ou recomendação avançada, excluídos do escopo original.

## Consultas

1. Continuar assistindo: última sessão por perfil e mídia, não concluída, com controle parental e conta ativa. Junções entre histórico, perfil, assinante, filme, episódio, temporada e título.
2. Minha lista: favoritos permitidos com gêneros e avaliação do perfil. Junções entre favorito, perfil, assinante, título, título/gênero, gênero e avaliação.
3. Audiência por plano e título: quantidade de sessões, perfis distintos e sessões concluídas. Junções entre histórico, perfil, assinante, plano, episódio, temporada e título. Usa o plano atual do assinante; não existe histórico de troca de planos na fonte.

## Pendências do grupo

Confirmar versão do documento, fornecer enunciado e rubrica, revisar valores de classificação e enums, conferir obrigatoriedade dos campos. A existência mínima de perfis, gêneros e créditos por título aparece no conceitual, mas não está imposta por triggers; revisar se essas cardinalidades são requisitos obrigatórios no cadastro ou apenas na operação.
