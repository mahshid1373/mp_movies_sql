-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema movies_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movies_schema
-- -----------------------------------------------------
USE movies_schema ;

-- -----------------------------------------------------
-- Table `mydb`.`movies_metadata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_schema`.`movies_metadata` (
    `adult` TINYINT NULL,
    `belongs_to_collection` VARCHAR(100) NULL,
    `budget` INT NULL,
    `genres` VARCHAR(45) NULL,
    `homepage` VARCHAR(45) NULL,
    `id` INT NOT NULL,
    `imdb_id` INT NULL,
    `original_language` VARCHAR(45) NULL,
    `original_title` VARCHAR(45) NULL,
    `overview` VARCHAR(45) NULL,
    `popularity` VARCHAR(45) NULL,
    `poster_path` VARCHAR(45) NULL,
    `production_companies` VARCHAR(45) NULL,
    `production_countries` VARCHAR(45) NULL,
    `release_date` DATE NULL,
    `revenue` INT NULL,
    `runtime` DECIMAL(5, 2) NULL,  -- Adjusted precision and scale
    `spoken_languages` VARCHAR(45) NULL,
    `status` VARCHAR(45) NULL,
    `tagline` VARCHAR(45) NULL,
    `title` VARCHAR(45) NULL,
    `video` VARCHAR(45) NULL,
    `vote_average` DECIMAL(3, 1) NULL,  -- Adjusted precision and scale
    `vote_count` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `imdb_id_idx` (`imdb_id` ASC) VISIBLE,
    CONSTRAINT `imdb_id`
        FOREIGN KEY (`imdb_id`)
        REFERENCES `movies_schema`.`links_small` (`movieId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`links_small`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_schema`.`links_small` (
  `movieId` INT NOT NULL,
  `imdbId` INT NULL,
  `tmdbId` INT NULL,
  PRIMARY KEY (`movieId`),
  INDEX `imdbId_idx` (`imdbId` ASC) VISIBLE,
  CONSTRAINT `imdbId`
    FOREIGN KEY (`imdbId`)
    REFERENCES `movies_schema`.`movies_metadata` (`imdb_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ratings_small`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_schema`.`ratings_small` (
  `userId` INT NOT NULL,
  `movieId` INT NOT NULL,
  `rating` DECIMAL(100) NULL,
  `timestamp` INT NULL,
  PRIMARY KEY (`userId`),
  INDEX `movieId_idx` (`movieId` ASC) VISIBLE,
  CONSTRAINT `movieId`
    FOREIGN KEY (`movieId`)
    REFERENCES `movies_schema`.`links_small` (`movieId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
