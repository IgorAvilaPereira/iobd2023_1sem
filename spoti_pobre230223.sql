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
('JACKSON ANTUNES', 'jackson.antunes@aluno.ifrs.edu.br', '321'),
('MICHAEL PEREIRA', 'michael.pereira@aluno.ifrs.edu.br', '345');

CREATE TABLE playlist (
    id serial primary key,
    nome text not null,
    data_hora timestamp DEFAULT CURRENT_TIMESTAMP,
    usuario_id integer references usuario (id) ON DELETE CASCADE
);

INSERT INTO playlist (nome, usuario_id) VALUES
('Playlist da Nicole', 1),
('Playlist do Jackson', 2),
('Playlist do Michael', 3);

CREATE TABLE artista (
    id serial primary key,
    nome text,
    nome_artistico text not null
);

INSERT INTO artista (nome_artistico) VALUES
('Anitta'),
('Pablo Vittar'),
('Leo Santana'),
('Pink Floyd'),
('The Police'),
('Pearl Jam');

CREATE TABLE album (
    id              serial  primary key,
    titulo          text,
    data_lancamento date,
    artista_id      integer references artista (id)
);
INSERT INTO album (titulo, data_lancamento, artista_id) VALUES
('Bang', '2015-01-01', 1),
('Não Para Não', '2018-03-01', 2),
('Zona de Perigo', '2023-02-01', 3),
('The wall', '1970-11-12', 4),
('Every breath you take', '1980-01-05', 5),
('Mtv unppluged', '1990-04-03',6);

CREATE TABLE musica (
    id serial primary key,
    titulo text,
    duracao integer,
    album_id integer references album (id)
);

INSERT INTO musica (titulo, duracao, album_id) VALUES
('Bang', 200, 1),
('Amor de Que', 300, 2),
('Zona de Perigo', 400, 3),
('another break in the wall', 5000, 4),
('Every breath you take', 300, 5),
('black', 200, 6);

CREATE TABLE playlist_musica (
    playlist_id integer references playlist (id) ON DELETE CASCADE,
    musica_id integer references musica (id),
    primary key (playlist_id, musica_id)
);

INSERT INTO playlist_musica (playlist_id, musica_id) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,2),
(3,1),
(3,2),
(3,5),
(3,6);

-- spoti_pobre=# ALTER TABLE usuario ADD COLUMN data_nascimento DATE CHECK(EXTRACT(YEAR FROM data_nascimento)>=1900);
-- spoti_pobre=# SELECT nome, to_char(data_nascimento,'DD/MM/YYYY') FROM usuario;
-- spoti_pobre=# select * from usuario where nome is null;
-- spoti_pobre=# SELECT UPPER(titulo) as titulo_maiusculo, titulo FROM album;
-- spoti_pobre=# SELECT titulo from album limit 2;
-- spoti_pobre=# SELECT coalesce(nome||';'||email, email||';'||data_nascimento) FROM usuario ORDER by nome;

-- spoti_pobre=# SELECT * FROM musica WHERE duracao >= 100 and duracao <= 200;
-- spoti_pobre=# SELECT * FROM musica WHERE duracao between 100 and 200;

-- consulta
-- SELECT * FROM <tabela>
-- ordenar resultados
-- ORDER BY [ASC, DESC]
-- limitar e/ou pular resultados
-- LIMIT, OFFSET
-- WHERE or, and, != >, >=, <, <=

-- adicionar novas colunas
-- spoti_pobre=# ALTER TABLE usuario ADD COLUMN data_nascimento DATE;













