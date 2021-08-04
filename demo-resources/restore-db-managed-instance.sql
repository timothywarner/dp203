CREATE CREDENTIAL [https://mitutorials.blob.core.windows.net/databases]
WITH IDENTITY = 'SHARED ACCESS SIGNATURE'
, SECRET = 'sv=2017-11-09&ss=bfqt&srt=sco&sp=rwdlacup&se=2028-09-06T02:52:55Z&st=2018-09-04T18:52:55Z&spr=https&sig=WOTiM%2FS4GVF%2FEEs9DGQR9Im0W%2BwndxW2CQ7%2B5fHd7Is%3D'



RESTORE FILELISTONLY FROM URL =
   'https://mitutorials.blob.core.windows.net/databases/WideWorldImporters-Standard.bak'



RESTORE DATABASE [Wide World Importers] FROM URL =
  'https://mitutorials.blob.core.windows.net/databases/WideWorldImporters-Standard.bak'



SELECT session_id as SPID, command, a.text AS Query, start_time, percent_complete
   , dateadd(second,estimated_completion_time/1000, getdate()) as estimated_completion_time
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a
WHERE r.command in ('BACKUP DATABASE','RESTORE DATABASE')