
/*1-Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.*/
select apellido1, apellido2, nombre from persona where tipo = 'alumno' order by apellido1 asc, apellido2 asc, nombre asc;

/*2-Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.*/
select apellido1, apellido2, nombre from persona where tipo = 'alumno' and telefono is null;

/*3-Retorna el llistat dels alumnes que van néixer en 1999.*/
select apellido1, apellido2, nombre, EXTRACT(year from fecha_nacimiento) AS AÑO from persona where tipo = 'alumno' AND EXTRACT(year from fecha_nacimiento)= 1999;

/*4-Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.*/
select apellido1, apellido2, nombre, nif from persona where tipo = 'profesor' and nif like '%K' and telefono is null;

/*5-Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.*/
select asignatura.nombre from asignatura inner join grado on asignatura.id_grado = grado.id where cuatrimestre = 1 and curso = 3 and id_grado = 7;

/*6-Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats.  El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament.  El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
select persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre as departamento from persona left join profesor on persona.id = profesor.id_profesor inner join departamento on profesor.id_departamento = departamento.id where tipo = 'profesor'  order by apellido1 asc, apellido2 asc, persona.nombre asc;

/*7-Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.*/
 select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin from alumno_se_matricula_asignatura  inner join persona on alumno_se_matricula_asignatura.id_alumno =  persona.id inner join  asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where persona.nif = '26902806M';
 
 /*8-Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna  assignatura en el Grau en Enginyeria Informàtica (Pla 2015).*/
 
 select  distinct departamento.nombre as departamento, profesor.id_profesor, grado.nombre from profesor  inner join asignatura on profesor.id_profesor = asignatura.id_profesor inner join grado on asignatura.id_grado = grado.id inner join departamento on profesor.id_departamento = departamento.id where grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
 
 /*9-Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar  2018/2019.*/
 select alumno_se_matricula_asignatura.id_alumno from persona inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where  curso_escolar.anyo_inicio between 2018 and 2019  group by alumno_se_matricula_asignatura.id_alumno;
 
 /*Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.*/
 /*1-Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
 select departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre from persona left join profesor on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id where tipo= 'profesor';
 
 /*2-Retorna un llistat amb els professors/es que no estan associats a un departament.*/
 select  persona.apellido1, persona.apellido2, persona.nombre from persona left join profesor on persona.id = profesor.id_profesor where tipo= 'profesor' and profesor.id_departamento is null;
 
 /*3-Retorna un llistat amb els departaments que no tenen professors/es associats.*/
 select departamento.nombre from departamento left join profesor on departamento.id = profesor.id_departamento where profesor.id_departamento is null;
 
 /*4-Retorna un llistat amb els professors/es que no imparteixen cap assignatura.*/
 select profesor.id_profesor from profesor left join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id_profesor is null;
 
 /*5-Retorna un llistat amb les assignatures que no tenen un professor/a assignat.*/
 select asignatura.id, asignatura.nombre from profesor right join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id_profesor is null order by asignatura.nombre asc;
 
 /*6-Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.*/
 select distinct departamento.nombre from departamento left join profesor on departamento.id = profesor.id_departamento left join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id_profesor is null;
 
 /*Consultes resum:*/
 /*1-Retorna el nombre total d'alumnes que hi ha.*/
 select count(persona.id) from persona where tipo = 'alumno';
 
 /*2-Calcula quants alumnes van néixer en 1999.*/ 
 select COUNT(persona.id) as total  from persona where tipo = 'alumno' and EXTRACT(year from fecha_nacimiento) = 1999;
 
 /*3-Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/ 
select departamento.nombre, count(profesor.id_profesor) as total_profesores from profesor left join departamento on profesor.id_departamento = departamento.id where departamento.id is not null group by departamento.nombre order by total desc;

/*4-Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells.Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.*/
select departamento.nombre, count(profesor.id_profesor) as total from profesor right join departamento on profesor.id_departamento = departamento.id group by departamento.nombre order by total desc;
 
 /*5-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus  també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
 select grado.nombre, count(asignatura.id) as total from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre order by total desc;
 
 /*6-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que  té cadascun, dels graus que tinguin més de 40 assignatures associades.*/
 select grado.nombre, count(asignatura.id) as total from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre having count(asignatura.id) > 40 order by total desc;
 
 /*7-Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada  tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels  crèdits de totes les assignatures que hi ha d'aquest tipus.*/
select grado.nombre, asignatura.tipo as asignatura, sum(asignatura.creditos) as total_creditos from grado inner join asignatura on asignatura.id_grado = grado.id group by grado.nombre, asignatura.tipo order by grado.nombre;

/*8-Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos  escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra  amb el nombre d'alumnes matriculats.*/
select curso_escolar.anyo_inicio, count(alumno_se_matricula_asignatura.id_alumno) from alumno_se_matricula_asignatura inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id group by curso_escolar.anyo_inicio;

/*9-Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom,  segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
 select persona.id, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.id) as numero_asignaturas from persona left join profesor on persona.id = profesor.id_profesor left join asignatura on profesor.id_profesor = asignatura.id_profesor where persona.tipo = 'profesor' group by persona.id, persona.nombre, persona.apellido1, persona.apellido2 order by count(asignatura.id) desc;
 
 /*10-Retorna totes les dades de l'alumne/a més jove.*/
select persona.* from persona where fecha_nacimiento = (select min(fecha_nacimiento) from persona where tipo = 'alumno');

/*11-Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.*/
select profesor.id_profesor, departamento.nombre as departamento, asignatura.id as asignatura from profesor left join departamento on profesor.id_departamento = departamento.id left join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id is null;