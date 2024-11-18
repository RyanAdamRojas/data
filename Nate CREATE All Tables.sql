CREATE TABLE Supervisor (
    FID INT NOT NULL,
    FEmailAddress VARCHAR(255) NOT NULL,
    FPassword VARCHAR(255) NOT NULL,
    FFirstName VARCHAR(255) NOT NULL,
    FLastName VARCHAR(255) NOT NULL,
    PRIMARY KEY (FID, FEmailAddress),
    FOREIGN KEY (FID, FEmailAddress) 
        REFERENCES FacultyMember (FID, FEmailAddress)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) Engine = InnoDB;

CREATE TABLE Survey (
    SName VARCHAR(255) NOT NULL,
    SListOfParticipants VARCHAR(255),
    SDate Date,
    SQuestions VARCHAR(255),
    PRIMARY KEY (SName)
) Engine = InnoDB;

CREATE TABLE TypeOfSurvey (
    SListOfActivities INT,
    SExtraCurricularActivities INT,
    SAdvisingGroups INT,
    SReviewsOfConferencePapers INT
) Engine = InnoDB;