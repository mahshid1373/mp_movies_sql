-- Disable foreign key checks to avoid issues while creating tables
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Use the correct schema
USE movies_schema;

-- Drop existing tables if necessary to avoid conflicts
DROP TABLE IF EXISTS `movies_schema`.`ratings_small`;
DROP TABLE IF EXISTS `movies_schema`.`movies_metadata`;
DROP TABLE IF EXISTS `movies_schema`.`links_small`;

-- Create `links_small` table
CREATE TABLE IF NOT EXISTS `movies_schema`.`links_small` (
    `movieId` INT NOT NULL,
    `imdbId` INT NULL,
    `tmdbId` INT NULL,
    PRIMARY KEY (`movieId`),
    UNIQUE INDEX `unique_imdbId` (`imdbId` ASC)
) ENGINE = InnoDB;

-- Create `movies_metadata` table
CREATE TABLE IF NOT EXISTS `movies_schema`.`movies_metadata` (
    `adult` TINYINT(1) NULL,
    `budget` INT NULL,
    `genres` VARCHAR(45) NULL,
    `id` INT NOT NULL,
    `imdb_id` INT NULL,
    `original_language` VARCHAR(45) NULL,
    `original_title` VARCHAR(45) NULL,
    `popularity` VARCHAR(45) NULL,
    `production_companies` VARCHAR(45) NULL,
    `production_countries` VARCHAR(45) NULL,
    `release_date` DATE NULL,
    `revenue` INT NULL,
    `runtime` DECIMAL(5, 2) NULL,
    `spoken_languages` VARCHAR(45) NULL,
    `status` VARCHAR(45) NULL,
    `title` VARCHAR(45) NULL,
    `vote_average` DECIMAL(3, 1) NULL,
    `vote_count` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `imdb_id_idx` (`imdb_id` ASC) VISIBLE,
    CONSTRAINT `fk_imdb_id`
        FOREIGN KEY (`imdb_id`)
        REFERENCES `movies_schema`.`links_small` (`imdbId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Create `ratings_small` table
CREATE TABLE IF NOT EXISTS `movies_schema`.`ratings_small` (
    `userId` INT NOT NULL,
    `movieId` INT NOT NULL,
    `rating` DECIMAL(3, 1) NULL,
    `timestamp` INT NULL,
    PRIMARY KEY (`userId`),
    INDEX `movieId_idx` (`movieId` ASC) VISIBLE,
    CONSTRAINT `fk_movieId`
        FOREIGN KEY (`movieId`)
        REFERENCES `movies_schema`.`links_small` (`movieId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Re-enable foreign key checks
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
