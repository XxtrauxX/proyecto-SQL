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
	tipo_especie enum('animal','vegetal','mineral'));





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
		id)
	
	
	
-- inserciones
	
	
	
INSERT INTO personal (nombre, numero_cedula, direccion, telefono, sueldo, tipo_personal) VALUES
('Lionel Messi', '10000001', 'Calle Falsa 123', '555-1234-5678', 4500.00, '001'),
('Cristiano Ronaldo', '10000002', 'Avenida Siempre Viva 45', '555-2345-6789', 4800.00, '002'),
('Neymar Jr.', '10000003', 'Boulevard de los Sueños 789', '555-3456-7890', 4200.00, '003'),
('Kylian Mbappé', '10000004', 'Plaza Mayor 101', '555-4567-8901', 4000.00, '004'),
('Robert Lewandowski', '10000005', 'Callejón del Gato 202', '555-5678-9012', 4300.00, '001'),
('Kevin De Bruyne', '10000006', 'Paseo de la Castellana 303', '555-6789-0123', 4100.00, '002'),
('Virgil van Dijk', '10000007', 'Camino Real 404, ', '555-7890-1234', 3900.00, '003'),
('Sergio Ramos', '10000008', 'Avenida de la Paz 505', '555-8901-2345', 4400.00, '004'),
('Luka Modrić', '10000009', 'Calle de la Luna 606', '555-9012-3456', 4200.00, '001'),
('Mohamed Salah', '10000010', 'Plaza del Sol 707', '555-0123-4567', 4000.00, '002'),
('Harry Kane', '10000011', 'Calle de la Estrella 808', '555-1234-5679', 4300.00, '003'),
('Erling Haaland', '10000012', 'Avenida del Mar 909', '555-2345-6780', 4600.00, '004'),
('Karim Benzema', '10000013', 'Calle del Río 1010', '555-3456-7891', 4400.00, '001'),
('Bruno Fernandes', '10000014', 'Paseo de la Montaña 1111', '555-4567-8902', 4100.00, '002'),
('Joshua Kimmich', '10000015', 'Calle de la Sierra 121', '555-5678-9013', 3900.00, '003'),
('Raheem Sterling', '10000016', 'Avenida del Bosque 1313', '555-6789-0124', 4200.00, '004'),
('Trent Alexander-Arnold', '10000017', 'Calle del Lago 1414', '555-7890-1235', 4000.00, '001'),
('Alisson Becker', '10000018', 'Plaza de la Fuente 1515', '555-8901-2346', 4300.00, '002'),
('Rúben Dias', '10000019', 'Calle de la Playa 1616', '555-9012-3457', 4100.00, '003'),
('Phil Foden', '10000020', 'Avenida del Parque 171', '555-0123-4568', 3900.00, '004'),
('Jadon Sancho', '10000021', 'Calle de la Colina 1818', '555-1234-5670', 4200.00, '001'),
('Mason Mount', '10000022', 'Paseo de la Cascada 1919', '555-2345-6781', 4000.00, '002'),
('Kai Havertz', '10000023', 'Calle del Valle 2020', '555-3456-7892', 4300.00, '003'),
('Timo Werner', '10000024', 'Avenida del Río 2121', '555-4567-8903', 4100.00, '004'),
('Romelu Lukaku', '10000025', 'Calle de la Pradera 2222', '555-5678-9014', 3900.00, '001'),
('Antoine Griezmann', '10000026', 'Plaza del Mercado 2323', '555-6789-0125', 4200.00, '002'),
('Ousmane Dembélé', '10000027', 'Calle de la Iglesia 2424', '555-7890-1236', 4000.00, '003'),
('Frenkie de Jong', '10000028', 'Avenida de la Catedral 2525', '555-8901-2347', 4300.00, '004'),
('Memphis Depay', '10000029', 'Calle del Museo 2626', '555-9012-3458', 4100.00, '001'),
('Pedri', '10000030', 'Paseo de la Universidad 2727', '555-0123-4569', 3900.00, '002'),
('Ansu Fati', '10000031', 'Calle del Teatro 2828', '555-1234-5671', 4200.00, '003'),
('Gerard Piqué', '10000032', 'Avenida del Estadio 2929', '555-2345-6782', 4000.00, '004'),
('Sergio Busquets', '10000033', 'Calle de la Biblioteca 3030', '555-3456-7893', 4300.00, '001'),
('Jordi Alba', '10000034', 'Plaza del Ayuntamiento 3131', '555-4567-8904', 4100.00, '002'),
('Marc-André ter Stegen', '10000035', 'Calle del Hospital 3232', '555-5678-9015', 3900.00, '003'),
('David Alaba', '10000036', 'Avenida de la Ópera 3333', '555-6789-0126', 4200.00, '004'),
('Toni Kroos', '10000037', 'Calle del Cine 3434', '555-7890-1237', 4000.00, '001'),
('Casemiro', '10000038', 'Paseo de la Galería 3535', '555-8901-2348', 4300.00, '002'),
('Vinícius Júnior', '10000039', 'Calle del Parque 3636', '555-9012-3459', 4100.00, '003'),
('Eden Hazard', '10000040', 'Avenida del Jardín 3737', '555-0123-4570', 3900.00, '004'),
('Thibaut Courtois', '10000041', 'Calle de la Escuela 3838', '555-1234-5672', 4200.00, '001'),
('Dani Carvajal', '10000042', 'Plaza de la Estación 3939', '555-2345-6783', 4000.00, '002'),
('Ferland Mendy', '10000043', 'Calle del Metro 4040', '555-3456-7894', 4300.00, '003'),
('Marco Asensio', '10000044', 'Avenida del Aeropuerto 414', '555-4567-8905', 4100.00, '004'),
('Luka Jović', '10000045', 'Calle del Puerto 4242, Ciudad Ejemplo', '555-5678-9016', 3900.00, '001'),
('Isco', '10000046', 'Paseo de la Playa 4343, Ciudad Ejemplo', '555-6789-0127', 4200.00, '002'),
('Gareth Bale', '10000047', 'Calle de la Montaña 4444', '555-7890-1238', 4000.00, '003'),
('Mariano Díaz', '10000048', 'Avenida del Bosque 45', '555-8901-2349', 4300.00, '004'),
('Lucas Vázquez', '10000049', 'Calle del Lago 464', '555-9012-3460', 4100.00, '001'),
('Nacho Fernández', '10000050', 'Plaza de la Fuente 4747', '555-0123-4571', 3900.00, '002');
