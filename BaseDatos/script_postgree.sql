
create sequence sec_departamento;
CREATE TABLE departamento(
    id_departamento INT default nextval('sec_departamento'),
    nombre_departamento VARCHAR(15) NOT NULL UNIQUE,
    num_candidatos INT,
    CONSTRAINT pk_departamento PRIMARY KEY (id_departamento)
);

create sequence sec_municipio;
CREATE TABLE municipio (
    id_municipio INT default nextval('sec_municipio'),
    id_departamento INT NOT NULL,
    nombre_municipio VARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT pk_municipio PRIMARY KEY (id_municipio)
);

create sequence sec_centrovotacion;
CREATE TABLE centroVotacion (
    id_centro_votacion INT default nextval('sec_centrovotacion'),
    id_municipio INT NOT NULL,
    direccion_especifica VARCHAR(30) NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,/*dui del encargado del centro de votacion*/
    nombre_centro VARCHAR(20) NOT NULL,
    num_jrv_disponibles INT NOT NULL,
    CONSTRAINT pk_centroVotacion PRIMARY KEY (id_centro_votacion)
);

create sequence sec_tipousuario;
CREATE TABLE tipoUsuario (
    id_tipo_usuario INT default nextval('sec_tipousuario'),
    tipo_usuario VARCHAR(30) NOT NULL,
    CONSTRAINT pk_tipoUsuario PRIMARY KEY (id_tipo_usuario)
);

create sequence sec_pregunta;
CREATE TABLE pregunta (
    id_pregunta INT default nextval('sec_pregunta'),
    pregunta VARCHAR(60) NOT NULL,
    CONSTRAINT pk_pregunta PRIMARY KEY (id_pregunta)
);

CREATE TABLE padronElectoral (
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    fecha_nac DATE NOT NULL,
    sexo VARCHAR(2) NOT NULL,
    direccion_especifica VARCHAR(30) NOT NULL,
    id_municipio INT NOT NULL,
    CONSTRAINT pk_padron PRIMARY KEY (num_dui)
);

