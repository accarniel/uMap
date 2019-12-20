-- Script de criação da base de dados manipulada e gerenciada pelo aplicativo uMap (na parte do servidor)
-- Desenvolvido por Daniel Dalpasquale e Anderson C. Carniel (UTFPR-DV) em 16/12/2019.
-- TODO especificar constraints do tipo NOT NULL e CHECK
-- TODO especificar um arquivo JSON ou XML que contém informações a serem enviadas pelo dispositivo móvel de um usuário e então que serão salvas nesta base de dados

-- Database: umap
-- DROP DATABASE umap;

-- DROP TABLE resposta;
-- DROP TABLE usuario;
-- DROP TABLE valida;
-- DROP TABLE descricao;
-- DROP TABLE  entidade;
-- DROP TABLE usuario;
-- DROP TABLE opcao;
-- DROP TABLE pergunta;

CREATE DATABASE umap
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
 

--TABLE : usuario
CREATE TABLE usuario
(
 id SERIAL NOT NULL,
 nome VARCHAR,
 login VARCHAR NOT NULL,
 senha TEXT NOT NULL,
 tipo VARCHAR,
 data_criacao TIMESTAMP,
 data_alteracao TIMESTAMP,
 data_inativacao TIMESTAMP,
 endereco VARCHAR,
 CONSTRAINT usuario_id_pkey PRIMARY KEY
);

--TABLE : pergunta 
CREATE TABLE pergunta
(
 titulo TEXT,
 id SERIAL,
 tipo VARCHAR,
 CONSTRAINT pergunta_id_pkey PRIMARY KEY
);

--TABLE :opçao
CREATE TABLE opcao
(
 id SERIAL,
 op TEXT,
 pergunta INTEGER,
 CONSTRAINT opcao_pergunta_fkey FOREIGN KEY pergunta REFERENCES pergunta(id),
 CONSTRAINT opcao_id_pkey PRIMARY KEY
);

--TABLE:descricao 
CREATE TABLE descricao
(
    id SERIAL,
    asunto VARCHAR,
    completo TEXT,
    CONSTRAINT descricao_id_pkey PRIMARY KEY
);
  
--TABLE: resposta
CREATE TABLE resposta
(
    data TIMESTAMP,
    resposta TEXT,
    id_usuario INTEGER,
    id_pergunta INTEGER,
    CONSTRAINT resposta_pk PRIMARY KEY (id_usuario , id_pergunta),
    CONSTRAINT resposta_id_pergunta_fkey FOREIGN KEY id_pergunta REFERENCES pergunta(id),
    CONSTRAINT resposta_id_usuario_fkey FOREIGN KEY id_usuario REFERENCES usuario(id)
);
--TABLE: entidade 
CREATE TABLE entidade
(
    id SERIAL,
    imagem TEXT,
    objeto_espacial GEOMETRY,
    observacao TEXT,
    usuario_mapeia INTEGER,
    usuario_ajusta INTEGER,
    data_ajuste TIMESTAMP,
    tipo_ajuste TEXT,
    data_mapeia TIMESTAMP,
    id_descricao INTEGER,
    id_posterior INTEGER,
    CONSTRAINT entidade_id_pkey PRIMARY KEY,
    CONSTRAINT entidade_id_posterior_fkey FOREIGN KEY id_posterior  REFERENCES entidade(id),
    CONSTRAINT entidade_id_descricao_fkey FOREIGN KEY id_descricao  REFERENCES descricao(id),
    CONSTRAINT entidade_usuario_mapeia_fkey FOREIGN KEY usuario_mapeia  REFERENCES usuario(id),
    CONSTRAINT entidade_usuario_ajusta_fkey FOREIGN KEY usuario_ajusta REFERENCES usuario(id)   
);

--TABLE:valida 
CREATE TABLE valida
(
    data TIMESTAMP,
    nota INTEGER,
    ok BOOLEAN,
    id_usuario INTEGER,
    id_entidade INTEGER,
    CONSTRAINT valida_pk PRIMARY KEY (id_usuario , id_entidade) ,
    CONSTRAINT valida_id_usuario_fkey FOREIGN KEY id_usuario  REFERENCES usuario(id),
    CONSTRAINT valida_id_entidade_fkey FOREIGN KEY id_entidade REFERENCES entidade(id)
);
