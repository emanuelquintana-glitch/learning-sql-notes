-- Sakila Database Schema
-- Based on MySQL Sample Database

DROP DATABASE IF EXISTS sakila;
CREATE DATABASE sakila;
USE sakila;

-- Table: actor
CREATE TABLE actor (
    actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id),
    KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film
CREATE TABLE film (
    film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR DEFAULT NULL,
    language_id TINYINT UNSIGNED NOT NULL,
    original_language_id TINYINT UNSIGNED DEFAULT NULL,
    rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT UNSIGNED DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM("G","PG","PG-13","R","NC-17") DEFAULT "G",
    special_features SET("Trailers","Commentaries","Deleted Scenes","Behind the Scenes") DEFAULT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (film_id),
    KEY idx_title (title),
    KEY idx_fk_language_id (language_id),
    KEY idx_fk_original_language_id (original_language_id),
    CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film_actor
CREATE TABLE film_actor (
    actor_id SMALLINT UNSIGNED NOT NULL,
    film_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    KEY idx_fk_film_id (film_id),
    CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: category
CREATE TABLE category (
    category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(25) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: film_category
CREATE TABLE film_category (
    film_id SMALLINT UNSIGNED NOT NULL,
    category_id TINYINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (film_id, category_id),
    CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: language
CREATE TABLE language (
    language_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name CHAR(20) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (language_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: inventory
CREATE TABLE inventory (
    inventory_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    film_id SMALLINT UNSIGNED NOT NULL,
    store_id TINYINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (inventory_id),
    KEY idx_fk_film_id (film_id),
    KEY idx_store_id_film_id (store_id, film_id),
    CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: store
CREATE TABLE store (
    store_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    manager_staff_id TINYINT UNSIGNED NOT NULL,
    address_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEF_id),
    KEY idx_fk_address_id (address_id),
    CONSTRAINT fk_store_staff FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

