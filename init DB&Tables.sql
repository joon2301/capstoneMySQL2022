-- MySQL Script generated by MySQL Workbench
-- Mon May 30 16:05:57 2022
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
  `SubscriptionID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`brainTeaser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`brainTeaser` ;

CREATE TABLE IF NOT EXISTS `mydb`.`brainTeaser` (
  `TeaserID` INT NOT NULL,
  `Title` VARCHAR(100) NOT NULL,
  `Teaser` VARCHAR(500) NOT NULL,
  `Category` VARCHAR(15) NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Clicked` INT NOT NULL DEFAULT 0,
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
  `Answer` VARCHAR(500) NOT NULL,
  `Date` DATETIME NOT NULL,
  `ParentID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnswerID`),
  INDEX `fk_teaserAnswer_brainTeaser1_idx` (`TeaserID` ASC) VISIBLE,
  INDEX `fk_teaserAnswer_users1_idx` (`AccID` ASC) VISIBLE,
  INDEX `fk_teaserAnswer_teaserAnswer1_idx` (`ParentID` ASC) VISIBLE,
  CONSTRAINT `fk_teaserAnswer_brainTeaser1`
    FOREIGN KEY (`TeaserID`)
    REFERENCES `mydb`.`brainTeaser` (`TeaserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teaserAnswer_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teaserAnswer_teaserAnswer1`
    FOREIGN KEY (`ParentID`)
    REFERENCES `mydb`.`teaserAnswer` (`AnswerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`community`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`community` ;

CREATE TABLE IF NOT EXISTS `mydb`.`community` (
  `PostID` INT NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `Contents` VARCHAR(500) NOT NULL,
  `Category` VARCHAR(15) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Clicked` INT NOT NULL DEFAULT 0,
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
  `AccID` VARCHAR(15) NOT NULL,
  `PostID` INT NOT NULL,
  `Comment` VARCHAR(100) NOT NULL,
  `Date` DATETIME NOT NULL,
  `ParentID` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`CommentID`),
  INDEX `fk_comment_users1_idx` (`AccID` ASC) VISIBLE,
  INDEX `fk_comment_community1_idx` (`PostID` ASC) VISIBLE,
  INDEX `fk_comment_comment1_idx` (`ParentID` ASC) VISIBLE,
  CONSTRAINT `fk_comment_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_community1`
    FOREIGN KEY (`PostID`)
    REFERENCES `mydb`.`community` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`ParentID`)
    REFERENCES `mydb`.`comment` (`CommentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comment_User_Likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Comment_User_Likes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Comment_User_Likes` (
  `AccID` VARCHAR(15) NOT NULL,
  `CommentID` INT NOT NULL,
  INDEX `fk_Community_Answer_comment1_idx` (`CommentID` ASC) VISIBLE,
  INDEX `fk_Community_Comments_users1_idx` (`AccID` ASC) VISIBLE,
  CONSTRAINT `fk_Community_Answer_comment1`
    FOREIGN KEY (`CommentID`)
    REFERENCES `mydb`.`comment` (`CommentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Community_Comments_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
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


-- -----------------------------------------------------
-- Table `mydb`.`subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`subscription` ;

CREATE TABLE IF NOT EXISTS `mydb`.`subscription` (
  `Subscription` VARCHAR(15) NOT NULL,
  `Price` INT NOT NULL,
  PRIMARY KEY (`Subscription`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subscribers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`subscribers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`subscribers` (
  `SubscriptionID` INT NOT NULL,
  `AccID` VARCHAR(15) NOT NULL,
  `SubscribeDate` DATETIME NOT NULL,
  `Subscription` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`SubscriptionID`),
  INDEX `fk_Subscribers_Subscription1_idx` (`Subscription` ASC) VISIBLE,
  INDEX `fk_Subscribers_users1_idx` (`AccID` ASC) VISIBLE,
  CONSTRAINT `fk_Subscribers_Subscription1`
    FOREIGN KEY (`Subscription`)
    REFERENCES `mydb`.`subscription` (`Subscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscribers_users1`
    FOREIGN KEY (`AccID`)
    REFERENCES `mydb`.`users` (`AccID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`final_Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`final_Answer` (`AnswerID` INT, `AccID` INT, `Answer` INT, `Date` INT, `TeaserID` INT, `Likes` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`final_Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`final_Comment` (`CommentID` INT, `AccID` INT, `Comment` INT, `Date` INT, `PostID` INT, `Likes` INT, `ParentID` INT);

-- -----------------------------------------------------
-- View `mydb`.`final_Answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`final_Answer`;
DROP VIEW IF EXISTS `mydb`.`final_Answer` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `final_Answer`AS
select a.AnswerID,a.AccID,a.Answer,a.Date,a.TeaserID,b.Likes From teaserAnswer as a left outer join (
select a.AnswerID,count(*) as Likes from teaserAnswer as a inner join Answer_User_Likes as b on a.AnswerID = b.AnswerID group by AnswerID)
as b on a.AnswerID = b.AnswerID;

-- -----------------------------------------------------
-- View `mydb`.`final_Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`final_Comment`;
DROP VIEW IF EXISTS `mydb`.`final_Comment` ;
USE `mydb`;
CREATE OR REPLACE VIEW `final_Comment` AS
select a.CommentID,a.AccID,a.Comment,a.Date,a.PostID,b.Likes,a.ParentID From comment as a left outer join (
select a.CommentID,count(*) as Likes from comment as a inner join Comment_User_Likes as b on a.PostID = b.CommentID group by CommentID)
as b on a.CommentID = b.CommentID;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
