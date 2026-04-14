USE BDTest;
GO

DROP PROCEDURE IF EXISTS [Catalog].splInsertGenre;
GO

/*
  Procedimiento almacenado que inserta un nuevo elemento en la tabla generos (primero verifica que no haya un genero existente)
  @param name: Recibe el nombre del genero que se desea insertar.
  @param description: Recibe una descripción del genero que se desea insertar.
*/
CREATE PROCEDURE [Catalog].splInsertGenre 
  @name NVARCHAR(50),
  @description NVARCHAR(200) = 'Desconocida'
AS
BEGIN
  DECLARE @nameFlag VARCHAR(50);

    SET @nameFlag = (SELECT name FROM Catalog.tblGenres WHERE name = @name);

    IF @nameFlag IS NULL
      INSERT INTO Catalog.tblGenres (name, description)
      VALUES (@name, @description);
    
END;
GO

EXEC [Catalog].splInsertGenre @name = 'Terror psicológico', @description = 'Este genero explora el terror de una forma más profunda tomando en cuenta la psicología';
GO

SELECT * FROM [Catalog].tblGenres;
GO

----------------------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS [Catalog].splInsertBook;
GO

/*
  Procedimiento almacenado que inserta un nuevo elemento en la tabla generos (primero verifica que no haya un genero existente)
  @param name: Recibe el nombre del genero que se desea insertar.
  @param description: Recibe una descripción del genero que se desea insertar.
*/
CREATE PROCEDURE [Catalog].splInsertBook 
  @title NVARCHAR(255),
  @publicationYear INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM Catalog.tblBooks WHERE title = @title)
    BEGIN
        RETURN -1;
    END

    INSERT INTO Catalog.tblBooks (title, publicationYear)
    OUTPUT INSERTED.*
    VALUES (@title, @publicationYear);
END;
GO

EXEC [Catalog].splInsertBook @title = 'Prisión verde', @publicationYear = '1950';
GO

DELETE FROM [Catalog].tblBooks WHERE idBook = 9;

SELECT * FROM [Catalog].tblBooks;
GO