create sequence sec_usuario;
CREATE TABLE usuario (
    id_usuario INT default nextval('sec_usuario'),
    id_tipo_usuario INT NOT NULL,
    contrasenia VARCHAR(15) NOT NULL,
    confirmacion INT NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE usuarioPadron (
    id_usuario INT NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT pk_usuarioPadron PRIMARY KEY (id_usuario)
);

CREATE TABLE infoSupExt (
    id_usuario INT NOT NULL,
    identificacion VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    sexo VARCHAR(2) NOT NULL,
    pais VARCHAR(15) NOT NULL,
    organizacion VARCHAR(15),
    CONSTRAINT pk_infoSupExt PRIMARY KEY (id_usuario)
);

CREATE TABLE respuesta (
    id_usuario INT NOT NULL,
    id_pregunta INT NOT NULL,
    respuesta VARCHAR(25) NOT NULL,
    CONSTRAINT pk_respuesta PRIMARY KEY (id_usuario)
);

CREATE TABLE excepcionUsuario (
    id_usuario INT NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    fecha_nac DATE NOT NULL,
    sexo VARCHAR(2) NOT NULL,
    direccion_especifica VARCHAR(30) NOT NULL,
    id_municipio INT NOT NULL,
    CONSTRAINT pk_excepcionUsuario PRIMARY KEY (id_usuario)
);

create sequence sec_partido;
CREATE TABLE partido (
    id_partido INT default nextval('sec_partido'),
    nombre VARCHAR(60) NOT NULL,
    acronimo VARCHAR(10) NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,/*dui del presidente del partido*/
    imagen VARCHAR(15) NOT NULL,
    CONSTRAINT pk_partido PRIMARY KEY (id_partido)
);

CREATE TABLE detallePartido (
    id_partido INT NOT NULL,
    id_candidato INT NOT NULL UNIQUE
);

create sequence sec_candidato;
CREATE TABLE candidato (
    id_candidato INT default nextval('sec_candidato'),
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    foto VARCHAR(15) NOT NULL,
    tipo INT NOT NULL,/*existen dos tipos de candidatos 1 es afiliado a partdio y 2 es independiente*/
    CONSTRAINT pk_candidato PRIMARY KEY (id_candidato)
);

create sequence sec_jrv;
CREATE TABLE JRV (
    id_jrv INT default nextval('sec_jrv'),
    id_centro_votacion INT NOT NULL,
    correlativo_jrv VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT pk_jrv PRIMARY KEY (id_jrv)
);

create sequence sec_cargodirectiva;
CREATE TABLE cargoDirectiva (
    id_cargo_directiva INT default nextval('sec_cargodirectiva'),
    cargo VARCHAR(20) NOT NULL,
    CONSTRAINT pk_cargoDirectiva PRIMARY KEY (id_cargo_directiva)
);

CREATE TABLE directivaJRV (
    num_dui VARCHAR(10) NOT NULL,
    id_jrv INT NOT NULL,
    id_partido INT NOT NULL,
    id_cargo_directiva INT NOT NULL,
    tipo INT NOT NULL,/*existen dos tipos de miembro 1 es propietario 2 es suplente*/
    CONSTRAINT pk_directivaJRV PRIMARY KEY (num_dui)
);

CREATE TABLE aperturaJRV(
    id_jrv INT,
    fecha DATE NOT NULL,
    hora time not null,
    CONSTRAINT pk_aperturaJRV PRIMARY KEY (id_jrv)
);

CREATE TABLE cierreJRV(
    id_jrv INT,
    fecha DATE NOT NULL,
    hora time not null,
    CONSTRAINT pk_cierreJRV PRIMARY KEY (id_jrv)
);

CREATE TABLE votantePorJRV (
    num_dui VARCHAR(10) NOT NULL,
    id_jrv INT NOT NULL,
    estado INT NOT NULL, /*es para verificar si el votante asistio a votar 0 es que no y 1 es que si*/
    CONSTRAINT pk_votantePorJRV PRIMARY KEY (num_dui)
);

create sequence sec_papeleta;
CREATE TABLE papeleta (
    id_papeleta INT default nextval('sec_papeleta'),
    id_departamento INT NOT NULL,
    CONSTRAINT pk_papeleta PRIMARY KEY (id_papeleta)
);

CREATE TABLE detallePapeleta (
    id_papeleta INT NOT NULL,
    id_candidato INT NOT NULL
);

create sequence sec_voto;
CREATE TABLE voto (
    id_voto INT default nextval('sec_voto'),
    id_jrv INT NOT NULL,
    CONSTRAINT pk_voto PRIMARY KEY (id_voto)
);

create sequence sec_votoabstenido;
CREATE TABLE votoAbstenido (
    id_voto_abstenido INT default nextval('sec_votoabstenido'),
    id_voto INT NOT NULL UNIQUE,
    CONSTRAINT pk_votoAbstenido PRIMARY KEY (id_voto_abstenido)
);

create sequence sec_votobandera;
CREATE TABLE votoBandera (
    id_voto_bandera INT default nextval('sec_votobandera'),
    id_voto INT NOT NULL UNIQUE,
    id_partido INT NOT NULL,
    CONSTRAINT pk_votoBandera PRIMARY KEY (id_voto_bandera)
);

create sequence sec_votomarca;
CREATE TABLE votoMarca (
    id_voto_marca INT default nextval('sec_votomarca'),
    id_voto INT NOT NULL,
    id_candidato INT NOT NULL,
    valor_porcentual decimal(10,2) NOT NULL,
    CONSTRAINT pk_votoMarca PRIMARY KEY (id_voto_marca)
);

create sequence sec_votoindependiente;
CREATE TABLE votoIndependiente (
    id_voto_independiente INT default nextval('sec_votoindependiente'),
    id_voto INT NOT NULL,
    id_candidato INT NOT NULL,
    valor_porcentual decimal(10,2) NOT NULL,
    CONSTRAINT pk_votoIndependiente PRIMARY KEY (id_voto_independiente)
);

/*tablas agregadas por carlos*/
CREATE TABLE credencialTemporal (
    id_usuario int,
    num_dui varchar(10) UNIQUE not null,
    CONSTRAINT pk_credencialTemporal PRIMARY KEY (id_usuario)
);

create sequence sec_bitacoraacciones;
CREATE TABLE bitacoraAcciones (
    id_bitacora int default nextval('sec_bitacoraacciones'),
    fecha date not null,  				
    hora time not null,
    accion varchar(60) not null,
    CONSTRAINT pk_bitacoraAcciones PRIMARY KEY (id_bitacora)
);

CREATE TABLE detalleBitacora (
    id_bitacora int,
    num_dui varchar(10) not null
);


/*tabla agregada en el segundo sprint*/
create sequence sec_observacion;
CREATE TABLE observacion (
    id_observacion int default nextval('sec_observacion'),
	id_usuario int,
	observacion varchar(140) not null,
    constraint pk_observacion primary key (id_observacion)
);


alter table usuario add constraint fk_usuario_tipo foreign key (id_tipo_usuario) references tipoUsuario(id_tipo_usuario);
alter table respuesta add constraint fk_respuesta_pregunta foreign key (id_pregunta) references pregunta(id_pregunta);

alter table directivaJRV add constraint fk_directivaJRV_jrv foreign key (id_jrv) references JRV(id_jrv);
alter table votantePorJRV add constraint fk_votantePorJRV_jrv foreign key (id_jrv) references JRV(id_jrv);
alter table voto add constraint fk_voto_JRV foreign key (id_jrv) references JRV(id_jrv);

alter table excepcionUsuario add constraint fk_excepcionUsuario_municipio foreign key (id_municipio) references municipio(id_municipio);
alter table centroVotacion add constraint fk_centro_municipio foreign key (id_municipio) references municipio(id_municipio);
alter table padronElectoral add constraint fk_padronElectoral_municipio foreign key (id_municipio) references municipio(id_municipio);

alter table votoMarca add constraint fk_vMarca_voto foreign key (id_voto) references voto(id_voto);
alter table votoBandera add constraint fk_vBandera_voto foreign key (id_voto) references voto(id_voto);
alter table votoAbstenido add constraint fk_vAbstenido_voto foreign key (id_voto) references voto(id_voto);
alter table votoIndependiente add constraint fk_vIndependiente_voto foreign key (id_voto) references voto(id_voto);

alter table respuesta add constraint fk_respuesta_usuario foreign key (id_usuario) references usuario(id_usuario);
alter table infoSupExt add constraint fk_infoSupExt_usuario foreign key (id_usuario) references usuario(id_usuario);
alter table usuarioPadron add constraint fk_usuarioPadron_usuario foreign key (id_usuario) references usuario(id_usuario);
alter table excepcionUsuario add constraint fk_excepcionUsuario_usuario foreign key (id_usuario) references usuario(id_usuario);

alter table usuarioPadron add constraint fk_usuarioPadron_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);
alter table centroVotacion add constraint fk_centroVotacion_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);
alter table partido add constraint fk_partido_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);
alter table directivaJRV add constraint fk_directivaJRV_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);
alter table candidato add constraint fk_candidato_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);
alter table votantePorJRV add constraint fk_votantePorJRV_padronElectoral foreign key (num_dui) references padronElectoral(num_dui);

