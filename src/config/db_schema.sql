CREATE DATABASE IF NOT EXISTS `cbcfs-database`;

CREATE TABLE IF NOT EXISTS `User` (
  `UserID` INT PRIMARY KEY AUTO_INCREMENT,
  `Username` VARCHAR(255),
  `Password` VARCHAR(255),
  `Email` VARCHAR(255),
  `RoleID` INT,
  `Office365UserID` INT,
  `Office365AccessToken` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Role` (
  `RoleID` INT PRIMARY KEY AUTO_INCREMENT,
  `RoleName` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Office365Users` (
  `Office365UserID` INT PRIMARY KEY AUTO_INCREMENT,
  `Office365Username` VARCHAR(255),
  `Office365Email` VARCHAR(255),
  `AccessToken` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `Case` (
  `CaseID` INT PRIMARY KEY AUTO_INCREMENT,
  `CaseNumber` VARCHAR(255),
  `CaseName` VARCHAR(255),
  `DocketIndexNumber` VARCHAR(255),
  `VoucherNumber` VARCHAR(255),
  `AssignedToUserID` INT,
  `SecondarySWUserID` INT,
  `Status` VARCHAR(255),
  `HoursLimit` INT,
  `Comments` TEXT,
  `ReceivedDate` DATETIME,
  `AdjournedDate` DATE,
  `AdjournedTime` TIME,
  `Court` VARCHAR(255),
  `Judge` VARCHAR(255),
  `ReportContactInfo` VARCHAR(255),
  `Appearance` VARCHAR(255),
  `Report` VARCHAR(255),
  `ReadyToAssign` BOOLEAN,
  `EmailSent` BOOLEAN,
  `Sealed` BOOLEAN,
  `Billed` BOOLEAN,
  `NeedsCorrectOrder` BOOLEAN,
  `CaseType` VARCHAR(255),
  `PreferredAvailability` TEXT,
  `ServiceType` VARCHAR(255),
  `ServiceLocation` VARCHAR(255),
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `CaseNotes` (
  `NoteID` INT PRIMARY KEY AUTO_INCREMENT,
  `Subject` VARCHAR(255),
  `Note` TEXT,
  `CaseID` INT,
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `CourtReports` (
  `ReportID` INT PRIMARY KEY AUTO_INCREMENT,
  `Title` VARCHAR(255),
  `CaseID` INT,
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `DailyActivityReports` (
  `ReportID` INT PRIMARY KEY AUTO_INCREMENT,
  `CaseID` INT,
  `FinishTime` DATETIME,
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `Exported` BOOLEAN,
  `ServiceOrActivity` VARCHAR(255),
  `StartTime` DATETIME,
  `TimeSpent` INT,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `SupplementalOrders` (
  `OrderID` INT PRIMARY KEY AUTO_INCREMENT,
  `Title` VARCHAR(255),
  `CaseID` INT,
  `Status` VARCHAR(255),
  `EstimatedHours` INT,
  `Comment` VARCHAR(255),
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `StatusRemarks` TEXT,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `DocumentLibrary` (
  `DocumentID` INT PRIMARY KEY AUTO_INCREMENT,
  `Title` VARCHAR(255),
  `FilePath` VARCHAR(255),
  `CategoryID` INT,
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `ClientForms` (
  `FormID` INT PRIMARY KEY AUTO_INCREMENT,
  `FormType` VARCHAR(255),
  `FormTitle` VARCHAR(255),
  `FormDescription` TEXT,
  `FilePath` VARCHAR(255),
  `CreatedAt` DATETIME,
  `UpdatedAt` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT
);

CREATE TABLE IF NOT EXISTS `UserRoles` (
  `UserRoleID` INT PRIMARY KEY AUTO_INCREMENT,
  `UserID` INT,
  `RoleID` INT,
  FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`),
  FOREIGN KEY (`RoleID`) REFERENCES `Role`(`RoleID`)
);

CREATE TABLE IF NOT EXISTS `CaseNoteAttachments` (
  `AttachmentID` INT PRIMARY KEY AUTO_INCREMENT,
  `NoteID` INT,
  `FilePath` VARCHAR(255),
  `Created` DATETIME,
  `Modified` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT,
  FOREIGN KEY (`NoteID`) REFERENCES `CaseNotes`(`NoteID`),
  FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`)
);

CREATE TABLE IF NOT EXISTS `CourtReportAttachments` (
  `AttachmentID` INT PRIMARY KEY AUTO_INCREMENT,
  `ReportID` INT,
  `FilePath` VARCHAR(255),
  `Created` DATETIME,
  `Modified` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT,
  FOREIGN KEY (`ReportID`) REFERENCES `CourtReports`(`ReportID`),
  FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`)
);

CREATE TABLE IF NOT EXISTS `SupplementalOrderAttachments` (
  `AttachmentID` INT PRIMARY KEY AUTO_INCREMENT,
  `OrderID` INT,
  `FilePath` VARCHAR(255),
  `Created` DATETIME,
  `Modified` DATETIME,
  `CreatedByUserID` INT,
  `ModifiedByUserID` INT,
  FOREIGN KEY (`OrderID`) REFERENCES `SupplementalOrders`(`OrderID`),
  FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`)
);

-- Adding foreign key relationships for Case table
ALTER TABLE `Case`
  ADD FOREIGN KEY (`AssignedToUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`SecondarySWUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for CaseNotes table
ALTER TABLE `CaseNotes`
  ADD FOREIGN KEY (`CaseID`) REFERENCES `Case`(`CaseID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for CourtReports table
ALTER TABLE `CourtReports`
  ADD FOREIGN KEY (`CaseID`) REFERENCES `Case`(`CaseID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for DailyActivityReports table
ALTER TABLE `DailyActivityReports`
  ADD FOREIGN KEY (`CaseID`) REFERENCES `Case`(`CaseID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for SupplementalOrders table
ALTER TABLE `SupplementalOrders`
  ADD FOREIGN KEY (`CaseID`) REFERENCES `Case`(`CaseID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for DocumentLibrary table
ALTER TABLE `DocumentLibrary`
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for ClientForms table
ALTER TABLE `ClientForms`
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationship for UserRoles table
ALTER TABLE `UserRoles`
  ADD FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`RoleID`) REFERENCES `Role`(`RoleID`);

-- Adding foreign key relationships for CaseNoteAttachments table
ALTER TABLE `CaseNoteAttachments`
  ADD FOREIGN KEY (`NoteID`) REFERENCES `CaseNotes`(`NoteID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for CourtReportAttachments table
ALTER TABLE `CourtReportAttachments`
  ADD FOREIGN KEY (`ReportID`) REFERENCES `CourtReports`(`ReportID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding foreign key relationships for SupplementalOrderAttachments table
ALTER TABLE `SupplementalOrderAttachments`
  ADD FOREIGN KEY (`OrderID`) REFERENCES `SupplementalOrders`(`OrderID`),
  ADD FOREIGN KEY (`CreatedByUserID`) REFERENCES `User`(`UserID`),
  ADD FOREIGN KEY (`ModifiedByUserID`) REFERENCES `User`(`UserID`);

-- Adding indexes for performance optimization

-- Index on UserID in User table
CREATE INDEX idx_user_userid ON `User` (`UserID`);

-- Index on RoleID in Role table
CREATE INDEX idx_role_roleid ON `Role` (`RoleID`);

-- Index on Office365UserID in Office365Users table
CREATE INDEX idx_office365users_office365userid ON `Office365Users` (`Office365UserID`);

-- Index on CaseID in Case table
CREATE INDEX idx_case_caseid ON `Case` (`CaseID`);

-- Index on CaseID in CaseNotes table
CREATE INDEX idx_casenotes_caseid ON `CaseNotes` (`CaseID`);

-- Index on CaseID in CourtReports table
CREATE INDEX idx_courtreports_caseid ON `CourtReports` (`CaseID`);

-- Index on CaseID in DailyActivityReports table
CREATE INDEX idx_dailyactivityreports_caseid ON `DailyActivityReports` (`CaseID`);

-- Index on CaseID in SupplementalOrders table
CREATE INDEX idx_supplementalorders_caseid ON `SupplementalOrders` (`CaseID`);

-- Index on DocumentID in DocumentLibrary table
CREATE INDEX idx_documentlibrary_documentid ON `DocumentLibrary` (`DocumentID`);

-- Index on FormID in ClientForms table
CREATE INDEX idx_clientforms_formid ON `ClientForms` (`FormID`);

-- Index on UserID in UserRoles table
CREATE INDEX idx_userroles_userid ON `UserRoles` (`UserID`);

-- Index on NoteID in CaseNoteAttachments table
CREATE INDEX idx_casenoteattachments_noteid ON `CaseNoteAttachments` (`NoteID`);

-- Index on ReportID in CourtReportAttachments table
CREATE INDEX idx_courtreportattachments_reportid ON `CourtReportAttachments` (`ReportID`);

-- Index on OrderID in SupplementalOrderAttachments table
CREATE INDEX idx_supplementalorderattachments_orderid ON `SupplementalOrderAttachments` (`OrderID`);
