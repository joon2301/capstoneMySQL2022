-- MySQL Script generated by MySQL Workbench
-- Thu Mar 24 18:20:08 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `AccID` VARCHAR(15) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`AccID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`brainTeaser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`brainTeaser` ;

CREATE TABLE IF NOT EXISTS `mydb`.`brainTeaser` (
  `TeaserID` INT NOT NULL,
  `Teaser` VARCHAR(255) NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `Date` DATETIME NOT NULL,
  INDEX `fk_brainTeaser_users1_idx` (`AccID` ASC) VISIBLE,
  PRIMARY KEY (`TeaserID`),
  CONSTRAINT `fk_brainTeaser_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teaserAnswer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`teaserAnswer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`teaserAnswer` (
  `AnswerID` INT NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `TeaserID` INT NOT NULL,
  `Answer` VARCHAR(255) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`AnswerID`),
  INDEX `fk_teaserAnswer_brainTeaser1_idx` (`TeaserID` ASC) VISIBLE,
  INDEX `fk_teaserAnswer_users1_idx` (`AccID` ASC) VISIBLE,
  CONSTRAINT `fk_teaserAnswer_brainTeaser1`
    FOREIGN KEY (`TeaserID`)
    REFERENCES `mydb`.`brainTeaser` (`TeaserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teaserAnswer_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`community`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`community` ;

CREATE TABLE IF NOT EXISTS `mydb`.`community` (
  `PostID` INT NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `Contents` VARCHAR(500) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`PostID`),
  INDEX `fk_community_users1_idx` (`AccID` ASC) VISIBLE,
  CONSTRAINT `fk_community_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `CommentID` INT NOT NULL,
  `Comment` VARCHAR(100) NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`CommentID`),
  INDEX `fk_comment_users1_idx` (`AccID` ASC) VISIBLE,
  CONSTRAINT `fk_comment_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Community_Answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Community_Answer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Community_Answer` (
  `PostID` INT NOT NULL,
  `CommentID` INT NOT NULL,
  INDEX `fk_community_Answers_community1_idx` (`PostID` ASC) VISIBLE,
  INDEX `fk_Community_Answer_comment1_idx` (`CommentID` ASC) VISIBLE,
  CONSTRAINT `fk_community_Answers_community1`
    FOREIGN KEY (`PostID`)
    REFERENCES `mydb`.`community` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Community_Answer_comment1`
    FOREIGN KEY (`CommentID`)
    REFERENCES `mydb`.`comment` (`CommentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Answer_User_Likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Answer_User_Likes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Answer_User_Likes` (
  `AccID` VARCHAR(15) NOT NULL,
  `AnswerID` INT NOT NULL,
  INDEX `fk_Answer_User_Likes_users1_idx` (`AccID` ASC) VISIBLE,
  INDEX `fk_Answer_User_Likes_teaserAnswer1_idx` (`AnswerID` ASC) VISIBLE,
  CONSTRAINT `fk_Answer_User_Likes_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_User_Likes_teaserAnswer1`
    FOREIGN KEY (`AnswerID`)
    REFERENCES `mydb`.`teaserAnswer` (`AnswerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;