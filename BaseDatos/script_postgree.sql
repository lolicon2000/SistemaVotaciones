
create sequence sec_departamento;
CREATE TABLE departamento(
    id_departamento INT default nextval('sec_departamento'),
    nombre_departamento VARCHAR(50) NOT NULL,
    num_candidatos INT,
    CONSTRAINT pk_departamento PRIMARY KEY (id_departamento)
);

create sequence sec_municipio;
CREATE TABLE municipio (
    id_municipio INT default nextval('sec_municipio'),
    id_departamento INT NOT NULL,
    nombre_municipio VARCHAR(50) NOT NULL,
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
/** insercion departamento by roberto*/
INSERT INTO departamento(nombre_departamento) VALUES ('Ahuachapan');
INSERT INTO departamento(nombre_departamento) VALUES ('Santa Ana');
INSERT INTO departamento(nombre_departamento) VALUES ('Sonsonate');
INSERT INTO departamento(nombre_departamento) VALUES ('Chalatenango');
INSERT INTO departamento(nombre_departamento) VALUES ('Cuscatlan');
INSERT INTO departamento(nombre_departamento) VALUES ('San Salvador');
INSERT INTO departamento(nombre_departamento) VALUES ('La Libertad');
INSERT INTO departamento(nombre_departamento) VALUES ('San Vicente');
INSERT INTO departamento(nombre_departamento) VALUES ('Cabañas');
INSERT INTO departamento(nombre_departamento) VALUES ('La Paz');
INSERT INTO departamento(nombre_departamento) VALUES ('Usulutan');
INSERT INTO departamento(nombre_departamento) VALUES ('San Miguel');
INSERT INTO departamento(nombre_departamento) VALUES ('Morazan');
INSERT INTO departamento(nombre_departamento) VALUES ('La Union');

/**insercion municipio por departamento by roberto*/

/**Ahuachapan */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Ahuachapan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Apaneca');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Atiquizaya');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Concepcion de Ataco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'El Refugio');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Guaymango');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Jujutla');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'San Francisco Menendez');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'San Lorenzo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'San Pedro Puxtla');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Tacuba');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('1', 'Turin');

/**Santa ana */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Candelaria de la Frontera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Chalchuapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Coatepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'El Congo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'El Porvenir');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Masahuat');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Metapan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'San Antonio Pajonal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'San Sebastián Salitrillo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Santa Ana');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Santa Rosa Guachipilin');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Santiago de la Frontera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('2', 'Texistepeque');

/**Sonsonate */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Acajutla');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Armenia');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Caluco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Cuisnahuat');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Izalco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Juayua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Nahuizalco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Nahulingo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Salcoatitan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'San Antonio del Monte');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'San Julián');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Santa Catarina Masahuat');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Santa Isabel Ishuatán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Santo Domingo Guzman');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Sonsonate');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('3', 'Sonzacate');

/**Chalatenango */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Agua Caliente');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Arcatao');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Azacualpa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Chalatenango (ciudad)');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Comalapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Citala');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Concepción Quezaltepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Dulce Nombre de Maria');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'El Carrizal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'El Paraiso');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'La Laguna');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'La Palma');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'La Reina');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Las Vueltas');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Nueva Concepcion');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Nueva Trinidad');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Nombre de Jesus');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Ojos de Agua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Potonico');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Antonio de la Cruz');/*20*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Antonio Los Ranchos');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Fernando');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Francisco Lempa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Francisco Morazan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Ignacio');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Isidro Labrador');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Jose Cancasque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Jose Las Flores');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Luis del Carmen');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Miguel de Mercedes');/*30*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'San Rafael');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Santa Rita');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('4', 'Tejutla');

/**Cuscatlan */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Candelaria');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Cojutepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'El Carmen');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'El Rosario');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Monte San Juan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Oratorio de Concepcion');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San Bartolome Perulapia');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San Cristobal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San José Guayabal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San Pedro Perulapan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San Rafael Cedros');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'San Ramon');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Santa Cruz Analquito');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Santa Cruz Michapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Suchitoto');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('5', 'Tenancingo');

