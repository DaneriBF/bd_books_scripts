USE BdTest;
GO

INSERT INTO [Users].tblRoles (name, [description])
VALUES
('Admin', 'Rol del administrador'),
('User', 'Rol para usuario comunes');
GO

INSERT INTO [Users].tblUsers (fullName, email, password, idRole)
VALUES
('Ana López', 'ana.lopez@mail.com', 'pass1', '1'),
('Carlos Méndez', 'carlos.mendez@mail.com', 'pass2', '2'),
('María Fernández', 'maria.fernandez@mail.com', 'pass3', '2'),
('José Rivera', 'jose.rivera@mail.com', 'pass4', '2'),
('Lucía Gómez', 'lucia.gomez@mail.com', 'pass5', '2');
GO

SELECT * FROM [Users].tblUsers;

INSERT INTO [Catalog].tblPublishers (name, address, phone)
VALUES
('Crossway Books', 'Nashville, Tennessee, USA', '6515-5555'),
('Editorial Central', 'Tegucigalpa, Honduras', '2234-5678'),
('Libros del Sur', 'San Pedro Sula, Honduras', '2233-1122'),
('Alfa Editorial', 'Madrid, España', '9112-3344'),
('Nova Books', 'Ciudad de México, México', '5511-7788');
GO

SELECT * FROM [Catalog].tblPublishers;

INSERT INTO [Catalog].tblNationalities (name)
VALUES
('Británica'),
('Colombiana'),
('Chilena'),
('Estadounidense'),
('Israelí'),
('Española'),
('Egipcia');
GO

SELECT * FROM [Catalog].tblNationalities;

INSERT INTO [Catalog].tblAuthors (fullName, idNationality)
VALUES
('Gabriel García Márquez', 1),
('Isabel Allende', 2),
('J.K. Rowling', 7),
('Stephen King', 3),
('Yuval Noah Harari', 5),
('Miguel de Cervantes', 5),
('Moises', 6),
('David', 4),
('Isaias', 4),
('Samuel', 4),
('Jeremias', 4),
('Ezequiel', 4);
GO

SELECT * FROM [Catalog].tblAuthors

INSERT INTO [Catalog].tblGenres (name)
VALUES 
('Romance'),
('Comedia'),
('Terror'),
('Ficción'),
('No ficción'), 
('Religion');
GO

INSERT INTO [Catalog].tblBooks (title, publicationYear)
VALUES
('Cien años de soledad', 1967),
('El amor en los tiempos del cólera', 1985),
('La casa de los espíritus', 1982),
('Harry Potter y la piedra filosofal', 1997),
('It', 1986),
('Sapiens: De animales a dioses', 2011),
('Don Quijote de la Mancha', 1605),
('La Biblia', 1600);
GO

SELECT * FROM [Catalog].tblAuthors;
SELECT * FROM [Catalog].tblBooks;



INSERT INTO [Catalog].tblBookAuthors (idBook, idAuthor)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12);
GO

SELECT * FROM [Catalog].tblBookAuthors;

SELECT * FROM [Catalog].tblBooks;
SELECT * FROM [Catalog].tblGenres;

INSERT INTO [Catalog].tblBookGenres (idBook, idGenre)
VALUES
(1,1),
(2,1),
(2,4),
(3,1),
(3,3),
(4,1),
(5,1),
(5,6),
(6,2),
(7,1),
(8,3);
GO


INSERT INTO [Operations].tblLoans (idUser, idBook, returnDate)
VALUES
(1, 1,  NULL),
(2, 2,  '2026-04-08'),
(3, 3,  NULL),
(4, 4,  '2026-04-10'),
(5, 5,  NULL),
(1, 6,  NULL),
(2, 8, '2026-03-01'),
(1, 8, NULL);
GO

SELECT * FROM [Operations].tblLoans;


SELECT * FROM [Catalog].tblBooks;
SELECT * FROM [Catalog].tblPublishers;

INSERT INTO [Catalog].tblBookPublishers (idBook, idPublisher)
VALUES
(1,1),
(1,2),
(2,4),
(2,2),
(2,1),
(3,1),
(3,3),
(8,1),
(8,3),
(8,5);
GO

SELECT * FROM [Catalog].tblBookPublishers;
GO