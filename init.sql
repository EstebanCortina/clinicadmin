GRANT CONNECT ON DATABASE clinicadmin TO cla_user;

GRANT USAGE ON SCHEMA public TO cla_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO cla_user;


ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE ON TABLES TO cla_user;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create table health (
	id serial primary key,
	info text null
);

create table "user" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	email text unique not null,
	password text not null,
	is_active bool default true,
	created_at timestamp default CURRENT_TIMESTAMP,
	updated_at timestamp null,
	deleted_at timestamp null
);


create table "patient" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name varchar(20) not null,
	last_name text not null,
	age integer not null,
	national_id_number text not null,
	phone varchar(13) not null,
	address text not null,
	email text null,
	blood_group char(3),
	sex char(1) null,
	comments text null,
	is_active bool default true,
	created_at timestamp default CURRENT_TIMESTAMP,
	updated_at timestamp null,
	deleted_at timestamp null
);

create table "patient_file" (
	id serial primary key,
	patient_id UUID not null,
	file bytea not null,
	is_main bool default false,
	CONSTRAINT fk_patient_id
	FOREIGN KEY (patient_id) 
	REFERENCES "patient"(id)
);

create table "appointment_type" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name varchar(30) unique not null,
	description text null
);

create table "appointment_status_type" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name varchar(30) unique not null,
	description text null
);

create table "appointment" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	appointment_type_id UUID not null,
	patient_id UUID not null,
	schedule_date timestamp not null,
	comments text null,
	appointment_status_type_id UUID not null,
	created_at timestamp default CURRENT_TIMESTAMP,
	updated_at timestamp null,
	deleted_at timestamp null,
	CONSTRAINT fk_appointment_type_id 
	FOREIGN KEY (appointment_type_id) 
	REFERENCES "appointment_type"(id),
	CONSTRAINT fk_patient_id 
	FOREIGN KEY (patient_id) 
	REFERENCES "patient"(id),
	CONSTRAINT fk_appointment_status_type_id 
	FOREIGN KEY (appointment_status_type_id) 
	REFERENCES "appointment_status_type"(id)
);

/*
create table "appointment_patient" (
	id serial primary key,
	appointment_id UUID not null,
	patient_id UUID not null,
	created_at timestamp default CURRENT_TIMESTAMP,
	updated_at timestamp null,
	deleted_at timestamp null,
	CONSTRAINT fk_appointment_id
	FOREIGN KEY (appointment_id) 
	REFERENCES "appointment"(id),
	CONSTRAINT fk_patient_id 
	FOREIGN KEY (patient_id) 
	REFERENCES "patient"(id)
);
*/

create table "treatment_type" (
	id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	name varchar(100) unique not null,
	description text null
);

create table "treatment_type_patient" (
	id serial primary key,
	patient_id UUID not null,
	treatment_type_id UUID,
	from_date timestamp not null,
	to_date timestamp null,
	comments text null,
	created_at timestamp default CURRENT_TIMESTAMP,
	updated_at timestamp null,
	deleted_at timestamp null,
	CONSTRAINT fk_patient_id
	FOREIGN KEY (patient_id) 
	REFERENCES "patient"(id),
	CONSTRAINT fk_treatment_type_id
	FOREIGN KEY (treatment_type_id) 
	REFERENCES "treatment_type"(id)
);

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO cla_user;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE patient_file_id_seq to cla_user;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE treatment_type_patient_id_seq to cla_user;

INSERT INTO "user" (email, password) VALUES ('admin@clinicadmin.com', '$2a$12$Dssz0LWRDKXHYK1jWAQpnOJYg31QepedqeCda3eNqsw4Wp7WeMP0O');

insert into "treatment_type" (name, description) values ('Dental', 'El paciente recibe tratamiento para sus dientes.');
insert into "treatment_type" (name, description) values ('Fisioterapia', 'El paciente recibe rehabilitación.');
insert into "treatment_type" (name, description) values ('Psicología', 'El paciente recibe ayuda psicológica.');

insert into "appointment_type" (name, description) values ('Inicial', 'Primera cita que agenda el paciente.');
insert into "appointment_type" (name, description) values ('Seguimiento', 'Cita para continuar con el tratamiento del paciente.');

insert into "appointment_status_type" (name, description) values ('Pendiente', 'La cita aún no se ha realizado.');
insert into "appointment_status_type" (name, description) values ('Realizada', 'La cita ya se ha realizado.');
insert into "appointment_status_type" (name, description) values ('Cancelada', 'La cita aún no se ha cancelado.');