alter table municipio add constraint fk_municipio_departamento foreign key (id_departamento) references departamento(id_departamento);
alter table papeleta add constraint fk_papeleta_departamento foreign key (id_departamento) references departamento(id_departamento);

alter table JRV add constraint fk_JRV_centroVotacion foreign key (id_centro_votacion) references centroVotacion(id_centro_votacion);

alter table detallePartido add constraint fk_detallePartido_candidato foreign key (id_candidato) references candidato(id_candidato);

alter table detallePartido add constraint fk_detalleP_partido foreign key (id_partido) references partido(id_partido);
alter table directivaJRV add constraint fk_directivaJRV_partido foreign key (id_partido) references partido(id_partido);

alter table votoMarca add constraint fk_vMarca_candidato foreign key (id_candidato) references candidato(id_candidato);
alter table votoIndependiente add constraint fk_vIndependiente_candidato foreign key (id_candidato) references candidato(id_candidato);

alter table directivaJRV add constraint fk_directivaJRV_cargoDirectiva foreign key (id_cargo_directiva) references cargoDirectiva(id_cargo_directiva);

alter table votoBandera add constraint fk_vBandera_partido foreign key (id_partido) references partido(id_partido);

/*
alter table partido add constraint fk_partido_excepcionUsuario foreign key (num_dui) references excepcionUsuario(num_dui);
*/

