USE BdTest;
GO

DROP FUNCTION IF EXISTS [Catalog].fnSearchBooksByPublicationYear;
GO

/*
  Función que devuelve los libros Y su información acerca del nombre de la editorial publicados después de un año específico.
  @param year: El año a partir del cual se desean obtener los libros.
  @return: Una tabla con los detalles de los libros publicados después del año especificado, incluyendo título, género, año de publicación y nombre del editor.
*/
CREATE FUNCTION [Catalog].fnSearchBooksByPublicationYear 
(
  @year INT
)
RETURNS TABLE
AS
RETURN (
SELECT
    b.idBook,
    b.title AS BookTitle,
    b.publicationYear
  FROM [Catalog].tblBooks b
  WHERE b.publicationYear > @year
);
GO

CREATE FUNCTION [Catalog].fnSearchBooksByPublicationYear 
(
  @year INT
)
RETURNS @DataSeleccionada TABLE (
  idBook INT,
  title VARCHAR(250),
  publicationYear INT
)
AS BEGIN 
  INSERT @DataSeleccionada 
    SELECT
      b.idBook,
      b.title AS BookTitle,
      b.publicationYear
    FROM [Catalog].tblBooks b
    WHERE b.publicationYear > @year
  RETURN
END;
GO

SELECT * FROM [Catalog].fnSearchBooksByPublicationYear(1900);
GO

----------------------------------------------------------------------------
DROP FUNCTION IF EXISTS [Catalog].fnSearchAuthorsBookById;
GO

/*
  Función que devuelve la información sobre un libro y además la información de todos los autores que contribuyeron en él en formato de json
*/
CREATE FUNCTION [Catalog].fnSearchAuthorsBookById (@idBook INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        b.idBook,
        b.title,
        b.publicationYear,
        (
          SELECT 
              a.fullName,
              n.name AS nationalityName
          FROM [Catalog].tblBookAuthors ba
          INNER JOIN [Catalog].tblAuthors a 
              ON a.idAuthor = ba.idAuthor
          INNER JOIN [Catalog].tblNationalities n 
              ON n.idNationality = a.idNationality
          WHERE ba.idBook = b.idBook
          FOR JSON PATH
        ) AS authors
        
    FROM [Catalog].tblBooks b
    WHERE b.idBook = @idBook
);
GO

SELECT *  FROM [Catalog].fnSearchAuthorsBookById(8);


USE BdTest

  SELECT
    b.idBook,
    b.title AS BookTitle,
    b.publicationYear
  FROM [Catalog].tblBooks b
  WHERE b.publicationYear > 1500
  GROUP BY b.title

  