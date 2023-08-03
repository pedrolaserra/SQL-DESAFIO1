-- criação do banco de dados para o cenário de E- commerce

CREATE database ecommerce;

use ecommerce;

show tables;

ALTER table address add COLUMN country varchar (30);

-- show databases;

-- use information_schema;

-- select * from company_constraint;

-- criando tabela cliente
create table clients(
	idClient int auto_increment,
    fname varchar(20) not null,
    minit char(3) not null,
    lname varchar (20) not null,
    cpf char(11) not null,
    data_nascimento date not null,
    constraint pk_client primary key (idClient), 
    constraint unique_cpf_client unique (cpf)
 );
 
 alter table clients auto_increment =1;
 
-- criando tabela Endereço
create table address(
	idAddress int,
	idClient int,
    typeAddres varchar (30)not null,
    zipCode char(9) not null,
    street varchar (30) not null,
    constraint pk_client primary key (idAddress, idClient),
    constraint fk_address_cliente foreign key (idClient) references clients (idClient)
 );
 
 -- criando tabela produto 
 create table product(
	idProduct int auto_increment,
    pname varchar(10) not null,
    classification_kids bool default false,
    category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos') not null,
    avaliacao float default 0,
    size varchar(10),
    constraint pk_idProduct primary key (idProduct)
);

 alter table product auto_increment =1;

-- criando tabela pedido
create table orders(
	idOrder int auto_increment,
    idOrderClient int,
    order_status enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    order_descrition varchar(255),
    send_value float default 10,
    paymentCash bool default false,
    idOPayment int,
    constraint pk_idOrder primary key (idOrder),
    constraint fk_orders_client foreign key (idOrderClient) references clients (idClient)
);

-- criando tabela pagamento
create table payments(
	idClient int,
    idPayment int,
    typePayment enum ('Cartão','Dois cartões'),
    limitAvailable float,
    constraint pk_payment_client primary key (idClient, idPayment),
    constraint fk_idClient_cliente foreign key (idClient) references clients (idClient)
);



desc payments;
desc orders;

show databases;

-- criando a tabela estoque
create table productStorage(
	idProductStorage int auto_increment,
    storageLocation varchar(255),
    quantity int default 0,
    constraint pk_idProductStorage primary key (idProductStorage)
);

 alter table productStorage auto_increment =1;

-- criando tabela fornecedor
create table supplier (
	idSupplier int auto_increment,
    socialName varchar (255) not null,
    cnpj char(15) not null,
    contact char(11) not null,
    constraint pk_idFornecedor primary key (idSupplier),
    constraint unique_supplier unique (cnpj)
);
 alter table supplier auto_increment =1;

-- criando tabela vendedor
create table seller(
	idseller int auto_increment,
    socialName varchar (255) not null,
    cnpj char(15),
    cpf char(11),
    contact char(11),
    location varchar (255),
    constraint pk_seller primary key (idseller),
    constraint unique_cnpj unique (cnpj),
    constraint unique_cfpf unique (cpf) 
);
 alter table seller auto_increment =1;
 
-- criando tabela produtos por vendedor
create table productSeller (
	idPSeller int,
    idPproduct int,
    prodQuantity int default 1,
    constraint pk_idPSeller_idProduct primary key (idPSeller, idPproduct),
    constraint fk_idProduct foreign key (idPproduct) references product (idProduct),
    constraint fk_idPseller foreign key (idPSeller) references seller (idSeller)
);
desc productSeller;

-- criando tabela de produto por pedido
create table productOrder(
	idPOrder int,
    idPOproduct int,
    poQuantity int default 1,
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
	constraint pk_idPOrder_idPOproduct primary key (idPOrder, idPOproduct),
    constraint fk_idPOrder foreign key (idPOrder) references orders (idOrder),
    constraint fk_idPOproduct foreign key (idPOproduct) references product (idProduct)
);

-- criando tabela locais de estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar (255) not null,
	constraint pk_idLproduct_idLstorage primary key (idLproduct, idLstorage),
    constraint fk_idLproduct foreign key (idLproduct) references product (idProduct),
    constraint fk_idLstorage foreign key (idLstorage) references productStorage (idProductStorage)
);

create table productSupplier (
	idPSupplier int,
    idPsproduct int,
    prodQuantity int not null,
    constraint pk_idPSupplier_idsProduct primary key (idPSupplier, idPsproduct),
    constraint fk_Supplier_idProduct foreign key (idPsproduct) references product (idProduct),
    constraint fk_idPSupplie_Supplier foreign key (idPSupplier) references supplier (idSupplier)
);

show tables;

