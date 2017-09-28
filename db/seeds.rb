# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Location.create!(
    id: 1,
    address: 'Avenida Medrano 951',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.5978',
    longitude: '-58.4207'
)

Location.create!(
    id: 2,
    address: 'Avenida Córdoba 3801',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.599337',
    longitude: '-58.423606'
)

Location.create!(
    id: 3,
    address: 'Bulnes 901',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.600839',
    longitude: '-58.417736'
)

Location.create!(
    id: 4,
    address: 'Gorriti 3701',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.595463',
    longitude: '-58.417137'
)

Location.create!(
    id: 5,
    address: 'Gorriti 4029',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.595296',
    longitude: '-58.422219'
)

Location.create!(
    id: 6,
    address: 'Medrano 951',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.5978',
    longitude: '-58.4207'
)

Location.create!(
    id: 7,
    address: 'Guardia Vieja 4357',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.600065',
    longitude: '-58.426166'
)

Location.create!(
    id: 8,
    address: 'Avenida Cordoba 2911',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.597992',
    longitude: '-58.408346'
)

Location.create!(
    id: 9,
    address: 'Araoz 1114',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.594676',
    longitude: '-58.428966'
)

Location.create!(
    id: 10,
    address: 'Lerma 179',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.596831',
    longitude: '-58.429490'
)

Location.create!(
    id: 11,
    address: 'Pringles 1448',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.595088',
    longitude: '-58.424187'
)

Location.create!(
    id: 12,
    address: 'Avenida Medrano 835',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.600222',
    longitude: '-58.420523'
)

Location.create!(
    id: 13,
    address: 'Avenida Córdoba 3801',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.599337',
    longitude: '-58.423606'
)

Location.create!(
    id: 14,
    address: 'Bulnes 901',
    city: 'Ciudad Autónoma de Buenos Aires',
    latitude: '-34.600839',
    longitude: '-58.417736'
)

