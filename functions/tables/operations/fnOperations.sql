USE BdTest;
GO

DROP FUNCTION IF EXISTS [Operations].fnBooksByUser;
GO
/*
  Función que devuelve los libros actualmente prestados a un usuario específico.
  @param idUser: El ID del usuario para el cual se desean obtener los libros prestados.
  @return: Una tabla con los detalles de los libros prestados al usuario, incluyendo título, género, fecha de préstamo y fecha de devolución.
 */
CREATE FUNCTION [Operations].fnBooksByUser (@idUser INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        b.idBook,
        b.title,
        l.loanDate,
        l.returnDate
    FROM [Operations].tblLoans l
    INNER JOIN [Catalog].tblBooks b 
        ON b.idBook = l.idBook
    WHERE l.idUser = @idUser
);
GO

SELECT * FROM Operations.fnBooksByUser(5);
