:: Backup
:: database = dbecommerce
:: destino = C:\dumps\backup_dbecommerce.sql
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump" -u root -p --single-transaction --routines --add-drop-table --databases dbecommerce > C:\dumps\backup_dbecommerce.sql