create database funkysa;
use funkysa;

	create table cliente(
		id int NOT NULL AUTO_INCREMENT,
		nombre varchar (30),
		dni int (9),
		email varchar (50),
		telefono int (11),
		direccion varchar (50),
		primary key (id)
	);


	create table empleado(
		id int NOT NULL AUTO_INCREMENT,
		nombre varchar(20),
		dni int (8),
		email varchar (100),
		telefono int (20),
		direccion varchar (50),
		primary key (id)
	);

	create table componente(
		id int NOT NULL AUTO_INCREMENT,
		tipo varchar (20),
		nombre varchar (50),
		descripcion varchar (250),
		precio int (11),
		importado boolean,
		primary key (id)
	);
	
	create table pc(
		id int NOT NULL AUTO_INCREMENT,
		nombre varchar (50),
		descripcion varchar (250),
		categoria varchar(30),
		primary key (id)
	);
	
	create table pc_x_comp(
		id_componente int (8),
		id_pc int (8),
		primary key (id_componente, id_pc)
	);
	
	create table linea_factura(
		n_factura int(10),
		n_linea int (11),
		id_componente int (11),
		primary key (n_factura, n_linea),
		foreign key (id_componente) references componente (id)
	);
	
	create table factura(
		n_factura int (8),
		fecha date,
		id_c int (20),
		id_e int (20),
		foreign key (n_factura) references linea_factura(n_factura),
		foreign key (id_c) references cliente(id),
		foreign key (id_e) references empleado(id)
	);
	
	DELIMITER //
		create procedure agregarPC (in nombre varchar (50), in descripcion varchar (250), in categoria varchar (30))
		begin
			insert into pc (nombre, descripcion, categoria) values (nombre, descripcion, categoria);
		end //
	
	DELIMITER //
		create procedure agregarComp (in id_pc int (11), in tipo varchar (20), in nombre varchar (50), in descripcion varchar (250), in precio int (11), in importado boolean)
		begin
		if importado=true then
		 insert into componente (id_pc, tipo, nombre, descripcion, precio, importado) values (id_pc, tipo, nombre, descripcion, precio+(precio * 11)/100, importado);
		else 
		 insert into componente (id_pc, tipo, nombre, descripcion, precio, importado) values (tipo, nombre, descripcion, precio, importado);
		end if;			

		end //
		
	DELIMITER //
		create procedure agregarCliente (in nombre varchar (30), in dni int (9), in email varchar (50), in telefono int (11), in direccion varchar (50)) 
		begin
			insert into cliente (nombre, dni, email, telefono, direccion) values (nombre, dni, email, telefono, direccion);
		end //		

	DELIMITER //
		create procedure agregarEmpleado (in nombre varchar (30), in dni int (9), in email varchar (50), in telefono int (11), in direccion varchar (50)) 
		begin
			insert into empleado values (nombre, id, dni, direccion, mail, telefono);
		end //
		
		
	DELIMITER //
		create procedure crearLFactura (in n_factura int (10), in n_linea int (11), in id_componente int (11))
		begin
			insert into linea_factura (n_factura, n_linea, id_componente) values (n_factura, n_linea, id_componente);
		end //
		
	DELIMITER //
		create procedure crearFactura (in n_factura int (10), in n_linea int (11), in id_componente int (11))
		begin
			insert into linea_factura (n_factura, n_linea, id_componente) values (n_factura, n_linea, id_componente);
		end //
		
	DELIMITER //
		create procedure pcxComp (in id_componente int (8), in id_pc int (8))
		begin
			insert into pc_x_comp (id_componente, id_pc) values (id_componente, id_pc);
		end //
		
	DELIMITER //
		create procedure mostrarFactura (in n_factura int (8), in fecha date, in id_cliente int (20), in id_empleado int (20))
		begin
			insert into factura (n_factura, fecha, id_cliente, id_empleado) values (n_factura, fecha, id_cliente, id_empleado);
		end //
		
		call agregarPC('PC Hogar 1', 'PC ideal para utilizar en el hogar', 'Hogar');
		call agregarComp(1, 'Memoria RAM', 'Memoria RAM', 'Memoria RAM Kingston DDR4 8gb', 8000, true);
		call agregarComp(1, 'Disco duro', 'Disco duro', 'Disco duro Toshiba 1tb', 18000, false);
		call agregarComp(1, 'Procesador', 'Procesador Intel Core i7', 'Procesador Intel Core i7', 35000, true);
		call agregarComp(1, 'Placa de video', 'Placa de video', 'Placa de video RTX', 100000, true);
		call pcxComp(1, 1);
		call pcxComp(2, 1);
		call pcxComp(3, 1);
		call pcxComp(4, 1);
		call agregarCliente('Christian', 12345678, 'christian@gmail.com', 12345678, 'Buenos Aires 2004');
		call agregarCliente('Lionel', 12345679, 'lionel@gmail.com', 12345679, 'Paris 2021');
		call crearLFactura(1, 1, 1);
		call crearLFactura(1, 2, 2);
		call crearLFactura(1, 3, 3);
		call crearLFactura(1, 4, 4);
		call mostrarFactura(1, '2022-11-01', 1, 1);


