-- mysql-init/schema.sql
-- Este script se ejecuta automáticamente cuando el contenedor MySQL se inicia por primera vez.

-- Crea la base de datos 'guestbook_db' si no existe.
CREATE DATABASE IF NOT EXISTS guestbook_db;

-- Selecciona la base de datos para las operaciones siguientes.
USE guestbook_db;

-- Crea la tabla 'entries' si no existe.
-- Esta tabla almacenará las entradas del libro de visitas.
CREATE TABLE IF NOT EXISTS entries (
    id INT AUTO_INCREMENT PRIMARY KEY, -- ID único para cada entrada.
    email VARCHAR(255) UNIQUE, -- Correo electrónico del visitante, debe ser único.
    visits INT DEFAULT 0, -- Número de visitas del visitante, por defecto es 0.
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP -- Marca de tiempo de la creación.
);

