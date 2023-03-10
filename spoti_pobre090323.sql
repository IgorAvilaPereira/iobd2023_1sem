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

INSERT INTO artista (nome, nome_artistico) VALUES
('ROBERTO CARLOS', 'ROBERTO CARLOS'),
('SEBASTIÃO MAIA', 'TIM MAIA'),
('MIROSMAR CAMARGO', 'ZEZÉ DI CAMARGO');

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

ALTER TABLE usuario ADD COLUMN data_nascimento DATE CHECK(EXTRACT(YEAR FROM data_nascimento)>=1900);

INSERT INTO usuario (email, senha, data_nascimento) VALUES ('frederico@aluno.riogrande.ifrs.edu.br', 'fred', '2003-01-02');

UPDATE usuario SET data_nascimento = '1987-05-05' WHERE id = 3;


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


-- spoti_pobre=# SELECT * FROM artista WHERE nome IS NOT NULL;

-- spoti_pobre=# SELECT COALESCE(nome,nome_artistico) as nome_da_consulta FROM artista;

-- spoti_pobre=# SELECT album.titulo FROM album WHERE extract(year from data_lancamento) = 2023; 

-- plus
--spoti_pobre=# SELECT album.titulo, to_char(album.data_lancamento, 'DD/MM/YYYY') as dt_lancamento, artista.nome_artistico FROM album INNER JOIN artista ON (album.artista_id = artista.id) WHERE extract(year from data_lancamento) = 2023; 

-- spoti_pobre=# SELECT * FROM playlist WHERE EXTRACT(day from data_hora) = extract(day from CURRENT_TIMESTAMP) and extract(month from data_hora) = extract(month from CURRENT_TIMESTAMP) and extract(year from data_hora) = extract(year from current_timestamp);

-- spoti_pobre=# ALTER TABLE musica ADD CONSTRAINT duracao CHECK(duracao > 0);

-- spoti_pobre=# ALTER TABLE usuario ADD UNIQUE(email); 

-- FLAVIO
-- spoti_pobre=# SELECT * FROM artista where upper(nome_artistico) LIKE 'LEO%';

-- FLAVIA
-- spoti_pobre=# SELECT * FROM artista where nome_artistico ILIKE 'Leo%';

-- josue
-- spoti_pobre=# SELECT titulo FROM album WHERE extract(month from data_lancamento) = extract(month from current_date);

-- spoti_pobre=# SELECT * FROM album where extract(year from data_lancamento) = 2022 and extract(month from data_lancamento) >= 7 and extract(month from data_lancamento) <= 12;

-- flavio
-- spoti_pobre=# select * from album where data_lancamento >= '2022-07-01' and data_lancamento <= '2022-12-31';

-- spoti_pobre=# select * from album where data_lancamento >= current_date - interval '30 day';



/* select  
    titulo,  
    CASE 
        WHEN extract(dow from data_lancamento) = 0 then 'Domingo'
        WHEN extract(dow from data_lancamento) = 1 then 'Segunda' 
        WHEN extract(dow from data_lancamento) = 2 then 'Terça'
        WHEN extract(dow from data_lancamento) = 3 then 'Quarta'
        WHEN extract(dow from data_lancamento) = 4 then 'Quinta'
        WHEN extract(dow from data_lancamento) = 5 then 'Sexta'
        WHEN extract(dow from data_lancamento) = 6 then 'Sábado'
    END AS dia_da_semana   
from album;
*/

/*
select  
    titulo,  
    CASE 
        WHEN extract(month from data_lancamento) = 1 then 'Janeiro'
        WHEN extract(month from data_lancamento) = 2 then 'Fevereiro' 
        WHEN extract(month from data_lancamento) = 3 then 'Março'
        WHEN extract(month from data_lancamento) = 4 then 'Abril'
        WHEN extract(month from data_lancamento) = 5 then 'Maio'
        WHEN extract(month from data_lancamento) = 6 then 'Junho'
        WHEN extract(month from data_lancamento) = 7 then 'Julho'
        WHEN extract(month from data_lancamento) = 8 then 'Agosto'
        WHEN extract(month from data_lancamento) = 9 then 'Setembro'
        WHEN extract(month from data_lancamento) = 10 then 'Outubro'
        WHEN extract(month from data_lancamento) = 11 then 'Novembro'
        WHEN extract(month from data_lancamento) = 12 then 'Dezembro'
                              
    END AS mes   
from album;

*/


-- igor
-- spoti_pobre=# SELECT * from album order by data_lancamento ASC LIMIT 1;
-- flavio
-- spoti_pobre=# SELECT * from album WHERE data_lancamento in (select min(data_lancamento) from album);

-- spoti_pobre=# SELECT * from album ORDER BY data_lancamento DESC LIMIT 1;

-- spoti_pobre=# SELECT musica.titulo FROM artista INNER JOIN album ON (artista.id = album.artista_id) INNER JOIN musica ON (musica.album_id = album.id) where artista.id = 2;

-- spoti_pobre=# SELECT musica.titulo FROM artista INNER JOIN album ON (artista.id = album.artista_id) INNER JOIN musica ON (musica.album_id = album.id) where artista.id = 1 and album.titulo = 'Bang';

-- spoti_pobre=# SELECT DISTINCT usuario.nome FROM usuario INNER JOIN playlist ON (usuario.id = playlist.usuario_id);


-- spoti_pobre=# SELECT * FROM artista LEFT join album on (artista.id = album.artista_id) WHERE album.artista_id is null;

-- spoti_pobre=# SELECT * FROM artista where id not in (select artista.id from usuario inner join album on (album.artista_id = artista.id));

-- spoti_pobre=# select coalesce(artista.nome,artista.nome_artistico) from artista EXCEPT (select coalesce(artista.nome, artista.nome_artistico) from artista inner join album on (artista.id = album.artista_id));

-- spoti_pobre=# SELECT * FROM usuario LEFT JOIN playlist on (usuario.id = playlist.usuario_id) where playlist.usuario_id is null;


















