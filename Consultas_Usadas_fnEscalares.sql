SELECT 
  COUNT(*)
from [Users].tblRoles r
  INNER JOIN [Users].tblUsers u
  ON r.idRole = u.idRole
WHERE r.name = 'User';

SELECT 
  u.idUser, 
  u.fullName, 
  r.name, 
  r.description 
from [Users].tblRoles r
  INNER JOIN [Users].tblUsers u
  ON r.idRole = u.idRole
WHERE r.name = 'User';