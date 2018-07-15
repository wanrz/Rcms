--开发环境
begin
	declare @sp_dblink_sqlserver2oracle varchar(30) = 'sp_dblink_sqlserver2oracle'
	declare @sp_dblink_sqlserver2oracle_id int
	declare @sqlserver2oracle_ds varchar(60) = 'rcmsdb'
	declare @sqlserver2oracle_username varchar(20) = 'rcms'
	declare @sqlserver2oracle_pwd varchar(20) = 'rcms123!'

	set @sp_dblink_sqlserver2oracle_id = (select server_id from sys.servers where name = @sp_dblink_sqlserver2oracle)
	if @sp_dblink_sqlserver2oracle_id is not null
	begin
        exec sp_dropserver @sp_dblink_sqlserver2oracle , 'droplogins'
	end

	exec sp_addlinkedserver @server = N@sp_dblink_sqlserver2oracle , @srvproduct = N@sp_dblink_sqlserver2oracle , @provider = N'MSDAORA' , @datasrc = N@sqlserver2oracle_ds , @provstr = N'User ID='@sqlserver2oracle_username';Password='@sqlserver2oracle_pwd'
	--exec sp_addlinkedsrvlogin @sp_dblink_sqlserver2oracle , 'false', NULL , @sqlserver2oracle_username , @sqlserver2oracle_pwd
	print '已创建且oracle db --> ' + @sp_dblink_sqlserver2oracle + ' : ' + @sqlserver2oracle_ds + ' , ' + @sqlserver2oracle_username + ' , ' + @sqlserver2oracle_pwd
end
go