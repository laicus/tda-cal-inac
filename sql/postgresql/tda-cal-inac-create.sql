SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

CREATE SCHEMA td_sch_cal_inac;

ALTER SCHEMA td_sch_cal_inac OWNER TO "www-data";

SET search_path = td_sch_cal_inac, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

CREATE TABLE actividad (
    id_actividad integer NOT NULL,
    nom_actividad character varying(500) NOT NULL,
    id_categoria integer,
    dsc_actividad text
);

ALTER TABLE td_sch_cal_inac.actividad OWNER TO "www-data";

CREATE SEQUENCE actividad_id_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE td_sch_cal_inac.actividad_id_actividad_seq OWNER TO "www-data";

ALTER SEQUENCE actividad_id_actividad_seq OWNED BY actividad.id_actividad;

SELECT pg_catalog.setval('actividad_id_actividad_seq', 15, true);

CREATE TABLE actividad_term (
    id_term_actividad integer NOT NULL,
    id_actividad integer NOT NULL,
    term_id integer NOT NULL,
    fecha_inicio date,
    fecha_fin date    
);

ALTER TABLE td_sch_cal_inac.actividad_term OWNER TO "www-data";

CREATE SEQUENCE actividad_term_id_term_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE td_sch_cal_inac.actividad_term_id_term_actividad_seq OWNER TO "www-data";

ALTER SEQUENCE actividad_term_id_term_actividad_seq OWNED BY actividad_term.id_term_actividad;

SELECT pg_catalog.setval('actividad_term_id_term_actividad_seq', 14, true);

SET default_with_oids = false;

CREATE TABLE cal_actividad (
    id_cal_actividad integer NOT NULL,
    id_term_actividad integer NOT NULL,
    calendar_id integer NOT NULL,
    estado_publicacion boolean NOT NULL,
    cal_item_id integer
);

ALTER TABLE td_sch_cal_inac.cal_actividad OWNER TO "www-data";

CREATE SEQUENCE cal_actividad_id_cal_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE td_sch_cal_inac.cal_actividad_id_cal_actividad_seq OWNER TO "www-data";

ALTER SEQUENCE cal_actividad_id_cal_actividad_seq OWNED BY cal_actividad.id_cal_actividad;

SELECT pg_catalog.setval('cal_actividad_id_cal_actividad_seq', 41, true);

SET default_with_oids = true;

CREATE TABLE categoria (
    id_categoria integer NOT NULL,
    nom_categoria text NOT NULL,
    dsc_categoria text
);

ALTER TABLE td_sch_cal_inac.categoria OWNER TO "www-data";

CREATE SEQUENCE categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE td_sch_cal_inac.categoria_id_categoria_seq OWNER TO "www-data";

ALTER SEQUENCE categoria_id_categoria_seq OWNED BY categoria.id_categoria;

SELECT pg_catalog.setval('categoria_id_categoria_seq', 37, true);

CREATE TABLE modalidad (
    id_modalidad character varying(1) NOT NULL,
    nom_modalidad character varying(100) NOT NULL
);

ALTER TABLE td_sch_cal_inac.modalidad OWNER TO "www-data";

ALTER TABLE ONLY actividad ALTER COLUMN id_actividad SET DEFAULT nextval('actividad_id_actividad_seq'::regclass);

ALTER TABLE ONLY actividad_term ALTER COLUMN id_term_actividad SET DEFAULT nextval('actividad_term_id_term_actividad_seq'::regclass);

ALTER TABLE ONLY cal_actividad ALTER COLUMN id_cal_actividad SET DEFAULT nextval('cal_actividad_id_cal_actividad_seq'::regclass);

ALTER TABLE ONLY categoria ALTER COLUMN id_categoria SET DEFAULT nextval('categoria_id_categoria_seq'::regclass);

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pk PRIMARY KEY (id_actividad);

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pk PRIMARY KEY (id_categoria);

ALTER TABLE ONLY modalidad
    ADD CONSTRAINT modalidad_pk PRIMARY KEY (id_modalidad);

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT pk_id_cal_actividad PRIMARY KEY (id_cal_actividad);

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT pk_id_term_actividad PRIMARY KEY (id_term_actividad);

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_categoria_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT cal_item_id_fk FOREIGN KEY (cal_item_id) REFERENCES public.cal_items(cal_item_id);

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT fk_actividad_dotlrn_term FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad) ON DELETE CASCADE;

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT fk_calendar_id FOREIGN KEY (calendar_id) REFERENCES public.calendars(calendar_id);

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT fk_dotlrn_term_actividad FOREIGN KEY (term_id) REFERENCES public.dotlrn_terms(term_id) ON DELETE CASCADE;

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT fk_id_term_actividad FOREIGN KEY (id_term_actividad) REFERENCES actividad_term(id_term_actividad);

INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('B', 'BIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('C', 'CUATRIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('M', 'MENSUAL');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('S', 'SEMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('T', 'TRIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('A', 'ANUAL');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('H', 'HUMANISTICA');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('I', 'INTENSIVO');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('V', 'VERANO');