User.create!(name:  "Admin",
             lastname: 'Admin',
             email: "admin@admin.com",
             role: "ADMIN",
             location_id: 1,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456")

Reputacion.create!(
    id: 1,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 0,
    SUM_CursosInscriptos: 0,
    user_id: 1
)

User.create!(name:  "Hernan",
             lastname: 'Noriega',
             email: "hernan_611@hotmail.com",
             role: "COMUN",
             location_id: 2,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Futbol, Gimnasia, Matematica',
             notas: 'Soy fanatico de jugar a la pelota',
             experiencia: 'Estudiando Ing. Sistemas de Información')

Reputacion.create!(
    id: 2,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 0,
    SUM_CursosInscriptos: 0,
    user_id: 2
)

User.create!(name:  "Victoria",
             lastname: 'Cabrera',
             email: "toiacabrera@hotmail.com",
             role: "COMUN",
             location_id: 3,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Danza, Matematica, Enseñanza',
             notas: 'All you need is love',
             experiencia: 'Estudiando Ing. Sistemas de Información')

Reputacion.create!(
    id: 3,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 2,
    SUM_CursosInscriptos: 0,
    user_id: 3
)

User.create!(name:  "Santa Catalina",
             email: "anita.estevez@hotmail.com",
             role: "FUNDACION",
             location_id: 4,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Ayudar, Educacion integrada, Enseñanza con amor',
             notas: 'Fanaticos de sumemos uno mas!',
             experiencia: 'Fundacion con 15 años de antiguedad')

Reputacion.create!(
    id: 4,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 0,
    SUM_CursosInscriptos: 0,
    user_id: 4
)

User.create!(name:  "Manos abiertas",
             email: "manos.abiertas@hotmail.com",
             role: "FUNDACION",
             location_id: 5,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456")

Reputacion.create!(
    id: 5,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 0,
    SUM_CursosInscriptos: 0,
    user_id: 5
)

User.create!(name:  "Camila",
             lastname: 'Santillán',
             email: "camigarciasantillan@hotmail.com",
             role: "COMUN",
             location_id: 6,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Cantar, Tocar la guitarra, Lenguas, Inglés',
             experiencia: 'Trabajo Freelance de diseño')

Reputacion.create!(
    id: 6,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 0,
    SUM_CursosInscriptos: 1,
    user_id: 6
)

PaymentType.create!(
    name: "AMEX",
    description: "Tarjeta asociada a mi cuenta en Todo Pago",
    tipe: "Todo Pago",
    user_id: 6,
    authorization: "2342",
    merchant: "9800"
)

User.create!(name:  "Jonatan",
             lastname: 'Pereyra',
             email: "pereyrajonatan@gmail.com",
             role: "COMUN",
             location_id: 7,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Futbol, Papá fulltime, Matematica',
             experiencia: 'Estudiando Ing. Industrial')

Reputacion.create!(
    id: 7,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 2,
    SUM_CursosInscriptos: 1,
    user_id: 7
)

PaymentType.create!(
    name: "Mi VISA",
    description: "Asociada a mi cuenta en Todo Pago",
    tipe: "Todo Pago",
    user_id: 7,
    authorization: "2342",
    merchant: "9800"
)

User.create!(name:  "Emilio",
             lastname: 'Dalcol',
             email: "juandalcol@hotmail.com",
             role: "COMUN",
             location_id: 8,
             activated: true,
             activated_at: Time.zone.now,
             active: true,
             password:              "123456",
             password_confirmation: "123456",
             habilidades: 'Literatura, Leyes, Hip Hop',
             experiencia: 'Estudiando Abogacia')

Reputacion.create!(
    id: 8,
    SUM_ProfesorRecomendado: 0,
    AVG_ReputacionProfesor: 0,
    AVG_ReputacionAlumno: 0,
    PCT_AsistenciaAClases: 0,
    SUM_CursosCreados: 2,
    SUM_CursosInscriptos: 1,
    user_id: 8
)

Curso.create!(
    id: 50,
    nombre: "Astronomía",
    descripcion: "Querés saber que existe mas alla del planeta Tierra?. En este curso veremos cosas asombrosas sobre el unvierso, el sistema solar y estelar.",
    contenido: "1. Introduccion al universo \n 2. El sistema solar \n 3. Los planetas \n 4. El sistema Estelar \n 5.Las constelaciones mas importantes",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 15,
    relacion_b_nb: 3,
    user_id: 7,
    tipo_actividad: "Académica",
    location_id: 9,
    monto: 120,
    tarjeta: true,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 1,
   nombre: "Introduccion al universo",
   descripcion: "Querés saber que existe mas alla del planeta Tierra?. En este curso veremos cosas asombrosas sobre el unvierso, el sistema solar y estelar.",
   contenido: "",
   fecha: "24/08/2016",
   hora_inicio: "20:00",
   hora_fin: "22:00",
   curso_id: 50
)

Clase.create!(
    id: 2,
    nombre: "Los planetas",
    descripcion: "Querés saber que existe mas alla del planeta Tierra?. En este curso veremos cosas asombrosas sobre el unvierso, el sistema solar y estelar.",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 50
)

Clase.create!(
    id: 3,
    nombre: "El sistema estelar",
    descripcion: "Querés saber que existe mas alla del planeta Tierra?. En este curso veremos cosas asombrosas sobre el unvierso, el sistema solar y estelar.",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 50
)

Clase.create!(
    id: 4,
    nombre: "Las constelaciones mas importantes",
    descripcion: "Querés saber que existe mas alla del planeta Tierra?. En este curso veremos cosas asombrosas sobre el unvierso, el sistema solar y estelar.",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 50
)

Curso.create!(
    id: 60,
    nombre: "Matematica",
    descripcion: "¿Eres amante de los números o por el contrario, te resulta difícil comprender las matemáticas? \n Te acercamos 4 simples clases para comprender el mundo de las matemáticas y sus diferentes aplicaciones",
    contenido: "1. Introduccion al mundo de la matematica \n 2. Los numeros \n 3. Operaciones \n 4. Aplicaciones en el mundo real",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 15,
    relacion_b_nb: 3,
    user_id: 7,
    tipo_actividad: "Académica",
    location_id: 10,
    monto: 165,
    tarjeta: true,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 5,
    nombre: "Introduccion al mundo de la matematica",
    descripcion: "",
    contenido: "",
    fecha: "24/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 60
)

Clase.create!(
    id: 6,
    nombre: "Los numeros",
    descripcion: "",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 60
)

Clase.create!(
    id: 7,
    nombre: "Operaciones",
    descripcion: "",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 60
)

Clase.create!(
    id: 8,
    nombre: "Aplicaciones en el mundo real",
    descripcion: "",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 60
)

Curso.create!(
    id: 70,
    nombre: "Futbol",
    descripcion: "Para todos aquellos que quieran aprender la técnica del toque, dominio y control de balon mediante la realización de ejercicios prácticos.",
    contenido: "En cada clas: 1.Entrada en calor \n 2.Practicas \n 3.Elongacion",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 15,
    relacion_b_nb: 3,
    user_id: 3,
    tipo_actividad: "Deportes",
    location_id: 11,
    monto: 190,
    tarjeta: false,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 9,
    nombre: "Semana 1",
    descripcion: "",
    contenido: "",
    fecha: "24/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 70
)

Clase.create!(
    id: 10,
    nombre: "Semana 2",
    descripcion: "",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 70
)

Clase.create!(
    id: 11,
    nombre: "Semana 3",
    descripcion: "",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 70
)

Clase.create!(
    id: 12,
    nombre: "Semana 4",
    descripcion: "",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 70
)
Curso.create!(
    id: 80,
    nombre: "Lengua y Literatura",
    descripcion: "¿Eres amante de la literatura o necesitas apoyo en el estudio de la lengua espanola?
      Te acercamos 4 simples clases para comprender el mundo de la lengua y la literatura",
    contenido: "1. Elementos de la comunicacion \n 2. La silaba. Diptongo, Triptongo e hiato  \n 3. Los recursos literarios \n 4. Las relaciones semanticas",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 10,
    relacion_b_nb: 2,
    user_id: 3,
    tipo_actividad: "Académica",
    location_id: 12,
    monto: 215,
    tarjeta: false,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 13,
    nombre: "Elementos de la comunicacion",
    descripcion: "",
    contenido: "",
    fecha: "24/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 80
)

Clase.create!(
    id: 14,
    nombre: "La silaba. Diptongo, Triptongo e hiato",
    descripcion: "",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 80
)

Clase.create!(
    id: 15,
    nombre: "Los recursos literarios",
    descripcion: "",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 80
)

Clase.create!(
    id: 16,
    nombre: "Las relaciones semanticas",
    descripcion: "",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 80
)

Curso.create!(
    id: 30,
    nombre: "Piano",
    descripcion: "Seminario de piano",
    contenido: "1. Teoría de la música \n 2. Interpretacion \n 3. Ensamble",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 9,
    relacion_b_nb: 3,
    user_id: 8,
    tipo_actividad: "Arte",
    location_id: 13,
    monto: 345,
    tarjeta: false,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 17,
    nombre: "Teoria de la musica",
    descripcion: "",
    contenido: "",
    fecha: "24/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 30
)

Clase.create!(
    id: 18,
    nombre: "Interpretacion I",
    descripcion: "",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 30
)

Clase.create!(
    id: 19,
    nombre: "Interpretacion II",
    descripcion: "",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 30
)

Clase.create!(
    id: 20,
    nombre: "Ensamble",
    descripcion: "",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 30
)

Curso.create!(
    id: 40,
    nombre: "Legislación",
    descripcion: "Curso de apoyo a los temas basicos de Legislacion",
    contenido: "1. El derecho \n 2. La ley \n 3. La constitucion  \n 4. Hechos y actos juridicos",
    fecha_inicio: "24/08/2016",
    fecha_fin: "14/09/2016",
    cupos: 9,
    relacion_b_nb: 3,
    user_id: 8,
    tipo_actividad: "Académica",
    location_id: 14,
    monto: 465,
    tarjeta: false,
    efectivo: true,
    publicado: true
)

Clase.create!(
    id: 21,
    nombre: "El derecho",
    descripcion: "",
    contenido: "",
    fecha: "24/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 40
)

Clase.create!(
    id: 22,
    nombre: "La Ley",
    descripcion: "",
    contenido: "",
    fecha: "31/08/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 40
)

Clase.create!(
    id: 23,
    nombre: "La constitucion",
    descripcion: "",
    contenido: "",
    fecha: "07/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 40
)

Clase.create!(
    id: 24,
    nombre: "Hechos y actos juridicos",
    descripcion: "",
    contenido: "",
    fecha: "14/09/2016",
    hora_inicio: "20:00",
    hora_fin: "22:00",
    curso_id: 40
)

Inscripto.create!(
  id: 1,
  user_id: 6,
  curso_id: 80,
  tipe: 'Efectivo'
)

Inscripcion.create!(
  inscripto_id: 1,
  clase_id: 13,
  pago: true
)

Inscripcion.create!(
    inscripto_id: 1,
    clase_id: 14,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 1,
    clase_id: 15,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 1,
    clase_id: 16,
    pago: true
)

Inscripto.create!(
    id: 2,
    user_id: 7,
    curso_id: 80,
    tipe: 'Efectivo'
)

Inscripcion.create!(
    inscripto_id: 2,
    clase_id: 13,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 2,
    clase_id: 14,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 2,
    clase_id: 15,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 2,
    clase_id: 16,
    pago: true
)

Inscripto.create!(
    id: 3,
    user_id: 8,
    curso_id: 80,
    tipe: 'Efectivo'
)

Inscripcion.create!(
    inscripto_id: 3,
    clase_id: 13,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 3,
    clase_id: 14,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 3,
    clase_id: 15,
    pago: true
)

Inscripcion.create!(
    inscripto_id: 3,
    clase_id: 16,
    pago: true
)