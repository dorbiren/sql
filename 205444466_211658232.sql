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
	FOREIGN KEY ("EID") REFERENCES Employee("EID")
);

CREATE TABLE IF NOT EXISTS OfficialEmployee(
	"EID" INTEGER,
	"DepartmentID" INTEGER,
	"StartWokringDate" DATE,
	"Degree" VARCHAR(50),
	FOREIGN KEY ("EID") REFERENCES Employee("EID"),
	FOREIGN KEY ("DepartmentID") REFERENCES Deparment("DID")
);

CREATE TABLE IF NOT EXISTS ConstructorEmployee(
	"EID" INTEGER,
	"CompanyName" VARCHAR(50),
	"SalaryPerDay" INTEGER,
	FOREIGN KEY ("EID") REFERENCES Employee("EID"),
	CONSTRAINT "ch_salary" CHECK("SalaryPerDay" >= 0)
);

CREATE TABLE IF NOT EXISTS Department(
	"DID" INTEGER PRIMARY KEY,
	"ManagerID" INTEGER,
	"Name" VARCHAR(50),
	"Description" TEXT,
	FOREIGN KEY ("ManagerID") REFERENCES OfficialEmployee("EID")
);

CREATE TABLE IF NOT EXISTS Project(
	"PID" INTEGER PRIMARY KEY,
	"NeighborhoodID" INTEGER, 
	"Name" VARCHAR(50),
	"Description" TEXT,
	"Budget" INTEGER,
	FOREIGN KEY ("NeighborhoodID") REFERENCES Neighboorhood("NID")
);

CREATE TABLE IF NOT EXISTS ProjectConstructorEmployee(
	"EID" INTEGER,
	"PID" INTEGER,
	"StartWokringDate" DATE,
	"EndWorkingDate" DATE,
	"JobDescription" TEXT,
	FOREIGN KEY ("EID") REFERENCES ConstructorEmployee("EID"),
	FOREIGN KEY ("PID") REFERENCES Project("PID"),
	CONSTRAINT "ch_sed" CHECK("StartWokringDate" <= "EndWorkingDate")
	
);

CREATE TABLE IF NOT EXISTS Neighborhood(
	"NID" INTEGER PRIMARY KEY,
	"Name" VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Apartment(
	"StreetName" VARCHAR(50),
	"Number" INTEGER,
	"Door" INTEGER,
	"NeighborhoodID" INTEGER, 
	"Type" VARCHAR(50),
	"SizeSquareMeter" INTEGER,
	PRIMARY KEY("StreetName", "Number", "Door"),
	FOREIGN KEY ("NeighborhoodID") REFERENCES Neighborhood("NID"),
	CONSTRAINT "ch_ssm" CHECK ("SizeSquareMeter" >= 0)
);

CREATE TABLE IF NOT EXISTS Resident(
	"RID" INTEGER PRIMARY KEY,
	"FirstName" VARCHAR(50),
	"LastName" VARCHAR(50),
	"BirthDate" DATE,
	"StreetName" VARCHAR(50),
	"Number" INTEGER,
	"Door" INTEGER,
	FOREIGN KEY ("StreetName", "Number", "Door") REFERENCES Apartment("StreetName", "Number", "Door")
);

CREATE TABLE IF NOT EXISTS TrashCan(
	"CatalogID" INTEGER PRIMARY KEY,
	"CreationDate" DATE,
	"ExpirationDate" DATE,
	"ResidentID" INTEGER,
	FOREIGN KEY ("ResidentID") REFERENCES Resident("RID")
	CONSTRAINT "ch_ced" CHECK ("CreationDate" >= "ExpirationDate")
);

CREATE TABLE IF NOT EXISTS ParkingArea(
	"AID" INTEGER PRIMARY KEY,
	"Name" VARCHAR(50),
	"NeighborhoodID" INTEGER,
	"PricePerHour" INTEGER,
	"MaxPricePerDay", INTEGER,
	FOREIGN KEY ("NeighborhoodID") REFERENCES Neighborhood("NID"),
	CONSTRAINT "ch_pph" CHECK ("PricePerHour" >= 0 AND "PricePerHour" <= "MaxPricePerDay"),
	CONSTRAINT "ch_mppd" CHECK ("MaxPricePerDay" >= 0)
);

CREATE TABLE IF NOT EXISTS Cars(
	"CID" INTEGER PRIMARY KEY,
	"CellPhoneNumber" VARCHAR(50),
	"CreditCard" VARCHAR(50),
	"ExpirationDate" DATE,
	"ThreeDigits" VARCHAR(10),
	"ID" VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS CarParking(
	"CarID" INTEGER,
	"AreaID" INTEGER,
	"StartTime" DATETIME,
	"EndTime" DATETIME,
	"Cost" INTEGER,
	FOREIGN KEY ("CarID") REFERENCES Car("CID"),
	FOREIGN KEY ("AreaID") REFERENCES ParkingArea("AID"),
	CONSTRAINT "ch_set" CHECK ("StartTime" <= "EndTime"),
	CONSTRAINT "ch_c" CHECK ("Cost" >= 0)
);
	
	


	


	


	