alter table detallePapeleta add constraint fk_detallePapeleta_papeleta foreign key (id_papeleta) references papeleta(id_papeleta);

alter table detallePapeleta add constraint fk_detallePapeleta_candidato foreign key (id_candidato) references candidato(id_candidato);

alter table aperturaJRV add constraint fk_aperturaJRV_jrv foreign key (id_jrv) references jrv(id_jrv);
alter table cierreJRV add constraint fk_cierreJRV_jrv foreign key (id_jrv) references jrv(id_jrv);

/*claves foraneas agregadas por carlos*/
alter table credencialTemporal add constraint fk_credencialTemporal_usuario foreign key (id_usuario) references usuario(id_usuario);
alter table detalleBitacora add constraint fk_detalleBitacora_bitacoraAcciones foreign key (id_bitacora) references bitacoraAcciones(id_bitacora);
alter table detalleBitacora add constraint fk_detalleBitacora_credencialTemporal foreign key (num_dui) references credencialTemporal(num_dui);
/**clave foranea agregada en el segundo sprint*/
alter table observacion add constraint fk_observacion_infosupext foreign key (id_usuario) references infosupext(id_usuario);

/*-----------------INSERCION DE REGISTROS DE PRUEBA----------------------*/
insert into departamento (nombre_departamento) values ('san salvador');
insert into departamento (nombre_departamento) values ('sonsonate');

insert into municipio (id_departamento,nombre_municipio) values (1,'san martin');
insert into municipio (id_departamento,nombre_municipio) values (1,'soyapano');

insert into municipio (id_departamento,nombre_municipio) values (2,'san joaquin');
insert into municipio (id_departamento,nombre_municipio) values (2,'el rosario');

insert into papeleta(id_departamento) values (1);
insert into papeleta(id_departamento) values (2);

insert into tipousuario (tipo_usuario ) values ('Administrador');   
insert into tipousuario (tipo_usuario ) values ('Magistrado');  
insert into tipousuario (tipo_usuario ) values ('Representante CNR');
insert into tipousuario (tipo_usuario ) values ('Supervisor externo');
insert into tipousuario (tipo_usuario ) values ('Representante Partido');
insert into tipousuario (tipo_usuario ) values ('Gestor de informacion');
insert into tipousuario (tipo_usuario ) values ('Director centro de votacion');
insert into tipousuario (tipo_usuario ) values ('Publicista');  
insert into tipousuario (tipo_usuario ) values ('Presidente JRV');
insert into tipousuario (tipo_usuario ) values ('Votante'); 

insert into pregunta (pregunta) values ('¿Cual es tu cancion favorita?');
insert into pregunta (pregunta) values ('¿Cuantos hermanos tienes?');
insert into pregunta (pregunta) values ('¿Cual es tu materia favorita?');
insert into pregunta (pregunta) values ('¿Como se llama tu mejor amig@?');
insert into pregunta (pregunta) values ('¿Cual es el nombre de tu profesor favorito?');
insert into pregunta (pregunta) values ('¿Cual el tu libro favorito?');
insert into pregunta (pregunta) values ('¿Que haces en tu tiempo libre?');

insert into cargodirectiva (cargo) values('Presidente');
insert into cargodirectiva (cargo) values('Vice Presidente');
insert into cargodirectiva (cargo) values('Secretario');
insert into cargodirectiva (cargo) values('Vocal');
/*Administrador*/
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(1,'12345',0);
/*Magistrados*/
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,'12345',0);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,'12345',0);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,'12345',0);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,'12345',0);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,'12345',0);
/*creaccion de credencial para adminitrador*/
insert into credencialTemporal (id_usuario, num_dui) values (1,'00000000-0');

/*Creacion de credenciales de acceso para magistrados (dui)*/
insert into credencialTemporal (id_usuario, num_dui) values (2,'00000001-0');
insert into credencialTemporal (id_usuario, num_dui) values (3,'00000002-0');
insert into credencialTemporal (id_usuario, num_dui) values (4,'00000003-0');
insert into credencialTemporal (id_usuario, num_dui) values (5,'00000004-0');
insert into credencialTemporal (id_usuario, num_dui) values (6,'00000005-0');

