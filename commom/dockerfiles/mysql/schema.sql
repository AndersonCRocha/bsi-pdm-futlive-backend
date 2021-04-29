DROP DATABASE IF EXISTS futlive;
CREATE DATABASE futlive;

USE futlive;

CREATE TABLE championships(
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  number_of_rounds INTEGER NOT NULL
);

CREATE TABLE teams (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  shield VARCHAR(255) NOT NULL
);

CREATE TABLE team_championship (
  team_id INTEGER NOT NULL,
  championship_id INTEGER NOT NULL,
  classification INTEGER NOT NULL,
  CONSTRAINT fk_championship FOREIGN KEY (championship_id) REFERENCES championships(id),
  CONSTRAINT fk_team FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE players (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  position VARCHAR(255) NOT NULL,
  number INTEGER NOT NULL,
  team_id INTEGER NOT NULL,
  is_scaled TINYINT NOT NULL DEFAULT 1,
  CONSTRAINT fk_team_players FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE games (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  stadium VARCHAR(255) NOT NULL,
  round INTEGER NOT NULL,
  date DATETIME NOT NULL,
  championship_id INTEGER NOT NULL,
  home_team_id INTEGER NOT NULL,
  home_team_goals INTEGER NOT NULL DEFAULT 0,
  visiting_team_id INTEGER NOT NULL,
  visiting_team_goals INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT fk_championship_games FOREIGN KEY (championship_id) REFERENCES championships(id),
  CONSTRAINT fk_home_team FOREIGN KEY (home_team_id) REFERENCES team_championship(team_id),
  CONSTRAINT fk_visiting_team FOREIGN KEY (visiting_team_id) REFERENCES team_championship(team_id)
);

INSERT INTO championships (id, name, number_of_rounds)
VALUES 
  (1, 'Campeonato Brasileiro', 32),
  (2, 'Campeonato Paulista', 11);

INSERT INTO teams (id, name, shield)
VALUES
  (1, 'América-MG', 'america-mg'),
  (2, 'Atlético-GO', 'athletico-go'),
  (3, 'Atlético-MG', 'athletico-mg'),
  (4, 'Bahia', 'bahia'),
  (5, 'Bragantino', 'bragantino'),
  (6, 'Ceará', 'ceara'),
  (7, 'Chapecoense', 'chapecoense'),
  (8, 'Corinthians', 'corinthians'),
  (9, 'Cuiabá', 'cuiaba'),
  (10, 'Fortaleza', 'fortaleza'),
  (11, 'Flamengo', 'flamengo'),
  (12, 'Fluminense', 'fluminense'),
  (13, 'Grêmio', 'gremio'),
  (14, 'Internacional', 'internacional'),
  (15, 'Juventude', 'juventude'),
  (16, 'Palmeiras', 'palmeiras'),
  (17, 'Santos', 'santos'),
  (18, 'São Paulo', 'sao-paulo'),
  (19, 'Sport', 'sport'),
  (20, 'Vasco', 'vasco');

INSERT INTO team_championship (team_id, championship_id, classification)
VALUES
  (1, 1, 11),
  (2, 1, 19),
  (3, 1, 16),
  (4, 1, 17),
  (5, 1, 18),
  (6, 1, 1),
  (7, 1, 9),
  (8, 1, 5),
  (9, 1, 6),
  (10, 1, 7),
  (11, 1, 4),
  (12, 1, 2),
  (13, 1, 3),
  (14, 1, 8),
  (15, 1, 11),
  (16, 1, 13),
  (17, 1, 14),
  (18, 1, 15),
  (19, 1, 12),
  (20, 1, 10);

INSERT INTO players (name, position, number, team_id)
VALUES
  ('Borges', 'Goleiro', 22, 12), -- Fluminense
  ('Kanu', 'Zagueiro', 2, 12), -- Fluminense
  ('Gilvan', 'Zagueiro', 4, 12), -- Fluminense
  ('Lemos', 'Lateral direito', 13, 12), -- Fluminense
  ('Carioca', 'Lateral esquerdo', 6, 12), -- Fluminense
  ('Ricardinho', 'Meio campista', 8, 12), -- Fluminense
  ('Frizzo', 'Meio campista', 45, 12), -- Fluminense
  ('Otavio', 'Meio campista', 23, 12), -- Fluminense
  ('Antônio', 'Atacante', 90, 12), -- Fluminense
  ('Ferreira', 'Atacante', 17, 12), -- Fluminense
  ('Matheus', 'Centroavante', 9, 12), -- Fluminense

  ('Alves', 'Goleiro', 1, 11), -- Flamengo
  ('Arão', 'Zagueiro', 5, 11), -- Flamengo
  ('Viana', 'Zagueiro', 30, 11), -- Flamengo
  ('Isla', 'Lateral direito', 44, 11), -- Flamengo
  ('Felipe Luís', 'Lateral esquerdo', 16, 11), -- Flamengo
  ('Gomes', 'Meio campista', 35, 11), -- Flamengo
  ('Diego', 'Meio campista', 10, 11), -- Flamengo
  ('Ribeiro', 'Meio campista', 7, 11), -- Flamengo
  ('Gerson', 'Atacante', 8, 11), -- Flamengo
  ('Gabi Gol', 'Atacante', 9, 11), -- Flamengo
  ('Bruno Henrique', 'Atacante', 27, 11), -- Flamengo

  ('Weverton', 'Goleiro', 21, 16), -- Palmeiras
  ('Luan', 'Zagueiro', 13, 16), -- Palmeiras
  ('Gustavo Gómez', 'Zagueiro', 15, 16), -- Palmeiras
  ('Marcos Rocha', 'Lateral direito', 2, 16), -- Palmeiras
  ('Matías Viña', 'Lateral esquerdo', 17, 16), -- Palmeiras
  ('Felipe Melo', 'Meio campista', 30, 16), -- Palmeiras
  ('Danilo', 'Meio campista', 28, 16), -- Palmeiras
  ('Raphael Veiga', 'Meio campista', 23, 16), -- Palmeiras
  ('Wesley', 'Atacante', 11, 16), -- Palmeiras
  ('Rony', 'Atacante', 7, 16), -- Palmeiras
  ('Luiz Adriano', 'Atacante', 10, 16), -- Palmeiras

  ('Breno', 'Goleiro', 21, 13), -- Grêmio
  ('Rodrigues', 'Zagueiro', 13, 13), -- Grêmio
  ('Kannemann', 'Zagueiro', 15, 13), -- Grêmio
  ('Felipe', 'Lateral direito', 2, 13), -- Grêmio
  ('Bruno Cortez', 'Lateral esquerdo', 17, 13), -- Grêmio
  ('Maicon', 'Meio campista', 30, 13), -- Grêmio
  ('Matheus Henrique', 'Meio campista', 28, 13), -- Grêmio
  ('Alisson', 'Meio campista', 23, 13), -- Grêmio
  ('Jean Pyerre', 'Atacante', 11, 13), -- Grêmio
  ('Ferreira', 'Atacante', 7, 13), -- Grêmio
  ('Diego Souza', 'Atacante', 10, 13),
  
  ('Alves', 'Goleiro', 1, 14), -- Internacional
  ('Arão', 'Zagueiro', 5, 14), -- Internacional
  ('Viana', 'Zagueiro', 30, 14), -- Internacional
  ('Felipe', 'Lateral direito', 2, 14), -- Internacional
  ('Bruno Cortez', 'Lateral esquerdo', 17, 14), -- Internacional
  ('Maicon', 'Meio campista', 30, 14), -- Internacional
  ('Matheus Henrique', 'Meio campista', 28, 14), -- Internacional
  ('Alisson', 'Meio campista', 23, 14), -- Internacional
  ('Jean Pyerre', 'Atacante', 11, 14), -- Internacional
  ('Ferreira', 'Atacante', 7, 14), -- Internacional
  ('Diego Souza', 'Atacante', 10, 14), -- Internacional
  
  ('Breno', 'Goleiro', 21, 9), -- Cuiabá
  ('Rodrigues', 'Zagueiro', 13, 9), -- Cuiabá
  ('Kannemann', 'Zagueiro', 15, 9), -- Cuiabá
  ('Felipe', 'Lateral direito', 2, 9), -- Cuiabá
  ('Bruno Cortez', 'Lateral esquerdo', 17, 9), -- Cuiabá
  ('Maicon', 'Meio campista', 30, 9), -- Cuiabá
  ('Matheus Henrique', 'Meio campista', 28, 9), -- Cuiabá
  ('Alisson', 'Meio campista', 23, 9), -- Cuiabá
  ('Jean Pyerre', 'Atacante', 11, 9), -- Cuiabá
  ('Ferreira', 'Atacante', 7, 9), -- Cuiabá
  ('Diego Souza', 'Atacante', 10, 9), -- Cuiabá

  ('Breno', 'Goleiro', 21, 8), -- Corinthians
  ('Rodrigues', 'Zagueiro', 13, 8), -- Corinthians
  ('Kannemann', 'Zagueiro', 15, 8), -- Corinthians
  ('Felipe', 'Lateral direito', 2, 8), -- Corinthians
  ('Bruno Cortez', 'Lateral esquerdo', 17, 8), -- Corinthians
  ('Maicon', 'Meio campista', 30, 8), -- Corinthians
  ('Matheus Henrique', 'Meio campista', 28, 8), -- Corinthians
  ('Alisson', 'Meio campista', 23, 8), -- Corinthians
  ('Jean Pyerre', 'Atacante', 11, 8), -- Corinthians
  ('Ferreira', 'Atacante', 7, 8), -- Corinthians
  ('Diego Souza', 'Atacante', 10, 8), -- Corinthians
  
  ('Breno', 'Goleiro', 21, 20), -- Vasco
  ('Rodrigues', 'Zagueiro', 13, 20), -- Vasco
  ('Kannemann', 'Zagueiro', 15, 20), -- Vasco
  ('Felipe', 'Lateral direito', 2, 20), -- Vasco
  ('Bruno Cortez', 'Lateral esquerdo', 17, 20), -- Vasco
  ('Maicon', 'Meio campista', 30, 20), -- Vasco
  ('Matheus Henrique', 'Meio campista', 28, 20), -- Vasco
  ('Alisson', 'Meio campista', 23, 20), -- Vasco
  ('Jean Pyerre', 'Atacante', 11, 20), -- Vasco
  ('Ferreira', 'Atacante', 7, 20), -- Vasco
  ('Diego Souza', 'Atacante', 10, 20); -- Vasco

INSERT INTO games (stadium, round, date, championship_id, home_team_id, home_team_goals, visiting_team_id, visiting_team_goals)
VALUES
  ('Maracanã', 6, '2021-04-15 18:30:00', 1, 12, 1, 11, 1),
  ('Pacaembu', 6, '2021-04-14 18:00:00', 1, 16, 1, 13, 2),
  ('Beira-Rio', 6, '2021-04-12 16:00:00', 1, 14, 2, 9, 0),
  ('Itaquerão', 6, '2021-04-11 16:00:00', 1, 8, 3, 20, 1);