delimiter //
drop procedure if exists agregarMagistrado;
create procedure agregarMagistrado(
	in _dui varchar(10),
	in _contrasenia varchar(15)
) 
begin
	if not exists (select num_dui from credencialTemporal where num_dui = _dui) then
		insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(2,_contrasenia,0);
		insert into credencialTemporal (id_usuario, num_dui) values (last_insert_id(),_dui);
		select '1' as exito;
	else 
		select '0' as exito;
	end if;

end //
delimiter ;


delimiter //
drop procedure if exists activarCuenta;
create procedure activarCuenta(
	in _id_usuario int,
	in _id_pregunta int,
	in _respuesta varchar(25)
)
begin
	if exists (select id_usuario from usuario)  then
		if not exists (select id_usuario from respuesta where id_usuario = _id_usuario) then
			insert into respuesta (id_usuario, id_pregunta,respuesta) values (_id_usuario, _id_pregunta,_respuesta);
			update usuario set confirmacion = 1 where id_usuario = _id_usuario;
			select '1' as exito;
		else
			select '0' as exito;
		end if;
	else
		select '0' as exito;
	end if;
end //
delimiter ;

delimiter //
drop procedure if exists agregarSupervisorExterno;
create procedure agregarSupervisorExterno(
	in _contrasenia varchar(15),
	in _identificacion varchar(15),
	in _nombre varchar(20),
	in _apellido varchar(20),
	in _sexo varchar(2),
	in _pais varchar(15),
	in _organizacion varchar(15)
)
begin
	insert into usuario (id_tipo_usuario,contrasenia,confirmacion) values(4,_contrasenia,0);
	insert into infosupext (id_usuario,identificacion,nombre,apellido,sexo,pais,organizacion) values (last_insert_id(),_identificacion,_nombre,_apellido,_sexo,_pais,_organizacion);
end //
delimiter ;

delimiter //
drop procedure if exists validarMagistrado;
create procedure validarMagistrado(
	in _dui varchar(10)
)
begin
	if exists(select * from credencialTemporal ct inner join usuario u on u.id_usuario = ct.id_usuario where num_dui = _dui and u.id_tipo_usuario = 2) then
		select 'funciona';
	else
		select 'no funciona';
	end if ;
end //
delimiter ;


call agregarMagistrado("05243275-6","ferNanda");
call agregarMagistrado("05423275-7","Hola mundo");
call agregarMagistrado("10923375-7","que tal guapo");
call activarCuenta(3,1,"La respuesta esta en tu corazon");
call agregarsupervisorexterno("soydeucrania","053315","mario","gotze","m","belgica","deepweb");


















