 @echo off

 set hour=%time:~0,2%
 if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
 echo hour=%hour%
 set min=%time:~3,2%
 if "%min:~0,1%" == " " set min=0%min:~1,1%
 echo min=%min%
 set secs=%time:~6,2%
 if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
 echo secs=%secs%
 set year=%date:~-4%
 echo year=%year%
 set month=%date:~3,2%
 if "%month:~0,1%" == " " set month=0%month:~1,1%
 echo month=%month%
 set day=%date:~0,2%
 if "%day:~0,1%" == " " set day=0%day:~1,1%
 echo day=%day%
 set datetimef=%year%%month%%day%_%hour%%min%%secs%
 echo datetimef=%datetimef%

 set dbUser=root
 set dbPassword=****
 set backupDir="C:\MySQL\MySQL Backups"
 set mysqldump="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe"
 set mysqlDataDir="C:\ProgramData\MySQL\MySQL Server 8.0\Data"
 set retaindays=30

 :: switch to the "data" folder
 pushd %mysqlDataDir%

 :: iterate over the folder structure in the "data" folder to get the databases
 for /d %%f in (*) do (
   %mysqldump% --host="localhost" --user=%dbUser% -p%dbPassword% --routines --single-transaction --add-drop-table --databases %%f > %backupDir%\%%f_%datetimef%.sql   
 )
  
 :: "Deleting zip files older than 30 days now"
 Forfiles -p %backupDir% -s -m *.sql -d -%retaindays% -c "cmd /c del /q @path"
 
 popd