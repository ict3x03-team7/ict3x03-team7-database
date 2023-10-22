USE RecipeHub;

CREATE TABLE
    `file` (
        `FileID` BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN (UUID (), TRUE)),
        `OriginalFileName` VARCHAR(1024) NOT NULL,
        `FileSize` INT NOT NULL,
        PRIMARY KEY (`FileID`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE
    `user` (
        `UserID` BINARY(16) NOT NULL DEFAULT (UUID_TO_BIN (UUID (), TRUE)),
        `FirstName` VARCHAR(255) NOT NULL,
        `LastName` VARCHAR(255) NOT NULL,
        `Email` VARCHAR(255) NOT NULL UNIQUE,
        `Password` VARCHAR(127) NOT NULL,
        `Role` VARCHAR(32) NOT NULL,
        `Gender` VARCHAR(32) NOT NULL,
        `MobileNumber` INT NOT NULL,
        `LastLogin` TIMESTAMP NULL DEFAULT NULL,
        `StudentID` VARCHAR(255) NULL DEFAULT NULL,
        `ProfilePictureID` BINARY(16) DEFAULT NULL DEFAULT (UUID_TO_BIN (UUID (), TRUE)),
        `MFA_QR` TEXT NULL DEFAULT NULL,
        `MFA_Secret` VARCHAR(255) DEFAULT NULL,
        `Locked` TINYINT (1) NOT NULL DEFAULT 0,
        PRIMARY KEY (`UserID`),
        KEY `ProfilePictureIDFK_idx` (`ProfilePictureID`),
        CONSTRAINT `ProfilePictureID` FOREIGN KEY (`ProfilePictureID`) REFERENCES `file` (`FileID`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;