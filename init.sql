-- init.sql: schema + test data for MVP

-- Ensure MySQL interprets this file as UTF-8.
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  display_name VARCHAR(100) NOT NULL,
  color VARCHAR(7) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS criteria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  max_score TINYINT NOT NULL DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS votes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  project_id INT NOT NULL,
  criteria_id INT NOT NULL,
  score TINYINT NOT NULL,
  is_public_initiative BOOLEAN NOT NULL DEFAULT FALSE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_votes_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_votes_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  CONSTRAINT fk_votes_criteria FOREIGN KEY (criteria_id) REFERENCES criteria(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO users (username, password_hash, display_name, color)
VALUES
  ('judge1',  '$2b$12$4svAQN7Tcnoz6keZycKbHuec8mLU7StfjDbLg5MsItGiuel6jPisG', 'Эксперт 1',  '#FF6B6B'),
  ('judge2',  '$2b$12$fqAhg9warvVEDmOg2QdsU.y.Ay6FvAkGIdJAxeruW0ik7DHzG2Ed.', 'Эксперт 2',  '#4ECDC4'),
  ('judge3',  '$2b$12$OArMxf2/GM3dyzUoXUE.L.jZ1jHERV6jsbd8.ZUWteuMZoLgeuNby', 'Эксперт 3',  '#FFE66D'),
  ('judge4',  '$2b$12$lXyE0maMNAy.voXQrO8Wz.F4F1GNvFIWdw/1RrT581pvZmz4FgqMK', 'Эксперт 4',  '#A8E6CF'),
  ('judge5',  '$2b$12$Fd5X5sYENj/NgtsMdnlVyehC6c/lzSsZJl3nI.UOc57QuRfUGLrVu', 'Эксперт 5',  '#FFD3B6'),
  ('judge6',  '$2b$12$NCi2oQjSs3Bf9YeJ7GJAqO.NwI6bKKPrSrUhzT37vCPpKsAsLsQ7e', 'Эксперт 6',  '#D4A5A5'),
  ('judge7',  '$2b$12$vJQtbhGzW.DuVjaBSFd53.W7dL8xmAV6mhuTYm255hqeSK9XGmM2.', 'Эксперт 7',  '#B5EAD7'),
  ('judge8',  '$2b$12$eX/dgjimRX7uncaREZfzJO3QifZQQ.BZ8tTIeXurrcfETb4wZGYuu',  'Эксперт 8',  '#C7CEEA'),
  ('judge9',  '$2b$12$46ydw.kw1JSCwmPHDLPDU.pIIzIbBYjqJHVdibpKdTRrSQLe4a65a', 'Эксперт 9',  '#FFDAC1'),
  ('judge10', '$2b$12$396qp67jerMbe9rlpWKyre5N2.9/VJYtFSlm4gsmRBcRLD.Cx1il2',  'Эксперт 10', '#E2F0CB')
ON DUPLICATE KEY UPDATE
  password_hash = VALUES(password_hash);

INSERT INTO criteria (name, max_score)
VALUES
  ('Инновационность', 5),
  ('Реализуемость', 5),
  ('Финансовый эффект', 5),
  ('Стратегическая согласованность', 5),
  ('Влияние на операционную деятельность (процесс)', 5)
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  max_score = VALUES(max_score);
