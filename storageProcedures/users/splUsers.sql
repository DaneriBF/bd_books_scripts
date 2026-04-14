USE BdTest;
GO

DROP PROCEDURE IF EXISTS [Users].splInsertUser;
GO

/*
  Procedimiento almacenado que inserta un nuevo elemento en la tabla usuarios (primero verifica que no haya un usuario con ese mismo nombre)
  @param fullName: Contiene el nombre completo del usuario
  @param idRole: Contiene el id del rol que se le asignara
  @param email: Contiene el correo electronico del usuario
  @param password: Contiene la contraseña que se le dará al usuario
*/
CREATE PROCEDURE [Users].splInsertUser 
  @fullName VARCHAR(100),
  @idRole INT,
  @email NVARCHAR(70),
  @password NVARCHAR(255)
AS
BEGIN
  SET NOCOUNT OFF;

  IF EXISTS (SELECT 1 FROM Users.tblUsers WHERE email = @email)
  BEGIN 
    RETURN -1
  END

  INSERT INTO [Users].tblUsers (fullname, idRole, email, password)
  OUTPUT INSERTED.*
  VALUES (@fullName, @idRole, @email, @password)
END;
GO

EXEC [Users].splInsertUser @fullName = 'Royer B', @idRole = 1, @email = 'royer.b@mail.com', @password = 'passR';
GO

-------------------------------------------------------------------
DROP PROCEDURE IF EXISTS [Users].splUpdateUserPassword;
GO

CREATE PROCEDURE [Users].splUpdateUserPassword
  @email NVARCHAR(255),
  @newPassword NVARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM [Users].tblUsers WHERE email = @email)
  BEGIN
    RETURN -1;
  END

  UPDATE [Users].tblUsers SET password = @newPassword WHERE email = @email;
END;
GO

EXEC [Users].splUpdateUserPassword @email = "royer.b@mail.com", @newPassword = 'passRo';
GO

SELECT * FROM [Users].tblUsers;