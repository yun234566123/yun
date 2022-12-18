CREATE TABLE users( 
	userID VARCHAR2(20),
	userPassword VARCHAR2(20),
	userName VARCHAR2(20),
	userPhone VARCHAR2(20),
	userEmail VARCHAR2(50),
	PRIMARY KEY(userID)
);

CREATE TABLE bbs(
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR2(20),
	bbsDate DATETIME,
	bbsContent VARCHAR2(2048),
	bbsAvailable INT,
	PRIMARY KEY(bbsID)
);