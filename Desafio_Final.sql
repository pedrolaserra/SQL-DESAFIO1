CODE 1 – TRANSAÇÕES SEM USO DE PROCEDURES

-- setar o autocommit = off, ou false ou 0
set @@autocommit = 0;

-- Startando uma transação --

START TRANSACTION;

start transaction;
	-- Consulta
	select idClientes, CONCAT(lname | minit) as name, cpf as identificação  from oficina natural join ordemServico;
	
	-- Modificação dos dados
	update ordemServico set status ='FINALIZADO' where numero= 1;
	
commit;

CODE 2 - TRANSAÇÃO COM PROCEDURE 

-- Recuperando Mensagem de erro Gerada pela transação em uma procedure no MySQL --

delimiter //

	create procedure sql_fail_oficina()
	begin 
		declare exit handler for sqlexception
		begin
			show errors limit 1;
			rollback;
			select 'Erro encontrado' as Warning;
		end;
		
		start transaction;
		
		select 
			@nextnumero := max(numero) + 1 as Next_numero
		from 
			oficina;
		
		insert into oficina VALUES (@nexnumero,'Thiago','Eulalio','37257553882', 'rua 25','11968256693');
											 
		commit;
		
	end//
	
delimiter ;
	
		
PARTE 3 – BACKUP E RECOVERY 

-- Comando Windows: cd C:\Program Files\MySQL\MySQL Server 8.0\bin\
						> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe --user root --password --databases oficina > oficina_backup.sql
						

-- Craindo bkp com routines, e outros recursos dentro do output no MySQL --

-- Criando 
->C:\Program Files\MySQL\MySQL Server 8.0\bin\
	> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe --procedures --triggers --index -u root -p ecommerce > ecommerce_bkp_sqp 
	
-- Separando os Dump Files em Dados e Statements SQL durante o Bakcup via MySQL --
->C:\Program Files\MySQL\MySQL Server 8.0\bin\
	> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe --no-data company > company_nodata_bkp.sql -u root -p -- criando bkp  sem os dados
	
		> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe --no-create-info company > company_nodata_bkp.sql -u root -p -- criando bkp  sem inforrmações
		
-- Outras opções de backup no MySQL -- 
->C:\Program Files\MySQL\MySQL Server 8.0\bin\
	> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe -u root -p --all-databases > all_databases_bkp.sql -- criando bkp para todos os bancos
	
	> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe -u root -p --all-databases > company ecommerce > two_databases_bkp.sql  -- criando bkp para alngus databases
	
	> C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump.exe -u root -p company departaments > company_dept_bkp.sql  -- criando bkp para tabela em databases

-- Realizando recovery a partir de um ump file no Mysql --
	> Criar o banco para recovery 
	> acessar o banco 
	> Comando para recovery: mysql --user root --password --database db_name < oficina_backup.sql
		



