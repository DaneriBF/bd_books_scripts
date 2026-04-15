USE BdTest;
GO

---------------------------------------------------

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

  -- 1. Validar si el usuario existe
  IF EXISTS (SELECT 1 FROM [Users].tblUsers WHERE email = @email)
  BEGIN 
    SELECT 
      -1 AS code,
      'El usuario con este correo ya existe' AS message;
    RETURN;
  END

  -- 2. Validar si un usuario ya posee esta contraseña
  IF EXISTS (SELECT 1 FROM [Users].tblUsers WHERE [password] = @password)
    BEGIN 
    SELECT 
      -2 AS code,
      'Ya existe un usuario con esta contraseña' AS message;
    RETURN;
  END

  -- 2. Inserta al nuevo usuario
  INSERT INTO [Users].tblUsers (fullname, idRole, email, password)
  OUTPUT 
    1 AS Code,
    INSERTED.idUser,
    INSERTED.idRole,
    INSERTED.fullName,
    INSERTED.email
  VALUES (@fullName, @idRole, @email, @password)
END;
GO

EXEC [Users].splInsertUser @fullName = 'Miguel Trejo', @idRole = 2, @email = 'miguel.trejo@mail.com', @password = 'passMi';
GO

SELECT * FROM [Users].tblUsers;

-------------------------------------------------------------------

DROP PROCEDURE IF EXISTS [Users].splUpdateUserPassword;
GO

/*
  Procedimiento almacenado que actualiza la contraseña de un usuario existente y retorna la información del usuario que se ha modificado
  @param email: Recibe el correo electrónico del usuario al que cambiará la contraseña
  @para newPassword: Recibe la nueva contraseña que tendrá el usuario
*/
CREATE PROCEDURE [Users].splUpdateUserPassword
  @email NVARCHAR(255),
  @newPassword NVARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;

  -- 1. Validar si el usuario existe
  IF NOT EXISTS (SELECT 1 FROM [Users].tblUsers WHERE email = @email)
  BEGIN
    SELECT 
      -1 AS code,
      'El correo no existe' AS message;
    RETURN;
  END

  -- 2. Validar si la contraseña es la misma
  IF EXISTS (
    SELECT 1 
    FROM [Users].tblUsers 
    WHERE email = @email AND [password] = @newPassword
  )
  BEGIN
    SELECT 
      -2 AS code,
      'La nueva contraseña no puede ser igual a la anterior' AS message;
    RETURN;
  END

  -- 3. Actualizar y retornar el usuario actualizado
  UPDATE [Users].tblUsers
  SET [password] = @newPassword
  OUTPUT 
    1 AS code,
    'Contraseña actualizada correctamente' AS message,
    INSERTED.idUser,
    INSERTED.email
  WHERE email = @email;
END;
GO

EXEC [Users].splUpdateUserPassword @email = "royer.ba@mail.com", @newPassword = 'passRoye';
GO

SELECT * FROM [Users].tblUsers;

--------------------------------------------------------

DROP PROCEDURE IF EXISTS [Users].splOutputTest;
GO

CREATE PROCEDURE [Users].splOutputTest
  @idRole INT,
  @idUser INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @idRoleObtenido INT;

  UPDATE [Users].tblRoles SET [name] = 'Admin' 
  OUTPUT 
    INSERTED.idRole,
    INSERTED.name
  WHERE idRole = @idRole;
--  SET @idRoleObtenido = INSERTED.idRole;

  UPDATE [Users].tblUsers SET [fullName] = 'Ana López' 
  OUTPUT 
    INSERTED.idUser,
    INSERTED.fullName
  WHERE idUser = @idUser;
END;

EXEC [Users].splOutputTest @idRole = 1, @idUser = 1;

select * from Users.tblRoles
select * from Users.tblUsers

UPDATE [Users].tblUsers SET [fullName] = 'Miguel De Cervantes'  WHERE idUser = 1007;
select * from Users.tblUsers

      SELECT 
        u.idUser 
      FROM [Users].tblUsers u 
      WHERE u.idUser = 8;