INSERT INTO clients (fname, minit, lname, cpf, data_nascimento)
 VALUES ('Douglas', 'N', 'Ferreira', '12345678902', '1957-01-10' ),
		('Fernanda', 'C', 'Anjos', '12345678903', '1975-12-11' ),
		('Mario', 'S', 'Carmo', '12345678904', '1987-03-30' ),
		('Thiago', 'E', 'Vicente', '12345678905', '1996-05-01' ),
		('Karina', 'G', 'Souza', '12345678906', '1999-07-01' ),
		('Lucia', 'R', 'Santos', '12345678907', '2001-02-09' ),
		('Joyce', 'M', 'Silva', '12345678908', '2005-04-11' ),
		('José', 'S', 'Reimberg', '12345678909', '1988-06-18' ),
		('Marcelo', 'N', 'Andrade', '12345678900', '2000-08-01' );
        
select * from address;
        
INSERT INTO address (idAddress, idClient, typeAddres,zipCode, street, country)
 VALUES (1, 1, 'Casa', '04846-710', 'Rua Juruá,432', 'Brasil'),
		(2, 2, 'Casa', '04846-805', 'Rua dos Almeidas,15', 'Brasil'),
		(3, 2, 'Trabalho', '04844-522', 'Rua dos Eucaliptos,10', 'Brasil'),
		(4, 3, 'Casa', '04746-540', 'Avenida Belmira,8200', 'Holanda'),
		(5, 4, 'Casa', '04046-500', 'Rua Giuseppe,02', 'Portugal'),
		(6, 5, 'Casa', '04136-900', 'Rua sinfonia,7', 'Portugal'),
		(7, 5, 'Trabalho', '04444-800', 'Avenida Ibirapuera,90', 'Holanda'),
		(8, 6, 'Casa', '04587-541', 'Rua das mantiqueira,25', 'Holanda'),
		(9, 7, 'Casa', '04152-200', 'Rua dos artistas,65','Portugal'),
		(10, 8, 'Trabalho', '04321-500', 'Rua carimã,95', 'Brasil');
        
INSERT INTO product (pname, classification_kids, category, avaliacao, size )
	VALUES ('Fone de Ouvido', false, 'Eletrônico','4', null),
		   ('Barbie Elsa', true, 'Brinquedos','4', null),
		   ('Body Carters', true, 'Vestimenta','4', null),
		   ('Microfone Vedo', true, 'Eletrônico','4', null),
		   ('Sofá Retretíl', false, 'Móveis','4', '3x57x80'),
		   ('Cadeira Gamer', false, 'Móveis','4', '1x10x12');
           
alter table product add column category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Móveis', 'Alimentos') not null;

alter table product drop column category;

INSERT INTO orders (idOrderClient, order_status, order_descrition, send_value, paymentCash, idOPayment)
			VALUES (1, default, 'compra via aplicativo', null, 1, 1);
			VALUES (2, default, 'compra via aplicativo', 50, 0, 2);
			VALUES (3, 'Confirmado', 'compra via aplicativo', null, 1, 3);
			VALUES (4, default, 'compra via aplicativo', 150, 0, 4);
            
INSERT INTO payments (idClient, idPayment, typePayment, limitAvailable )
			VALUES (1, 1, 'Cartão', 2000.00);
			VALUES (2, 2, 'Dois cartões', 5000.00);
            
select * from payments;

INSERT INTO productStorage (storageLocation, quantity)
			VALUES ('Rio de Janeiro', 1000),
			 ('São Paulo', 500),
			 ('Minas', 100),
			 ('Bahia', 50),
			 ('Cuiabá', 110);
             
INSERT INTO supplier (socialName, cnpj, contact)
			VALUES ('BHA Distribuidora', 123456789123123,'21345678'),
				('Premium JBR', 789456123789456,'21478569'),
				('Almeida e Filhos', 159753258741021,'59257852'),
				('Eletrôncos Silva', 321478596321456,'31259548'),
				('JP GAMES', 159753258789654,'26497582');
                
INSERT INTO seller (socialName, cnpj, cpf, contact, location)
			VALUES ('Tech Eletrônicos', 123548758965487, null, 214536985, 'Rio de Janeiro'),
			 ('Bruno Henrique', null, 95175328574, 256579855, 'São Paulo'),
			 ('Jose Almeida', null, 95195195195, 252525259, 'São Paulo'),
			 ('Marias Food', 951951951951951,null,  357753357, 'Rio de Janeiro'),
			 ('Kids Kids', 987789987789987, null, 215236985, 'Rio de Janeiro');

INSERT INTO productSeller (idPSeller, idPproduct, prodQuantity)
			VALUES (1,19,80),
			 (2,20,50),
			 (3,23,10);
             
INSERT INTO productOrder (idPOrder, idPOproduct, poQuantity, poStatus)
			VALUES (1,20,2,null),
			 (1,25,2,default),
			 (2,20,1,null),
			 (2,20,3,default);
             
INSERT INTO storageLocation (idLproduct, idLstorage, location)
				VALUES (19, 1, 'RJ'),
				 (20, 2, 'SP'),
				 (21, 2, 'SP'),
				 (22, 1, 'RJ');
                 
INSERT INTO productSupplier (idPSupplier, idPsproduct, prodQuantity )
			VALUES (1, 19, 1000),
			 (2, 20, 500),
			 (3, 21, 50),
			 (4, 23, 110);
             
