CREATE DATABASE BdTest;
GO
USE BdTest;
GO

CREATE SCHEMA Users;
GO
CREATE SCHEMA Catalog;
GO
CREATE SCHEMA Operations;
GO

SELECT name FROM sys.schemas;

-- TABLAS A CREAR
/*
Users
Roles

Books
publishers
Authors
BookAuthors

Loans
*/

--Creando las tablas que pertenecen al esquema USERS
CREATE TABLE Users.tblRoles (
  idRole INT IDENTITY(1,1) NOT NULL,
  name VARCHAR(20) NOT NULL,
  description VARCHAR(200) NOT NULL,
  createdAt DATETIME DEFAULT GETDATE()
)
ALTER TABLE Users.tblRoles ADD CONSTRAINT pkRoles PRIMARY KEY (idRole);
ALTER TABLE Users.tblRoles ADD CONSTRAINT dfDescription DEFAULT 'Desconocida' FOR description;

CREATE TABLE Users.tblUsers (
    idUser INT IDENTITY(1,1) NOT NULL,
    idRole INT NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(70) UNIQUE NOT NULL,
    password NVARCHAR(255) UNIQUE NOT NULL,
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Users.tblUsers ADD CONSTRAINT pkUsers PRIMARY KEY (idUser);
ALTER TABLE Users.tblUsers ADD CONSTRAINT fkUsers_Roles FOREIGN KEY (idRole) REFERENCES Users.tblRoles(idRole);
ALTER TABLE Users.tblUsers ADD CONSTRAINT dfRole DEFAULT 1 FOR idRole;


--Creando las tablas que pertenecen al esquema CATALOG
CREATE TABLE Catalog.tblNationalities(
  idNationality INT IDENTITY(1,1) NOT NULL,
  name VARCHAR(50),
  description VARCHAR(200),
  createdAt DATE DEFAULT GETDATE()
)
ALTER TABLE Catalog.tblNationalities ADD CONSTRAINT pkRole PRIMARY KEY (idNationality)
ALTER TABLE Catalog.tblNationalities ADD CONSTRAINT dfNationalityDescription DEFAULT 'Desconocida' for description;

CREATE TABLE Catalog.tblGenres(
  idGenre INT IDENTITY(1,1) NOT NULL,
  name VARCHAR(50),
  description VARCHAR(200),
  createdAt DATE DEFAULT GETDATE()
)
ALTER TABLE Catalog.tblGenres ADD CONSTRAINT pkGenre PRIMARY KEY (idGenre)
ALTER TABLE Catalog.tblGenres ADD CONSTRAINT dfGenresDescription DEFAULT 'Desconocida' for description;


CREATE TABLE Catalog.tblPublishers (
    idPublisher INT IDENTITY(1,1) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20),
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Catalog.tblPublishers ADD CONSTRAINT pkPublishers PRIMARY KEY (idPublisher);
ALTER TABLE Catalog.tblPublishers ADD CONSTRAINT dfAddress DEFAULT 'Desconocida' FOR address;
ALTER TABLE Catalog.tblPublishers ADD CONSTRAINT chkPhone CHECK (phone LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' OR phone IS NULL);

CREATE TABLE Catalog.tblBooks (
    idBook INT IDENTITY(1,1) NOT NULL,
    title NVARCHAR(255) NOT NULL,
    publicationYear INT,
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Catalog.tblBooks ADD CONSTRAINT pkBooks PRIMARY KEY (idBook);

CREATE TABLE Catalog.tblAuthors (
    idAuthor INT IDENTITY(1,1) NOT NULL,
    idNationality INT NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Catalog.tblAuthors ADD CONSTRAINT pkAuthors PRIMARY KEY (iDAuthor);
ALTER TABLE Catalog.tblAuthors ADD CONSTRAINT fkAuthors_Nationalities FOREIGN KEY (idNationality) REFERENCES Catalog.tblNationalities(idNationality);
ALTER TABLE Catalog.tblAuthors ADD CONSTRAINT dfNationality DEFAULT 1 FOR idNationality;

CREATE TABLE Catalog.tblBookAuthors (
    idAuthor INT NOT NULL,
    idBook INT NOT NULL,
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Catalog.tblBookAuthors ADD CONSTRAINT pkBookAuthors PRIMARY KEY (idBook, idAuthor);
ALTER TABLE Catalog.tblBookAuthors ADD CONSTRAINT fkBookAuthors_Books FOREIGN KEY (idBook) REFERENCES Catalog.tblBooks(idBook);
ALTER TABLE Catalog.tblBookAuthors ADD CONSTRAINT fkBookAuthors_Authors FOREIGN KEY (idAuthor) REFERENCES Catalog.tblAuthors(idAuthor);

DROP TABLE [Catalog].tblBookAuthors;

CREATE TABLE Catalog.tblBookPublishers(
  idBook INT NOT NULL,
  idPublisher INT NOT NULL,
  createdAt DATE DEFAULT GETDATE()
)
ALTER TABLE Catalog.tblBookPublishers ADD CONSTRAINT pkBookPublishers PRIMARY KEY (idBook, idPublisher);
ALTER TABLE Catalog.tblBookPublishers ADD CONSTRAINT fkBookPublishers_Books FOREIGN KEY (idBook) REFERENCES Catalog.tblBooks(idBook);
ALTER TABLE Catalog.tblBookPublishers ADD CONSTRAINT fkBookPublishers_Publishers FOREIGN KEY (idPublisher) REFERENCES Catalog.tblPublishers(idPublisher);

CREATE TABLE Catalog.tblBookGenres(
  idBook INT NOT NULL,
  idGenre INT NOT NULL DEFAULT 1,
  createdAt DATE DEFAULT GETDATE()
)
ALTER TABLE Catalog.tblBookGenres ADD CONSTRAINT pkBookGenres PRIMARY KEY (idBook, idGenre);
ALTER TABLE Catalog.tblBookGenres ADD CONSTRAINT fkBookGenres_Books FOREIGN KEY (idBook) REFERENCES Catalog.tblBooks(idBook);
ALTER TABLE Catalog.tblBookGenres ADD CONSTRAINT fkBookGenres_Publishers FOREIGN KEY (idGenre) REFERENCES Catalog.tblGenres(idGenre);


--Creando las tablas que pertenecen al esquema OPERATIONS
CREATE TABLE Operations.tblLoans (
    idLoan INT IDENTITY(1,1) NOT NULL,
    idUser INT NOT NULL,
    idBook INT NOT NULL,
    loanDate DATETIME DEFAULT GETDATE(),
    returnDate DATETIME,
    createdAt DATETIME DEFAULT GETDATE()
);
ALTER TABLE Operations.tblLoans ADD CONSTRAINT pkLoans PRIMARY KEY (idLoan);
ALTER TABLE Operations.tblLoans ADD CONSTRAINT fkUser FOREIGN KEY (idUser) REFERENCES Users.tblUsers(idUser);
ALTER TABLE Operations.tblLoans ADD CONSTRAINT fkBookLoan FOREIGN KEY (idBook) REFERENCES Catalog.tblBooks(idBook);

USE master;
GO
DROP DATABASE BdTest;
GO