-- Dados inteiramente ficticios. Executar uma vez em banco vazio.
BEGIN;
INSERT INTO plano(nome,preco,resolucao_maxima,limite_telas) VALUES ('Basico',19.90,'HD',1),('Familia',39.90,'4K',4);
INSERT INTO assinante(id_plano,nome,cpf,data_nascimento,email_login,senha_hash) VALUES
 (2,'Pessoa Exemplo','00000000000','1990-01-01','exemplo@example.invalid','HASH_FICTICIO_SEM_USO');
INSERT INTO perfil(id_assinante,nome_perfil,classificacao_maxima) VALUES (1,'Adulto',18),(1,'Infantil',10);
INSERT INTO titulo(tipo,titulo,ano_lancamento,classificacao_etaria) VALUES ('filme','Viagem ao Horizonte',2025,10),('serie','Ciencia em Casa',2026,0),('filme','Noite de Misterio',2024,16);
INSERT INTO filme(id_titulo,duracao_min,url_streaming) VALUES (1,100,'https://example.invalid/filme1'),(3,110,'https://example.invalid/filme3');
INSERT INTO serie(id_titulo,emissora_produtora,status_producao) VALUES (2,'Estudio Exemplo','em andamento');
INSERT INTO temporada(id_titulo,numero_temporada,ano_lancamento) VALUES (2,1,2026);
INSERT INTO episodio(id_temporada,numero_episodio,titulo,duracao_min,url_streaming) VALUES (1,1,'A luz',25,'https://example.invalid/ep1');
INSERT INTO genero(nome) VALUES ('Aventura'),('Educativo'),('Misterio');
INSERT INTO titulo_genero VALUES (1,1),(2,2),(3,3);
INSERT INTO artista(nome) VALUES ('Artista Exemplo');
INSERT INTO credito_producao(id_titulo,id_artista,papel) VALUES (1,1,'direcao'),(2,1,'apresentacao');
INSERT INTO historico_reproducao(id_perfil,id_filme,id_episodio,minuto_parada,concluido,data_hora) VALUES
 (1,1,NULL,35,false,'2026-10-10 18:00'),(1,NULL,1,10,false,'2026-10-11 19:00'),(2,NULL,1,25,true,'2026-10-12 10:00');
INSERT INTO favorito(id_perfil,id_titulo) VALUES (1,1),(1,2),(2,2);
INSERT INTO avaliacao(id_perfil,id_titulo,nota) VALUES (1,1,4),(1,2,5),(2,2,4);
COMMIT;
