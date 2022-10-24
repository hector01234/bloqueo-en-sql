-- dml -- 


drop database if exists testcfp414;
create database testcfp414;
use testcfp414; 
/********************************TABLAS***********************************/

-- tabla curso -- 
CREATE TABLE tb_curs (
    id_curs int NOT NULL AUTO_INCREMENT, 
    nom_curs varchar(45), 
    desc_curs varchar(100), 
    inscriptos int(3), 
    PRIMARY KEY(id_curs)
);
-- tabla de dias de la semana --
CREATE TABLE tb_dias (
    id_dia int NOT NULL, 
    dia varchar(10),
    PRIMARY KEY (id_dia)
);
-- tabla de los horarios de los cursos -- 
CREATE TABLE tb_horarios (
    id_curs int NOT NULL, 
    id_dia int NOT NULL,
    hr_inicio time,
    hr_fin time,
    PRIMARY KEY(id_curs, id_dia),
    FOREIGN KEY(id_curs) REFERENCES tb_curs(id_curs),
    FOREIGN KEY(id_dia) REFERENCES tb_dias(id_dia)
     
);
-- tabla de las direcciones de los postulantes 
create table direccion(
    dir_postulacion int auto_increment primary key,
    dir_local varchar(20),
    dir_calle varchar(20),
    dir_num varchar(20),
    dir_piso int(10),
    dir_dpto int(10)
);

-- postulantes que desean ingresar a un curso 
CREATE TABLE tb_postulantes (
    dni_post int NOT NULL,
    cuil_post int NOT NULL,
    apyn_post varchar(40),
    email_post varchar(40) NOT NULL,
    tel_post varchar(20),
    prov_post varchar(40),
    pais_post varchar(40),
    fnac_post date,
    edad_post int(2),
    plans_post int(1),
    gen_post varchar(10),
    titulo_post varchar(20),
    estado_post int(1),
    ubicacion_post int not null,
    horario_post int not null,
    foreign key (ubicacion_post) references ubicacion (dir_postulacion),
    foreign key (horario_post)references tb_horario (id_curs, id_dia),
       
);
-- tabla de ingresantes 

create table ingresante(
 tramite_ingre int auto_increment primary key,
 horario_ingre  int not null,
 foreign key (horario_ingre) references tb_postulante(horario_post)
 
);
-- tabla de alumnos ya cargados al sistema 
create table alumno (
numero_alumno int auto_increment primary key,
ingreso_alumno int not null,
horario_alumno int not null,
foreign key (ingreso_alumno) references ingresante (tramite_ingre),
 constraint HorarioCorrecto foreign key (horario_alumno)
 references ingresante (horario_ingre),
   constraint Horario_Correcto check
   (horario_alumno = id_horario ) );
-- funcion controladora para que los horarios no se superpongan 
  CREATE FUNCTION ControladorHorario(x int 64, y INT 64)
RETURNS bit
AS (
 if (horario_alumno between horario_post){

   alter table alumno alter drop column horario_alumno;
   RETURNS bit = 0; 
 }
);
-- inserccion de valores -- 

-- carga de los dias de la semana 
insert into tb_dias 
values (1, 'lunes'),
       (2, 'martes'),
       (3, 'miercoles'),
       (4, 'jueves'),
       (5, 'viernes')
;

-- carga de los horarios de los cursos 
INSERT INTO tb_horarios (id_curs, id_dia, hr_inicio, hr_fin)
VALUES (1,1,'9:10','12:00'),
       (1,3,'9:10','12:00'),
       (1,5,'9:10','12:00'),
       (3,1,'12:00','15:00'),
       (3,3,'12:00','15:00'),
       (3,5,'13:00','16:00'),
       (2,5,'13:00','16:00'),
       (4,1,'12:00','15:00'),
       (4,2,'12:00','16:00'),
       (5,1,'9:00','12:00'),
       (5,2,'9:00','12:00')
;