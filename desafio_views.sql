-- definidas as permissões de acesso as views de acordo com o tipo de conta de usuário

create user 'teste'@localhost identified by '102030';

grant all privileges on employee_vw to 'teste'@localhost;
grant all privileges on company.dept_manager_vw to 'teste'@localhost;
grant all privileges on company.project_employee_vw to 'teste'@localhost;
grant all privileges on company.project_mgr_dept_vw to 'teste'@localhost;
grant all privileges on company.dependent_mgr_vw to 'teste'@localhost;

-- Número de empregados por departamento e localidade 
create view employee_vw as
    select d.dname, count(concat(fname|minit|lname)) as empregados
    from employee e
    inner join departament d
    on e.ssn = d.dssn
    group by dname;
    
-- Lista de departamentos e seus gerentes 
create view dept_manager_vw as
    select d.dname, count(concat(fname|minit|lname)) as empregados
    from employee e
    inner join departament d
    on e.super_ssn = d.mgr_ssn
    group by dname;

-- Projetos com maior número de empregados (ex: por ordenação desc) 
create view project_employee_vw as
    select p.pname, count(concat(fname|minit|lname)) as empregados
    from employee e
    inner join project p
    on p.pnumber = e.pnumber
    group by pname
    order by pname desc;
    
-- Lista de projetos, departamentos e gerentes 
create view project_mgr_dept_vw as
    select p.pname, count(concat(fname|minit|lname)) as empregados, d.dname
    from employee e
    inner join project p
    on p.pnumber = e.pnumber
    inner join departament d
    on e.super_ssn = d.mgr_ssn
    group by pname, d.dname;
    
-- Quais empregados possuem dependentes e se são gerentes 
create view dependent_mgr_vw as
    select count(concat(fname|minit|lname)) as empregados, d.dependent_name
    from employee e
    inner join dependent d
    on e.ssn = d.essn
    and e.super_ssn is not null
    group by d.dependent_name;
	
-- Parte 2 – Criando gatilhos - Triggers de atualização: before update company

delimiter \\

create trigger aumento_salary before update on employee 
for each row
  begin
	case new.dno
		when 1 then set new.salary = salary * 1.20;
        when 2 then set new.salary = salary * 1.10;
        when 3 then set new.salary = salary * 1.05;
        when 4 then set new.salary = salary * 1.30;
	end case;
 end \\
 delimiter ;
 
-- Criando gatilhos - Triggers de remoção: before delete company 

delimiter \\

create trigger aumento_salary before update on employee 
for each row
  begin
	case new.dno
		when 1 then set new.salary = salary * 1.20;
        when 2 then set new.salary = salary * 1.10;
        when 3 then set new.salary = salary * 1.05;
        when 4 then set new.salary = salary * 1.30;
	end case;
 end \\
 delimiter ;
 
 -- Criando gatilhos - Triggers de remoção: before delete Ecommerce
 
 DELIMITER $$

CREATE TRIGGER before_produtos_excluidos
BEFORE DELETE
ON product FOR EACH ROW
BEGIN
    INSERT INTO produtos_excluidos(pname, category)
    VALUES(OLD.pname, OLD.category);
END$$    

DELIMITER ;

-- Criando gatilhos - Triggers de atualização: before update company

create trigger desconto_produto before update on product
for each row
  begin
	case new.category
		when 'Eletrônico' then set new.send_value = send_value / 5;
        when 'Vestimenta' then set new.send_value = send_value / 4;
        when 'Brinquedos' then set new.send_value = send_value / 2;
        when 'Móveis' then set new.send_value = send_valuey / 9;
	end case;
 end \\
 delimiter ;

