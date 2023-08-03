-- Pergunta  - Qual o departamento com maior número de pessoas? 


select dname, count(*) as pessoas
from departament 
group by dname
order by dname desc;

-- Criando Indice
create index idx_depart_employee on departament(Mgr_ssn) using Btree;

-- Pergunta  - Quais são os departamentos por cidade? 


select count(*) as qtd, dl.dlocation, dl.city, d.dname from dept_locations dl
inner join departament d
on dl.dnumber=d.dnumber
group by dl.dlocation, dl.city, d.dname
order by dl.city;

-- Criando Indice
create index idx_depart_location on dept_locations(dlocation) using Btree;

-- Pergunta  - Relação de empregrados por departamento?
    
SELECT d.dname, COUNT(*) AS num_employees
FROM employees e
JOIN department ON e.dno = d.dnumber
GROUP BY d.dname;

-- Criando Indice

create index idx_employee_dept on employee(dno) using Btree;

-- Obs: Indices criados como btree pois o MySQl não deixou alterar a engine para memory, pois já havia dependências das fks e teria que criar a estrutura do banco novamente com todas as tabelas com a engine memory.