USE BdTest;
GO


/*
CREATE FUNCTION [Users].fnShowUsersQuantityByRole
(
  @role VARCHAR
)
RETURNS INT
AS
BEGIN
    -- -- Declaración de variables locales si es necesario
    -- DECLARE @usersQuantity INT;
    
    -- -- Instrucciones de procesamiento
    -- SET @usersQuantity = (SELECT COUNT(*) FROM [Users].tblUsers WHERE role = @role);-- Declaración de variables locales si es necesario
    -- DECLARE @usersQuantity INT;
    
    -- -- Instrucciones de procesamiento
    -- SET @usersQuantity = (SELECT COUNT(*) FROM [Users].tblUsers WHERE role = @role);
    
    RETURN (SELECT COUNT(*) FROM [Users].tblUsers WHERE role = @role);
END;
*/

/*
  Contar la cantidad de usuarios por rol utilizando una función escalar.
  @param role: El rol de usuario a contar (Admin o User).
  @return: La cantidad de usuarios que tienen el rol especificado.
*/
DROP FUNCTION IF EXISTS [Users].fnShowUsersQuantityByRole;
GO

CREATE FUNCTION [Users].fnShowUsersQuantityByRole
(
  @role VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    
    --RETURN (SELECT COUNT(*) FROM [Users].tblUsers WHERE role = @role)
    RETURN (
      SELECT 
        COUNT(*) 
      from [Users].tblRoles r
        INNER JOIN [Users].tblUsers u
        ON r.idRole = u.idRole
      WHERE r.name = @role
    );
END;
GO

-- Ejecutar y ver el resultado
SELECT [Users].fnShowUsersQuantityByRole('Admin') AS Quantity;
GO
