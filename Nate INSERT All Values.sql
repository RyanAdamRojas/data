INSERT INTO Supervisor VALUES(1, "jsmith@utep.edu", "Password123", "John", "Smith"); 
INSERT INTO Supervisor VALUES(3, "mgarcia@utep.edu", "MG9189", "Michael", "Garcia"); 
INSERT INTO Supervisor VALUES(5, "ghouse@utep.edu", "Cane2342", "Gregory", "House");

INSERT INTO Survey (SName) VALUES ("Miners Welcome Survey");
INSERT INTO Survey  VALUES ("Game Attendance Survey", "John Hucklebee", '2024-11-13',"Did you attend the game");
INSERT INTO Survey  (SName, SDate) VALUES ("End of year survey", '2024-12-13');

INSERT INTO TypeOfSurvey VALUES(1,2,3,2);
INSERT INTO TypeOfSuvery(SExtraCurricularActivites) VALUES(10);
INSERT INTO TypeOfSuvery(SAdvisingGroups) VALUES(4);