DROP DATABASE IF EXISTS sistemavotacion;

CREATE DATABASE sistemavotacion;
USE sistemavotacion;

CREATE TABLE departamento(
    id_departamento INT AUTO_INCREMENT,
    nombre_departamento VARCHAR(15) NOT NULL UNIQUE,
    num_candidatos INT NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (id_departamento)
);
CREATE TABLE municipio (
    id_municipio INT AUTO_INCREMENT,
    id_departamento INT NOT NULL,
    nombre_municipio VARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT pk_municipio PRIMARY KEY (id_municipio)
);
CREATE TABLE centroVotacion (
    id_centro_votacion INT AUTO_INCREMENT,
    id_municipio INT NOT NULL,
    direccion_especifica VARCHAR(30) NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,/*dui del encargado del centro de votacion*/
    nombre_centro VARCHAR(20) NOT NULL,
    num_jrv_disponibles INT NOT NULL,
    CONSTRAINT pk_centroVotacion PRIMARY KEY (id_centro_votacion)
);
CREATE TABLE tipoUsuario (
    id_tipo_usuario INT AUTO_INCREMENT,
    tipo_usuario VARCHAR(15) NOT NULL,
    CONSTRAINT pk_tipoUsuario PRIMARY KEY (id_tipo_usuario)
);
CREATE TABLE pregunta (
    id_pregunta INT AUTO_INCREMENT,
    pregunta VARCHAR(30) NOT NULL,
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
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT,
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
CREATE TABLE partido (
    id_partido INT AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    num_dui VARCHAR(10) NOT NULL UNIQUE,/*dui del presidente del partido*/
    imagen VARCHAR(15) NOT NULL,
    CONSTRAINT pk_partido PRIMARY KEY (id_partido)
);
CREATE TABLE detallePartido (
    id_partido INT NOT NULL,
    id_candidato INT NOT NULL UNIQUE
);
CREATE TABLE candidato (
    id_candidato INT AUTO_INCREMENT,
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    foto VARCHAR(15) NOT NULL,
    tipo INT NOT NULL,/*existen dos tipos de candidatos 1 es afiliado a partdio y 2 es independiente*/
    CONSTRAINT pk_candidato PRIMARY KEY (id_candidato)
);
CREATE TABLE JRV (
    id_jrv INT AUTO_INCREMENT,
    id_centro_votacion INT NOT NULL,
    correlativo_jrv VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT pk_jrv PRIMARY KEY (id_jrv)
);
CREATE TABLE cargoDirectiva (
    id_cargo_directiva INT AUTO_INCREMENT,
    cargo VARCHAR(12) NOT NULL,
    CONSTRAINT pk_cargoDirectiva PRIMARY KEY (id_cargo_directiva)
);
CREATE TABLE directivaJRV (
    num_dui VARCHAR(10) NOT NULL UNIQUE,
    id_jrv INT NOT NULL,
    id_partido INT NOT NULL,
    id_cargo_directiva INT NOT NULL,
    tipo INT NOT NULL,/*existen dos tipos de miembro 1 es propietario 2 es suplente*/
    CONSTRAINT pk_directivaJRV PRIMARY KEY (num_dui)
);
CREATE TABLE aperturaJRV(
    id_jrv INT AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    CONSTRAINT pk_directivaJRV PRIMARY KEY (id_jrv)
);
CREATE TABLE cierreJRV(
    id_jrv INT AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    CONSTRAINT pk_directivaJRV PRIMARY KEY (id_jrv)
);
CREATE TABLE votantePorJRV (
    num_dui VARCHAR(10) NOT NULL,
    id_jrv INT NOT NULL,
    estado INT NOT NULL, /*es para verificar si el votante asistio a votar 0 es que no y 1 es que si*/
    CONSTRAINT pk_votantePorJRV PRIMARY KEY (num_dui)
);
CREATE TABLE papeleta (
    id_papeleta INT AUTO_INCREMENT,
    id_departamento INT NOT NULL,
    CONSTRAINT pk_papeleta PRIMARY KEY (id_papeleta)
);
CREATE TABLE detallePapeleta (
    id_papeleta INT NOT NULL,
    id_candidato INT NOT NULL
);
CREATE TABLE voto (
    id_voto INT AUTO_INCREMENT,
    id_jrv INT NOT NULL,
    CONSTRAINT pk_voto PRIMARY KEY (id_voto)
);
CREATE TABLE votoAbstenido (
    id_voto_abstenido INT AUTO_INCREMENT,
    id_voto INT NOT NULL,
    CONSTRAINT pk_votoAbstenido PRIMARY KEY (id_voto_abstenido)
);
CREATE TABLE votoBandera (
    id_voto_bandera INT AUTO_INCREMENT,
    id_voto INT NOT NULL,
    id_partido INT NOT NULL,
    CONSTRAINT pk_votoBandera PRIMARY KEY (id_voto_bandera)
);
CREATE TABLE votoMarca (
    id_voto_marca INT AUTO_INCREMENT,
    id_voto INT NOT NULL,
    id_candidato INT NOT NULL,
    valor_porcentual float(10,2) NOT NULL,
    CONSTRAINT pk_votoMarca PRIMARY KEY (id_voto_marca)
);
CREATE TABLE votoIndependiente (
    id_voto_independiente INT AUTO_INCREMENT,
    id_voto INT NOT NULL,
    id_candidato INT NOT NULL,
    valor_porcentual float(10,2) NOT NULL,
    CONSTRAINT pk_votoIndependiente PRIMARY KEY (id_voto_independiente)
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

alter table candidato add constraint fk_candidato_detallePartido foreign key (id_candidato) references detallePartido(id_candidato);

alter table detallePartido add constraint fk_detalleP_partido foreign key (id_partido) references partido(id_partido);
alter table directivaJRV add constraint fk_directivaJRV_partido foreign key (id_partido) references partido(id_partido);

alter table votoMarca add constraint fk_vMarca_candidato foreign key (id_candidato) references candidato(id_candidato);
alter table votoIndependiente add constraint fk_vIndependiente_candidato foreign key (id_candidato) references candidato(id_candidato);

alter table directivaJRV add constraint fk_directivaJRV_cargoDirectiva foreign key (id_cargo_directiva) references cargoDirectiva(id_cargo_directiva);

alter table votoBandera add constraint fk_vBandera_partido foreign key (id_partido) references partido(id_partido);

alter table partido add constraint fk_partido_excepcionUsuario foreign key (num_dui) references excepcionUsuario(num_dui);

alter table detallePapeleta add constraint fk_detallePapeleta_papeleta foreign key (id_papeleta) references papeleta(id_papeleta);

alter table detallePapeleta add constraint fk_detallePapeleta_candidato foreign key (id_candidato) references candidato(id_candidato);

alter table aperturaJRV add constraint fk_aperturaJRV_directivaJRV foreign key (id_jrv) references directivaJRV(id_jrv);
alter table cierreJRV add constraint fk_cierreJRV_directivaJRV foreign key (id_jrv) references directivaJRV(id_jrv);