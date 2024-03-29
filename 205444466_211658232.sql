--Aviad Shalom Tzemah 211658232
--Dor Bierendorf 205444466
CREATE TABLE IF NOT EXISTS Employee(
	"EID" INTEGER PRIMARY KEY,
	"FirstName" VARCHAR(50),
	"LastName" VARCHAR(50),
	"BirthDate" DATE,
	"City" VARCHAR(50),
	"StreetName" VARCHAR(50),
	"Number" INTEGER,
	"Door" INTEGER
);

CREATE TABLE IF NOT EXISTS EmployeeCellPhoneNumber(
	"Phone" VARCHAR(50) PRIMARY KEY,
	"EID" INTEGER,
	FOREIGN KEY ("EID") REFERENCES Employee("EID") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS OfficialEmployee(
	"EID" INTEGER PRIMARY KEY,
	"Department" INTEGER,
	"StartWorkingDate" DATE,
	"Degree" VARCHAR(50),
	FOREIGN KEY ("EID") REFERENCES Employee("EID") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("Department") REFERENCES Department("DID") ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ConstructorEmployee(
	"EID" INTEGER PRIMARY KEY,
	"CompanyName" VARCHAR(50),
	"SalaryPerDay" INTEGER,
	FOREIGN KEY ("EID") REFERENCES Employee("EID") ON DELETE CASCADE ON UPDATE CASCADE, 
	CONSTRAINT "ch_salaryNotNegative" CHECK("SalaryPerDay" >= 0)
);

CREATE TABLE IF NOT EXISTS Department(
	"DID" INTEGER PRIMARY KEY,
	"ManagerID" INTEGER,
	"Name" VARCHAR(50),
	"Description" TEXT,
	FOREIGN KEY ("ManagerID") REFERENCES OfficialEmployee("EID") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Project(
	"PID" INTEGER PRIMARY KEY,
	"Neighborhood" INTEGER, 
	"Name" VARCHAR(50),
	"Description" TEXT,
	"Budget" INTEGER,
	FOREIGN KEY ("Neighborhood") REFERENCES Neighborhood("NID") ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS ProjectConstructorEmployee(
	"EID" INTEGER,
	"PID" INTEGER,
	"StartWorkingDate" DATE,
	"EndWorkingDate" DATE,
	"JobDescription" TEXT,
	FOREIGN KEY ("EID") REFERENCES ConstructorEmployee("EID") ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY ("PID") REFERENCES Project("PID") ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "ch_startBeforeEnd" CHECK("StartWorkingDate" <= "EndWorkingDate")
	
);

CREATE TABLE IF NOT EXISTS Neighborhood(
	"NID" INTEGER PRIMARY KEY,
	"Name" VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Apartment(
	"StreetName" VARCHAR(50),
	"Number" INTEGER,
	"Door" INTEGER,
	"NID" INTEGER, 
	"Type" VARCHAR(50),
	"SizeSquareMeter" INTEGER,
	PRIMARY KEY("StreetName", "Number", "Door"),
	FOREIGN KEY ("NID") REFERENCES Neighborhood("NID") ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT "ch_ssmNotNegative" CHECK ("SizeSquareMeter" >= 0)
);

CREATE TABLE IF NOT EXISTS Resident(
	"RID" INTEGER PRIMARY KEY,
	"FirstName" VARCHAR(50),
	"LastName" VARCHAR(50),
	"BirthDate" DATE,
	"StreetName" VARCHAR(50),
	"Number" INTEGER,
	"Door" INTEGER,
	FOREIGN KEY ("StreetName", "Number", "Door") REFERENCES Apartment("StreetName", "Number", "Door") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS TrashCan(
	"CatalogID" INTEGER PRIMARY KEY,
	"CreationDate" DATE,
	"ExpirationDate" DATE,
	"RID" INTEGER,
	FOREIGN KEY ("RID") REFERENCES Resident("RID") ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "ch_creationBeforeExp" CHECK ("CreationDate" <= "ExpirationDate")
);

CREATE TABLE IF NOT EXISTS ParkingArea(
	"AID" INTEGER PRIMARY KEY,
	"Name" VARCHAR(50),
	"NID" INTEGER,
	"PricePerHour" INTEGER,
	"MaxPricePerDay", INTEGER,
	FOREIGN KEY ("NID") REFERENCES Neighborhood("NID") ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "ch_pphNotNegativeAndSmallerThanMax" CHECK ("PricePerHour" >= 0 AND "PricePerHour" <= "MaxPricePerDay"),
	CONSTRAINT "ch_mppdNotNegative" CHECK ("MaxPricePerDay" >= 0)
);

CREATE TABLE IF NOT EXISTS Car(
	"CID" INTEGER PRIMARY KEY,
	"CellPhoneNumber" VARCHAR(50),
	"CreditCard" VARCHAR(50),
	"ExpirationDate" DATE,
	"ThreeDigits" VARCHAR(10),
	"ID" VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS CarParking(
	"CID" INTEGER,
	"AID" INTEGER,
	"StartTime" DATETIME,
	"EndTime" DATETIME,
	"Cost" INTEGER,
	"MaxPricePerDay" INTEGER,
	PRIMARY KEY ("CID", "StartTime"),
	FOREIGN KEY ("CID") REFERENCES Car("CID") ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("AID") REFERENCES ParkingArea("AID") ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "ch_startBeforeEnd" CHECK ("StartTime" <= "EndTime"),
	CONSTRAINT "ch_costLessThanMax" CHECK ("Cost" <= "MaxPricePerDay"),
	CONSTRAINT "ch_costNotNegative" CHECK ("Cost" >= 0)
);
	
	


	


	


	