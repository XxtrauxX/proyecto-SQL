-- Cración de la Base de Datos y las tablas

CREATE DATABASE IF NOT EXISTS parqueNatural;
use parqueNatural;



create table departamento(
	id int primary key auto_increment,
	nombre varchar(20) not null,
	id_encargado int not null,
	foreign key(id_encargado) references encargado_departamento(id));


create table encargado_departamento(
	id int primary key auto_increment,
	nombre varchar(100) not null);



create table parque_natural(
	id_parque int primary key auto_increment,
	nombre varchar(20) not null,
	fecha_declaracion date not null);


create table departamento_parque_natural(
	id int primary key auto_increment,
	id_departamento int not null,
	id_parque int not null,
	foreign key(id_departamento) references departamento(id),
	foreign key(id_parque) references parque_natural(id_parque));




create table area(
	id_area int primary key auto_increment,
	nombre varchar(20) not null,
	extencion_area float not null);


create table area_parque_natural(
	id_area_parque int primary key auto_increment,
	id_parque int not null,
	id_area int not null,
	foreign key(id_parque) references parque_natural(id_parque),
	foreign key(id_area) references area(id_area));






create table especie(
	id int primary key auto_increment,
	denominacion_cientifica varchar(100) not null,
	denominacion_vulgar varchar(100) not null,
	tipo_especie enum('animal','vegetal','mineral') not null);





create table area_especie(
	id_area_especie int primary key auto_increment,
	id_area int not null,
	id_especie int not null,
	foreign key(id_area) references area(id_area),
	foreign key(id_especie) references especie(id));





create table personal(
	id_personal int primary key auto_increment,
	nombre varchar(100) not null,
	numero_cedula varchar(20) not null,
	direccion varchar(100) not null,
	telefono varchar(20) not null,
	sueldo float not null,
	tipo_personal enum('001','002','003','004'));




create table vehiculo(
	id int primary key auto_increment,
	tipo varchar(20) not null,
	marca varchar(20) not null);



create table personal_vigilancia(
	id_vigilancia int primary key auto_increment,
	id_personal int not null,
	id_area int not null,
	id_vehiculo int not null,
	foreign key(id_personal) references personal(id_personal),
	foreign key(id_area) references area(id_area),
	foreign key(id_vehiculo) references vehiculo(id));



create table proyecto_investigacion(
	id_proyecto int primary key auto_increment,
	presupuesto float not null,
	periodo_realizacion)
	
	
	
	create table visitante(
		id int primary key auto_increment,
		nombre varchar(100) not null,
		numero_cedula varchar(20)not null,
		direccion varchar(100) not null,
		profesion varchar(20) not null);
	
	
	
	
	create table personal_conservacion(
		id_conversacion int primary key auto_increment,
		id_personal int not null,
		id_area int not null,
		tipo_mantenimiento enum('limpieza','mantenimiento') not null,
		foreign key(id_personal) references personal(id_personal),
		foreign key(id_area) references area(id_area));
	
	
	

	
	create table personal_proyecto(
		id_personal_proyecto int primary key auto_increment,
		id_personal int not null,
		id_proyecto int not null,
		id_especie int not null,
		foreign key(id_personal) references personal(id_personal),
		foreign key(id_proyecto) references proyecto_investigacion(id_proyecto),
		foreign key(id_especie) references especie(id));
		
		
		
		
		
	create table proyecto_investigacion(
		id_proyecto int primary key auto_increment,
		nombre varchar(100) not null,
		presupuesto float not null,
		periodo_realizacion varchar(100) not null);
	
	
	

	
	create table alojamiento(
		id int primary key auto_increment,
		nombre varchar(100) not null,
		capacidad int not null,
		categoria varchar(20) not null,
		id_parque int not null,
		foreign key(id_parque) references parque_natural(id_parque));
	
	
	
	create table visitante_alojamiento(
		id_visitante_alojamiento int primary key auto_increment,
		id_visitante int not null,
		id_alojamiento int not null,
		fecha date not null,
		foreign key(id_visitante) references visitante(id),
		foreign key(id_alojamiento) references alojamiento(id));
	
	
	
	
	create table entrada(
		id_entrada int primary key auto_increment,
		nombre varchar(100) not null,
		id_parque int not null,
		foreign key(id_parque) references parque_natural(id_parque));
	
	
	
	
	
	create table registro_entrada(
		id_registro int primary key auto_increment,
		id_personal int not null,
		id_visitante int not null,
		id_entrada int not null,
		fecha datetime unique not null,
		foreign key(id_personal) references personal(id_personal),
		foreign key(id_visitante) references visitante(id),
		foreign key(id_entrada) references entrada(id_entrada));
	
	
	select * from personal;
	













