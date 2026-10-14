-- Modelo de streaming transcrito do documento do grupo.
BEGIN;
CREATE TABLE plano (
 id_plano serial PRIMARY KEY, nome varchar(50) NOT NULL UNIQUE,
 descricao varchar(255), preco numeric(8,2) NOT NULL CHECK (preco >= 0),
 resolucao_maxima varchar(10) NOT NULL, limite_telas smallint NOT NULL CHECK (limite_telas > 0), ativo boolean NOT NULL DEFAULT true
);
CREATE TABLE assinante (
 id_assinante serial PRIMARY KEY, id_plano int NOT NULL REFERENCES plano,
 nome varchar(100) NOT NULL, cpf varchar(11) NOT NULL UNIQUE CHECK (cpf ~ '^[0-9]{11}$'),
 data_nascimento date NOT NULL, email_login varchar(150) NOT NULL UNIQUE,
 senha_hash varchar(255) NOT NULL, telefone varchar(20), data_cadastro timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 status_conta varchar(10) NOT NULL DEFAULT 'ativa' CHECK (status_conta IN ('ativa','inativa'))
);
CREATE TABLE perfil (
 id_perfil serial PRIMARY KEY, id_assinante int NOT NULL REFERENCES assinante,
 nome_perfil varchar(50) NOT NULL, avatar varchar(255),
 classificacao_maxima smallint NOT NULL CHECK (classificacao_maxima IN (0,10,12,14,16,18)),
 idioma_preferido varchar(10) NOT NULL DEFAULT 'pt-BR', data_criacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE (id_assinante,nome_perfil)
);
CREATE TABLE titulo (
 id_titulo serial PRIMARY KEY, tipo varchar(5) NOT NULL CHECK (tipo IN ('filme','serie')),
 titulo varchar(150) NOT NULL, titulo_original varchar(150), ano_lancamento smallint NOT NULL CHECK (ano_lancamento > 0),
 sinopse text, classificacao_etaria smallint NOT NULL CHECK (classificacao_etaria IN (0,10,12,14,16,18)),
 idioma_original varchar(10), pais_origem varchar(50), poster_url varchar(255), data_cadastro timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE (id_titulo,tipo)
);
CREATE TABLE filme (
 id_titulo int PRIMARY KEY, tipo varchar(5) NOT NULL DEFAULT 'filme' CHECK (tipo='filme'),
 duracao_min int NOT NULL CHECK (duracao_min>0), url_streaming varchar(255) NOT NULL,
 FOREIGN KEY (id_titulo,tipo) REFERENCES titulo(id_titulo,tipo)
);
CREATE TABLE serie (
 id_titulo int PRIMARY KEY, tipo varchar(5) NOT NULL DEFAULT 'serie' CHECK (tipo='serie'),
 emissora_produtora varchar(150), status_producao varchar(20) NOT NULL,
 FOREIGN KEY (id_titulo,tipo) REFERENCES titulo(id_titulo,tipo)
);
CREATE TABLE temporada (
 id_temporada serial PRIMARY KEY, id_titulo int NOT NULL REFERENCES serie,
 numero_temporada smallint NOT NULL CHECK (numero_temporada>0), nome varchar(100), ano_lancamento smallint,
 UNIQUE(id_titulo,numero_temporada)
);
CREATE TABLE episodio (
 id_episodio serial PRIMARY KEY, id_temporada int NOT NULL REFERENCES temporada,
 numero_episodio smallint NOT NULL CHECK (numero_episodio>0), titulo varchar(150) NOT NULL, sinopse text,
 duracao_min int NOT NULL CHECK (duracao_min>0), url_streaming varchar(255) NOT NULL, data_estreia date,
 UNIQUE(id_temporada,numero_episodio)
);
CREATE TABLE genero (id_genero serial PRIMARY KEY, nome varchar(50) NOT NULL UNIQUE, descricao varchar(255));
CREATE TABLE titulo_genero (
 id_titulo int REFERENCES titulo, id_genero int REFERENCES genero, PRIMARY KEY(id_titulo,id_genero)
);
CREATE TABLE artista (
 id_artista serial PRIMARY KEY, nome varchar(100) NOT NULL, nome_artistico varchar(100),
 data_nascimento date, nacionalidade varchar(50), biografia text, foto_url varchar(255)
);
CREATE TABLE credito_producao (
 id_titulo int REFERENCES titulo, id_artista int REFERENCES artista, papel varchar(50), personagem varchar(100), ordem_credito smallint,
 PRIMARY KEY(id_titulo,id_artista,papel)
);
CREATE TABLE historico_reproducao (
 id_historico serial PRIMARY KEY, id_perfil int NOT NULL REFERENCES perfil,
 id_filme int REFERENCES filme, id_episodio int REFERENCES episodio,
 minuto_parada int NOT NULL CHECK (minuto_parada>=0), concluido boolean NOT NULL DEFAULT false,
 data_hora timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, dispositivo varchar(30),
 CHECK ((id_filme IS NOT NULL) <> (id_episodio IS NOT NULL))
);
CREATE TABLE avaliacao (
 id_perfil int REFERENCES perfil, id_titulo int REFERENCES titulo,
 nota smallint NOT NULL CHECK (nota BETWEEN 1 AND 5), comentario text,
 data_avaliacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(id_perfil,id_titulo)
);
CREATE TABLE favorito (
 id_perfil int REFERENCES perfil, id_titulo int REFERENCES titulo,
 data_adicao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(id_perfil,id_titulo)
);
-- Especializacao total: todo titulo deve possuir o subtipo indicado ao final da transacao.
CREATE FUNCTION validar_subtipo_titulo() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE chave int; categoria varchar(5);
BEGIN
 FOREACH chave IN ARRAY ARRAY[CASE WHEN TG_OP <> 'INSERT' THEN OLD.id_titulo END,
 CASE WHEN TG_OP <> 'DELETE' THEN NEW.id_titulo END] LOOP
 IF chave IS NULL THEN CONTINUE; END IF;
 SELECT tipo INTO categoria FROM titulo WHERE id_titulo=chave;
 IF FOUND AND ((categoria='filme' AND NOT EXISTS(SELECT 1 FROM filme WHERE id_titulo=chave))
 OR (categoria='serie' AND NOT EXISTS(SELECT 1 FROM serie WHERE id_titulo=chave))) THEN
 RAISE EXCEPTION 'Titulo % deve possuir subtipo %',chave,categoria;
 END IF;
 END LOOP;
 RETURN NULL;
END $$;
CREATE CONSTRAINT TRIGGER titulo_subtipo AFTER INSERT OR UPDATE ON titulo DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION validar_subtipo_titulo();
CREATE CONSTRAINT TRIGGER filme_subtipo AFTER DELETE OR UPDATE ON filme DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION validar_subtipo_titulo();
CREATE CONSTRAINT TRIGGER serie_subtipo AFTER DELETE OR UPDATE ON serie DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION validar_subtipo_titulo();
COMMIT;
