DROP DATABASE IF EXISTS spoti_pobre;
CREATE DATABASE spoti_pobre;

-- conectando no B.D
\c spoti_pobre;

CREATE TABLE usuario (
    id serial primary key,
    nome text,
    email text NOT NULL,
    senha text NOT NULL
);

INSERT INTO usuario (nome, email, senha) VALUES
('NICOLE BRANDÃO','nicole.brandao@aluno.riogrande.ifrs.edu.br', '123'),
('JACKSON ANTUNES', 'jackson.antunes@aluno.ifrs.edu.br', '321');

CREATE TABLE playlist (
    id serial primary key,
    nome text not null,
    data_hora timestamp DEFAULT CURRENT_TIMESTAMP,
    usuario_id integer references usuario (id) ON DELETE CASCADE
);

INSERT INTO playlist (nome, usuario_id) VALUES
('Playlist da Nicole', 1);

CREATE TABLE artista (
    id serial primary key,
    nome text,
    nome_artistico text not null
);

INSERT INTO artista (nome_artistico) VALUES
('Anitta'),
('Pablo Vittar'),
('Leo Santana');

CREATE TABLE album (
    id              serial  primary key,
    titulo          text,
    data_lancamento date,
    artista_id      integer references artista (id)
);
INSERT INTO album (titulo, data_lancamento, artista_id) VALUES
('Bang', '2015-01-01', 1),
('Não Para Não', '2018-03-01', 2),
('Zona de Perigo', '2023-02-01', 3);

CREATE TABLE musica (
    id serial primary key,
    titulo text,
    duracao integer,
    album_id integer references album (id)
);

INSERT INTO musica (titulo, duracao, album_id) VALUES
('Bang', 200, 1),
('Amor de Que', 300, 2),
('Zona de Perigo', 400, 3);

CREATE TABLE playlist_musica (
    playlist_id integer references playlist (id) ON DELETE CASCADE,
    musica_id integer references musica (id),
    primary key (playlist_id, musica_id)
);

INSERT INTO playlist_musica (playlist_id, musica_id) VALUES
(1, 1),
(1, 2);

-- consulta
-- SELECT * FROM <tabela>
-- ordenar resultados
-- ORDER BY [ASC, DESC]
-- limitar e/ou pular resultados
-- LIMIT, OFFSET
-- WHERE or, and, != >, >=, <, <=

-- adicionar novas colunas
-- spoti_pobre=# ALTER TABLE usuario ADD COLUMN data_nascimento DATE;













