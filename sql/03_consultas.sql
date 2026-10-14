-- 1. Continuar assistindo: ultima reproducao de cada midia por perfil ativo.
-- Resultado esperado na amostra: Adulto / A luz e Adulto / Viagem ao Horizonte.
WITH ultima AS (
 SELECT h.*, row_number() OVER (
 PARTITION BY id_perfil,id_filme,id_episodio ORDER BY data_hora DESC,id_historico DESC) AS ordem
 FROM historico_reproducao h
)
SELECT p.nome_perfil,t.titulo,e.titulo AS episodio,h.minuto_parada,
 COALESCE(f.duracao_min,e.duracao_min) AS duracao_min,h.data_hora
FROM ultima h
JOIN perfil p ON p.id_perfil=h.id_perfil
JOIN assinante a ON a.id_assinante=p.id_assinante
LEFT JOIN filme f ON f.id_titulo=h.id_filme
LEFT JOIN episodio e ON e.id_episodio=h.id_episodio
LEFT JOIN temporada tm ON tm.id_temporada=e.id_temporada
JOIN titulo t ON t.id_titulo=COALESCE(f.id_titulo,tm.id_titulo)
WHERE h.ordem=1 AND NOT h.concluido AND a.status_conta='ativa'
 AND t.classificacao_etaria<=p.classificacao_maxima
ORDER BY p.id_perfil,h.data_hora DESC;

-- 2. Minha lista: favoritos permitidos pelo controle parental, com generos e nota.
-- Resultado esperado: tres linhas, sem multiplicar favoritos por genero.
SELECT p.nome_perfil,t.titulo,t.tipo,string_agg(g.nome,', ' ORDER BY g.nome) AS generos,
 av.nota,fv.data_adicao
FROM favorito fv
JOIN perfil p ON p.id_perfil=fv.id_perfil
JOIN assinante a ON a.id_assinante=p.id_assinante
JOIN titulo t ON t.id_titulo=fv.id_titulo
LEFT JOIN titulo_genero tg ON tg.id_titulo=t.id_titulo
LEFT JOIN genero g ON g.id_genero=tg.id_genero
LEFT JOIN avaliacao av ON av.id_perfil=p.id_perfil AND av.id_titulo=t.id_titulo
WHERE a.status_conta='ativa' AND t.classificacao_etaria<=p.classificacao_maxima
GROUP BY p.id_perfil,p.nome_perfil,t.id_titulo,t.titulo,t.tipo,av.nota,fv.data_adicao
ORDER BY p.id_perfil,t.titulo;

-- 3. Operacao: audiencia por plano e titulo, incluindo filmes e episodios.
-- Resultado esperado: Familia / Ciencia em Casa: 2 perfis; Familia / Viagem ao Horizonte: 1.
SELECT pl.nome AS plano,t.titulo,count(*) AS reproducoes,
 count(DISTINCT p.id_perfil) AS perfis_distintos,
 count(*) FILTER (WHERE h.concluido) AS reproducoes_concluidas
FROM historico_reproducao h
JOIN perfil p ON p.id_perfil=h.id_perfil
JOIN assinante a ON a.id_assinante=p.id_assinante
JOIN plano pl ON pl.id_plano=a.id_plano
LEFT JOIN episodio e ON e.id_episodio=h.id_episodio
LEFT JOIN temporada tm ON tm.id_temporada=e.id_temporada
JOIN titulo t ON t.id_titulo=COALESCE(h.id_filme,tm.id_titulo)
GROUP BY pl.id_plano,pl.nome,t.id_titulo,t.titulo
ORDER BY pl.nome,reproducoes DESC,t.titulo;