/**San salvador */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Aguilares');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Apopa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Ayutuxtepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Cuscatancingo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Ciudad Delgado');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'El Paisnal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Guazapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Ilopango');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Mejicanos');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Nejapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Panchimalco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Rosario de Mora');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'San Marcos');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'San Martín');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'San Salvador');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Santiago Texacuangos');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Santo Tomas');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Soyapango');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('6', 'Tonacatepeque');

/**La libertad */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Antiguo Cuscatlán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Chiltiupan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Ciudad Arce');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Colon');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Comasagua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Huizúcar');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Jayaque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Jicalapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'La Libertad');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Nueva San Salvador (Santa Tecla)');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Nuevo Cuscatlán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'San Juan Opico');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Quezaltepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Sacacoyo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'San José Villanueva');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'San Matías');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'San Pablo Tacachico');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Talnique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Tamanique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Teotepeque');/*20*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Tepecoyo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('7', 'Zaragoza');

/**San vicente */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Apastepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Guadalupe');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Cayetano Istepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Esteban Catarina');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Ildefonso');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Lorenzo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Sebastián');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'San Vicente');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Santa Clara');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Santo Domingo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Tecoluca');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Tepetitán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('8', 'Verapaz');

/**cabañas */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Cinquera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Dolores');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Guacotecti');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Ilobasco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Jutiapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'San Isidro');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Sensuntepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Tejutepeque');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('9', 'Victoria');

/**La paz */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Cuyultitán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'El Rosario');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Jerusalén');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Mercedes La Ceiba');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Olocuilta');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Paraíso de Osorio');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Antonio Masahuat');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Emigdio');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Francisco Chinameca');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Juan Nonualco');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Juan Talpa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Juan Tepezontes');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Luis Talpa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Luis La Herradura');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Miguel Tepezontes');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Pedro Masahuat');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Pedro Nonualco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'San Rafael Obrajuelo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Santa María Ostuma');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Santiago Nonualco');/*20*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Tapalhuaca');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('10', 'Zacatecoluca');

/**usulutan */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Alegría');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Berlín');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'California');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Concepción Batres');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'El Triunfo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Ereguayquín');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Estanzuelas');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Jiquilisco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Jucuapa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Jucuarán');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Mercedes Umaña');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Nueva Granada');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Ozatlán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Puerto El Triunfo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'San Agustín');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'San Buenaventura');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'San Dionisio');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'San Francisco Javier');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Santa Elena');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Santa María');/*20*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Santiago de María');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Tecapán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('11', 'Usulután');

/**San miguel */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Carolina');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Chapeltique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Chinameca');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Chirilagua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Ciudad Barrios');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Comacarán');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'El Tránsito');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Lolotique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Moncagua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Nueva Guadalupe');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Nuevo Edén de San Juan');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Quelepa');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Antonio del Mosco');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Gerardo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Jorge');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Luis de la Reina');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Miguel');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'San Rafael Oriente');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Sesori');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('12', 'Uluazapa');/*20*/

/**Morazan */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Arambala');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Cacaopera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Chilanga');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Corinto');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Delicias de Concepción');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'El Divisadero');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'El Rosario');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Gualococti');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Guatajiagua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Joateca');/*10*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Jocoaitique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Jocoro');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Lolotiquillo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Meanguera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Osicala');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Perquín');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'San Carlos');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'San Fernando');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'San Francisco Gotera');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'San Isidro');/*20*/
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'San Simón');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Sensembra');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Sociedad');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Torola');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Yamabal');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('13', 'Yoloaiquín');

/**La union */
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Anamorós');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Bolivar');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Concepción de Oriente');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Conchagua');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'El Carmen');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'El Sauce');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Intipucá');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'La Unión');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Lislique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Meanguera del Golfo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Nueva Esparta');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Pasaquina');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Polorós');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'San Alejo');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'San José');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Santa Rosa de Lima');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Yayantique');
INSERT INTO municipio (id_departamento , nombre_municipio) VALUES ('14', 'Yucuaiquín');


insert into papeleta(id_departamento) values (1);
insert into papeleta(id_departamento) values (2);