/*activacion de cuentas para administrador y magistrados*/
insert into respuesta (id_usuario,id_pregunta,respuesta) values (1,1,'hallelujah');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (2,2,'no tengo hermanos');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (3,3,'base de datos');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (4,4,'no tengo amigos');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (5,5,'julio profe');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (6,6,'el principito');
/*se activa el campo confirmacion para magistrados y adminitrador*/
update usuario set confirmacion = 1 where id_usuario = 1;
update usuario set confirmacion = 1 where id_usuario = 2;
update usuario set confirmacion = 1 where id_usuario = 3;
update usuario set confirmacion = 1 where id_usuario = 4;
update usuario set confirmacion = 1 where id_usuario = 5;
update usuario set confirmacion = 1 where id_usuario = 6;

/*creacion de usuario del cnr*/
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(3,'12345',0);
insert into credencialtemporal (id_usuario,num_dui) values (7,'00000006-0');
/*activacion de cuenta para usuario del cnr*/
insert into respuesta (id_usuario,id_pregunta,respuesta) values (7,1,'el pollito pio');
update usuario set confirmacion = 1 where id_usuario = 7;

/*creacion y activacion de usuarios para supervisores externos*/
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(4,'12345',0);
insert into infosupext (id_usuario,identificacion,nombre,apellido,sexo,pais,organizacion) values (8,'oiu887-98-2','Robert','Lewandowski','m','polonia','unicef');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (8,7,'programar');
update usuario set confirmacion = 1 where id_usuario = 8;

insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(4,'12345',0);
insert into infosupext (id_usuario,identificacion,nombre,apellido,sexo,pais,organizacion) values (9,'u887-98-209','Fredy','Meruri','m','croacia','queen');
insert into respuesta (id_usuario,id_pregunta,respuesta) values (9,7,'Tocar guitarra');
update usuario set confirmacion = 1 where id_usuario = 9;

/*observaciones de los supervisores externos*/
insert into observacion (id_usuario,observacion) values (8,'El sistema de elecciones es muy lento, hay poca transparencia al momento del conteo');
insert into observacion (id_usuario,observacion) values (9,'Se necesita mejorar el proceso de conteno de voto, para optimizar los procesos al maximo y agilizar las elecciones');


/*se registra los magistrados que autorizaron la importacion de registros del cnr*/
insert into bitacoraacciones (fecha,hora,accion) values('2016-08-14','11:55:00','Registro de datos CNR');
insert into detallebitacora (id_bitacora,num_dui) values (1,'00000001-0');
insert into detallebitacora (id_bitacora,num_dui) values (1,'00000002-0');
insert into detallebitacora (id_bitacora,num_dui) values (1,'00000003-0');

