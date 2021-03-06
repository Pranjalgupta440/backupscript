declare @dbname varchar(100)
declare @path varchar(100)  
DECLARE @fileName VARCHAR(256) 
DECLARE @fileDate VARCHAR(20) 
SET @path = 'D:\BackupSql\'  
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),104) 
DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM master.sys.databases 
WHERE name NOT IN ('master','model','msdb','tempdb')
AND state = 0 
AND is_in_standby = 0 
OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @dbname   
WHILE @@FETCH_STATUS = 0   
BEGIN   
   SET @fileName = @path + @dbname + '_' + @fileDate + '.BAK'  
   BACKUP DATABASE @dbname TO DISK = @fileName  
   FETCH NEXT FROM db_cursor INTO @dbname   
END    
CLOSE db_cursor   
DEALLOCATE db_cursor