insert into tipousuario (tipo_usuario ) values ('Administrador');   
insert into tipousuario (tipo_usuario ) values ('Magistrado');  
insert into tipousuario (tipo_usuario ) values ('Representante CNR');
insert into tipousuario (tipo_usuario ) values ('Supervisor externo');
insert into tipousuario (tipo_usuario ) values ('Representante Partido');
insert into tipousuario (tipo_usuario ) values ('Director TSE');
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


/*
	los datos de un magistrado deben aparecen en muchas tablas
	cuando se ingresa un magistrado correctamente retorna 1 y un mensaje de exito
	cuando el dui se repite, retorna 0 y el mensaje de error
*/
create or replace function agregarMagistrado(
	in _num_dui varchar(10),
	in _contrasenia varchar(15),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _fecha_nac date,
	in _sexo varchar(2),
	in _direccion varchar(30),
	in _municipio int,
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	idgenerado int;
	texto varchar(60);
	numero int;
begin
	if not exists(select * from credencialtemporal where num_dui = _num_dui) then
		insert into usuario(id_tipo_usuario,contrasenia,confirmacion) values (2,'12345',0);
		idgenerado = lastval();
		insert into credencialtemporal(id_usuario,num_dui) values (idgenerado,_num_dui);
		insert into excepcionusuario(id_usuario,num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values (idgenerado,_num_dui,_nombre,_apellido,_fecha_nac,_sexo,_direccion,_municipio);
		texto = 'Magistrado registrado correctamente';
		numero = 1;
	else
		texto = 'El numero de Dui ya esta registrado';
		numero = 0;
	end if;
	return query select numero,texto;
	return;
end;
$body$
language plpgsql;


/*
	al igual que con el magistrado, los datos del representante del cnr van en 
	varias tablas, retorna los mismos valores que la funcion anterior
*/
create or replace function agregarRepresentanteCNR(
	in _num_dui varchar(10),
	in _contrasenia varchar(15),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _fecha_nac date,
	in _sexo varchar(2),
	in _direccion varchar(30),
	in _municipio int,
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	idgenerado int;
	texto varchar(60);
	numero int;
begin
	if not exists(select * from credencialtemporal where num_dui = _num_dui) then
		insert into usuario(id_tipo_usuario,contrasenia,confirmacion) values (3,'12345',0);
		idgenerado = lastval();
		insert into credencialtemporal(id_usuario,num_dui) values (idgenerado,_num_dui);
		insert into excepcionusuario(id_usuario,num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values (idgenerado,_num_dui,_nombre,_apellido,_fecha_nac,_sexo,_direccion,_municipio);
		texto = 'Representante CNR registrado correctamente';
		numero = 1;
	else
		texto = 'El numero de Dui ya esta registrado';
		numero = 0;
	end if;
	return query select numero,texto;
	return;
end;
$body$
language plpgsql;


/*
	procedimiento para agregar cuidadados votantes
	este procedimiento se usará cuando se vacien lo registros del cnr
	se agrega un ciudadano a la tabla padron y se creara una cuenta de usuario para este ciudadano
	la contraseña por defecto sera el numero de dui
*/
create or replace function agregarVotante(
	in _num_dui varchar(10),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _fecha_nac date,
	in _sexo varchar(2),
	in _direccion varchar(30),
	in _municipio int,
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	idgenerado int;
	texto varchar(60);
	numero int;
begin
	if not exists(select * from padronelectoral where num_dui = _num_dui) then
		insert into usuario(id_tipo_usuario,contrasenia,confirmacion) values (3,_num_dui,0);
		idgenerado = lastval();
		insert into padronelectoral(num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values (_num_dui,_nombre,_apellido,_fecha_nac,_sexo,_direccion,_municipio);
		insert into usuariopadron values (idgenerado,_num_dui);
		texto = 'Ciudadano regitrado';
		numero = 1;
	else
		texto = 'El numero de Dui ya esta registrado';
		numero = 0;
	end if;
	return query select numero,texto;
	return;
end;
$body$
language plpgsql;

/*
	registro de supervisores externos, ellos incian sesion con su identificacion,
	su contraseña por defecto es 12345
	retorna 1 y un mensaje de exito cuando se inserto correctamente
	retorna 0 y un mensaje de error cuando no se inserto
*/
create or replace function agregarSupervisorExt(
	in _identificacion varchar(15),
	in _contrasenia varchar(15),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _sexo varchar(2),
	in _pais varchar(15),
	in _organizacion varchar(15),
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	numero int;
	texto varchar(60);
begin
	if not exists(select * from infosupext where identificacion = _identificacion) then
		insert into usuario(id_tipo_usuario,contrasenia,confirmacion) values (4,_contrasenia,0);
		numero = lastval();
		insert into infosupext (id_usuario,identificacion,nombre,apellido,sexo,pais,organizacion) values (numero,_identificacion,_nombre,_apellido,_sexo,_pais,_organizacion);
		texto = 'Supervisor externo registrado correctamente';
		return query select 1,texto;
	else 
		texto = 'La identificacion ya existe';
		return query select 0,texto;
	end if;
	return;
end;
$body$
language plpgsql;


/*
	director del tse, es quien registra a los gestores de jrv por departmento y demas usuarios 
	que los requiera el sistema
*/

create or replace function agregarDirectorTse(
	in _num_dui varchar(10),
	in _contrasenia varchar(15),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _fecha_nac date,
	in _sexo varchar(2),
	in _direccion varchar(30),
	in _municipio int,
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	idgenerado int;
	texto varchar(60);
	numero int;
begin
	if not exists(select * from credencialtemporal where num_dui = _num_dui) then
		insert into usuario(id_tipo_usuario,contrasenia,confirmacion) values (6,'12345',0);
		idgenerado = lastval();
		insert into credencialtemporal(id_usuario,num_dui) values (idgenerado,_num_dui);
		insert into excepcionusuario(id_usuario,num_dui,nombre,apellido,fecha_nac,sexo,direccion_especifica,id_municipio) values (idgenerado,_num_dui,_nombre,_apellido,_fecha_nac,_sexo,_direccion,_municipio);
		texto = 'Director de TSE registrado correctamente';
		numero = 1;
	else
		texto = 'El numero de Dui ya esta registrado';
		numero = 0;
	end if;
	return query select numero,texto;
	return;
end;
$body$
language plpgsql;

/*
	creacion de los demas usuarios del sistema, que no sean administrador, usuario del cnr, votante, magistrado o supervisor externo
	los demas usuarios tienen caracteristicas en comun, el procedimiento recibe 2 parametros, el numero de dui y el tipo de usuario
	para que un usuario de este tipo se pueda crear debe estar previamente registrado en la tabla padronelectoral, en caso contrario retorna 0 y muestra
	un mensaje de alerta
	el procedimiento solo permite la creacion de tipos de usuario 5, 6, 7, 8 y 9 que son
	4.supervisor externo, 5.representante de partido, 6.gestor de informacion, 7.director de centro de votacion, 8.publicista, 9.presidente de jrv

*/
create or replace function agregarUsuario(
	in _num_dui varchar(10),
	in _tipo int,
	out estado int,
	out mensaje varchar(60)
) returns setof record as
$body$
declare
	id int;
	texto varchar(60);
	numero int;
begin
	if exists(select * from padronelectoral where num_dui = _num_dui) then
		if (_tipo >= 5 and _tipo <=9 and _tipo != 6) then
			select u.id_usuario into id from padronelectoral p 
			inner join usuariopadron up on up.num_dui = p.num_dui
			inner join usuario u on u.id_usuario = up.id_usuario
			where p.num_dui = _num_dui;
			update usuario set id_tipo_usuario = _tipo where id_usuario = id;
			texto = 'Usuario agregado';
			numero = 1;
		else
			texto = 'No tienes los privilegios para crear ese tipo de usuario';
			numero = 0;
		end if;
	else
		texto = 'El usuario no existe en el padron electoral';
		numero = 0;
	end if;
	return query select numero, texto;
	return;
end;
$body$
language plpgsql;

/*
	procedimiento de login compartido por administrador, usuario cnr, magistrados, y director del tse
	retorna el tipo de usuario y el dui
*/
create or replace function entrar(
	in _dui varchar(10),
	in _contrasenia varchar(15),
	out tipo int,
	out dui varchar(25)
) returns setof record as
$body$
declare 
	_tipousuario int;
	texto varchar(25);
begin
	if exists(select * from usuario u inner join credencialtemporal ct on u.id_usuario = ct.id_usuario inner join tipousuario tp on tp.id_tipo_usuario = u.id_tipo_usuario where contrasenia = _contrasenia and num_dui = _dui) then
		select tp.id_tipo_usuario into _tipousuario from usuario u inner join credencialtemporal ct
		on u.id_usuario = ct.id_usuario
		inner join tipousuario tp on tp.id_tipo_usuario = u.id_tipo_usuario
		where contrasenia = _contrasenia and num_dui = _dui;
		return query select _tipousuario, _dui;
	else 
		texto = 'credenciales incorrectas';
		return query select 0, texto;
	end if;
end;
$body$
language plpgsql;

/*creacion de cuenta de administrador
*/
insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(1,'12345',0);
insert into credencialTemporal (id_usuario, num_dui) values (1,'00000000-0');

/*uso de los procedimiento almacenados*/
/*los parametros de entrada son numero de dui y contraseña*/
select * from agregarMagistrado('00000001-0','12345','Carlos','Menjivar','1976-09-12','m','Avenida las amapolas',1);
select * from agregarMagistrado('00000002-0','12345','Orlando','Menjivar','1976-08-12','m','Direccion 2',2);
select * from agregarMagistrado('00000003-0','12345','Dayana','Guzman','1987-09-12','f','Calle #12, Escalon',3);
select * from agregarMagistrado('00000004-0','12345','Flor','Fernandez','1976-12-05','f','Colonia enrique araujo',6);
select * from agregarMagistrado('00000005-0','12345','Patricio','roque','1976-09-01','m','Avenida montreal',10);

select * from agregarRepresentanteCNR('00000006-0','12345','Beatriz','Cocar','1996-06-12','f','Canton el espino, #12',2);

select * from agregarDirectorTse('00000000-0','12345','Mario','Ayala','1987-09-11','m','Calle el matazano',13);

select * from agregarSupervisorExt('053315-0980','12345','Will','Smith','m','Estados Unidos','OEA');
select * from agregarSupervisorExt('6656-0-0.09','12345','Robert','Lewandowski','m','Rusia','UEFA');
select * from agregarSupervisorExt('090-AED-B6E-2','12345','Mijail','Black','m','Croacia','ONU');

select * from agregarVotante('00000007-0','Maria','Flores','1994-05-10','f','kernel informatico $5',2);
select * from agregarVotante('00000008-0','Sara','Benitez','1994-05-10','f','Direcion falsa',2);
select * from agregarVotante('00000009-0','Jorge','Anne','1994-05-10','m','Direccion postisa',22);
select * from agregarVotante('00000010-0','Isaac','Ponce','1994-05-10','m','Direccion postisa',30);
select * from agregarVotante('00000011-0','Jonh','Mendoza','1994-05-10','m','Direccion postisa',9);
select * from agregarVotante('00000012-0','Magdalena','De Ramirez','1994-05-10','f','Direccion postisa',6);
select * from agregarVotante('00000013-0','Fernanda','Olivares','1994-05-10','f','Direccion postisa',10);
select * from agregarVotante('00000013-0','Melvin','Dagoberto','1994-05-10','m','Direccion postisa',8);
select * from agregarVotante('00000015-0','Fredy','Mendoza','1994-05-10','m','Direccion postisa',24);
select * from agregarVotante('00000016-0','Faustino','Asprilla','1994-05-10','m','Calle el matazano',25);

select * from agregarUsuario('00000007-0',5);
select * from agregarUsuario('00000008-0',6);
select * from agregarUsuario('00000009-0',7);
select * from agregarUsuario('00000010-0',8);
select * from agregarUsuario('00000011-0',9);



select * from entrarAdministrador('00000000-0','12345');
select * from entrarMagistrado('00000001-0','12345');
select * from entrarCNR('00000006-0','12345');
select * from entrarVotante('00000007-0','00000007-0');