/*registro de datos del cnr*/
insert into padronelectoral (num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values ('05423275-0','carlos eliseo','menjivar flores','1996-9-23','m','Catedral metropolitana, #19',1);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(10,'12345',0);

insert into padronelectoral (num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values ('05423277-0','joel eliseo','menjivar vai','1996-9-23','m','Catedral metropolitana, #19',1);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(10,'12345',0);

insert into padronelectoral (num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values ('05423256-0','ernesto edenilson','menjivar flores','1995-9-23','m','Catedral metropolitana, #19',1);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(10,'12345',0);

insert into padronelectoral (num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values ('05424975-0','frank eliseo','menjivar batres','1996-9-23','m','Catedral metropolitana, #19',1);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(10,'12345',0);

insert into padronelectoral (num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values ('02343275-0','carlos edenilson','clapton batres','1936-9-23','m','Catedral metropolitana, #19',1);
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(10,'12345',0);

/*---creacion de partidos---*/
insert into partido (nombre,acronimo,num_dui,imagen) values ('Alianza Republicana Nacionalista','ARENA','05423275-0','img/bandera.jpg');

/*registro de candidatos partidarios*/
insert into candidato (num_dui,foto,tipo) values ('05423277-0','img/1.jpg',1);
insert into detallepartido (id_candidato,id_partido) values (1, 1);

/*registro de candidatos independientes*/
insert into candidato (num_dui,foto,tipo) values ('05423256-0','img/2.jpg',0);

/*creacion de la papeleta (es una por departamento) {esta papeleta pertenece a san salvador, se inicializo en la linea 11}*/
insert into detallepapeleta (id_papeleta,id_candidato) values (1,1);
insert into detallepapeleta (id_papeleta,id_candidato) values (1,2);

/*registro de centros de votacion*/
insert into centrovotacion (id_municipio,direccion_especifica,num_dui,nombre_centro,num_jrv_disponibles) values (1,'Colonia jerusalen, #23','05424975-0','Casa comunal',12);

/*registrando jrv por centro de votacion*/
insert into jrv (id_centro_votacion,correlativo_jrv) values (1,'sssm0901');

/*directiva de jrv*/
insert into directivajrv (num_dui,id_jrv,id_partido,id_cargo_directiva, tipo) values ('05424975-0',1,1,1,0);

/*asingando votantes a jrv*/
insert into votanteporjrv (num_dui,id_jrv,estado) values ('02343275-0',1,0);

/*abriendo una jrv*/
insert into aperturajrv (id_jrv,fecha,hora) values (1,'2016-08-16','8:00:00');

/*realizando un voto*/
insert into voto (id_jrv) values (1);

/*--probando los 4 tipos de voto--*/
insert into votoabstenido (id_voto) values (1);
insert into votobandera (id_voto,id_partido) values (1,1);
insert into votomarca (id_voto,id_candidato,valor_porcentual) values (1,1,0.5);
insert into votoindependiente (id_voto,id_candidato,valor_porcentual) values (1,1,0.5);

/*cerrando una jrv*/
insert into cierrejrv (id_jrv,fecha,hora) values (1,'2016-08-16','22:00:00');


/*procedimientos almacenados agregados por carlos*/

/*
cuando la credencial de administrador es correcta, se retorna el id del usuario y un mensaje de exito,
cuando las credenciales son incorrectos retorna 0 y un mensaje de error,
al igual que cuando las credenciales no exiten en el sistema
*/
create or replace function entrarAdministrador(
	in _dui varchar(10),
	in _contrasenia varchar(15),
	out idusuario int,
	out mensaje varchar(50)
) returns setof record as
$body$
	declare
		id int;
		tipo int;
		texto varchar(50);
	begin
	if exists(select * from credencialtemporal ct inner join usuario u on ct.id_usuario = u.id_usuario where ct.num_dui = _dui and u.contrasenia = _contrasenia) then
		select tp.id_tipo_usuario into tipo from tipousuario tp
		inner join usuario u on u.id_tipo_usuario = tp.id_tipo_usuario
		inner join credencialtemporal ct on ct.id_usuario = u.id_usuario
		where ct.num_dui = _dui;
		if(tipo = 1) then
			select ct.id_usuario into id from credencialtemporal ct where num_dui = _dui;
			texto = 'Bienvenido al sistema';
		else
			id = 0;
			texto = 'No tienes lo privilegios para entrar';
		end if;
		
	else
		texto = 'Credenciales incorrectas';
		id = 0;
	end if;
	return query select id, texto;
	return;
	end;
$body$
language plpgsql;


/*
este procediminto cumple la misma funcion que el anterior, pero hoy es para magistrados,
muetra ademas un mensaje de advertencia cuando no se ha activado la cuenta
*/
create or replace function entrarMagistrado(
	in _dui varchar(10),
	in _contrasenia varchar(15),
	out idusuario int,
	out mensaje varchar(60)
) returns setof record as
$body$
	declare
		id int;
		tipo int;
		texto varchar(60);
		confirmacion int;
	begin
	if exists(select * from credencialtemporal ct inner join usuario u on ct.id_usuario = u.id_usuario where ct.num_dui = _dui and u.contrasenia = _contrasenia) then
		select tp.id_tipo_usuario into tipo from tipousuario tp
		inner join usuario u on u.id_tipo_usuario = tp.id_tipo_usuario
		inner join credencialtemporal ct on ct.id_usuario = u.id_usuario
		where ct.num_dui = _dui;
		if(tipo = 2) then
			select ct.id_usuario into id from credencialtemporal ct where num_dui = _dui;
			select u.confirmacion into confirmacion from usuario u 
			inner join credencialTemporal ct on ct.id_usuario = u.id_usuario
			where ct.num_dui = _dui;
			if(confirmacion = 1) then
				texto = 'Bienvenido al sistema, Magistrado';
			else 
				texto = 'Bienvenido al sistema, Magistrado. Debes activar tu cuenta';
			end if;
		else
			id = 0;
			texto = 'No tienes lo privilegios para entrar';
		end if;
		
	else
		texto = 'Credenciales incorrectas';
		id = 0;
	end if;
	return query select id, texto;
	return;
	end;
$body$
language plpgsql;

/*
	permite o deniega la entrada para el usuario del cnr, muestra los
	mimo mensajes que el procedimiento anterior
	retorna el id del usuario y un mensaje de bienvenida
	este procedimiento no muestra el mensaje de activacion, ya que solo se ingresara una vez al sitema
	cuando las credenciales son incorrectas retorna 0 y el respectivo mensaje de error
*/
create or replace function entrarCNR(
	in _dui varchar(10),
	in _contrasenia varchar(15),
	out idusuario int,
	out mensaje varchar(60)
) returns setof record as
$body$
	declare
		id int;
		tipo int;
		texto varchar(60);
		confirmacion int;
	begin
	if exists(select * from credencialtemporal ct inner join usuario u on ct.id_usuario = u.id_usuario where ct.num_dui = _dui and u.contrasenia = _contrasenia) then
		select tp.id_tipo_usuario into tipo from tipousuario tp
		inner join usuario u on u.id_tipo_usuario = tp.id_tipo_usuario
		inner join credencialtemporal ct on ct.id_usuario = u.id_usuario
		where ct.num_dui = _dui;
		if(tipo = 3) then
			select ct.id_usuario into id from credencialtemporal ct where num_dui = _dui;
			select u.confirmacion into confirmacion from usuario u 
			inner join credencialTemporal ct on ct.id_usuario = u.id_usuario
			where ct.num_dui = _dui;
			texto = 'Bienvenido al sistema, Representante del CNR';
		else
			id = 0;
			texto = 'No tienes lo privilegios para entrar';
		end if;
		
	else
		texto = 'Credenciales incorrectas';
		id = 0;
	end if;
	return query select id, texto;
	return;
	end;
$body$
language plpgsql;

/*
	permite o deniega la entrada al sistema a lo ciudadado,
	cuando la credenciales con correctas retorna el id del usuario, y un mensaje de bienvenida, pidiendole que active
	su cuenta, en caso que se encuentre desactivada
	si las credenciales con incorrectas o no existen, retorna 0 y el respectivo mensaje
*/
create or replace function entrarVotante(
	in _dui varchar(10),
	in _contrasenia varchar(15),
	out idusuario int,
	out mensaje varchar(60)
) returns setof record as
$body$
	declare
		id int;
		texto varchar(60);
		confirmacion int;
	begin
	/*se comprueba que el ciudadano este regitrado en el sistema y tenga un usuario*/
	if exists(select * from padronelectoral p inner join usuariopadron up on up.num_dui = p.num_dui inner join usuario u on u.id_usuario = up.id_usuario where p.num_dui = _dui and u.contrasenia = _contrasenia) then
			/*se verifica si la cuenta esta activada*/
			select u.confirmacion into confirmacion from usuario u 
			inner join usuariopadron up on up.id_usuario = u.id_usuario
			inner join padronelectoral p on p.num_dui = up.num_dui
			where p.num_dui = _dui;
			/*se selecciona el id del votante*/
			select u.id_usuario into id from usuario u 
			inner join usuariopadron up on up.id_usuario = u.id_usuario
			inner join padronelectoral p on p.num_dui = up.num_dui;	
			/*en caso de que la cuenta este activada*/
			if (confirmacion = 1) then
				texto = 'Bienvenido al sistema';
			else
				texto = 'Bienvenido al sistema, aun no ha activado tu cuenta';
			end if;	
	else
		texto = 'Credenciales incorrectas';
		id = 0;
	end if;
	return query select id, texto;
	return;
	end;
$body$
language plpgsql;

/*uso de los procedimiento almacenados*/
/*los parametros de entrada son numero de dui y contraseña*/
select * from entrarAdministrador('00000000-0','12345');
select * from entrarMagistrado('00000001-0','12345');
select * from entrarCNR('00000006-0','12345');
select * from entrarVotante('05423275-0','12345');