CREATE SCHEMA td_sch_cal_inac;

SET search_path = td_sch_cal_inac, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

CREATE TABLE actividad (
    id_actividad integer NOT NULL,
    nom_actividad character varying(500) NOT NULL,
    id_categoria integer,
    fecha_inicio timestamp without time zone,
    fecha_final timestamp without time zone,
    dsc_actividad text,
    id_calendario integer,
    estado_publicacion boolean DEFAULT false
);

CREATE SEQUENCE actividad_id_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE actividad_id_actividad_seq OWNED BY actividad.id_actividad;

CREATE TABLE actividad_term (
    id_actividad integer NOT NULL,
    cal_item_id integer NOT NULL
);

CREATE TABLE calendario (
    id_calendario integer NOT NULL,
    num_ano integer
);

CREATE SEQUENCE calendario_id_calendario_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE calendario_id_calendario_seq OWNED BY calendario.id_calendario;

CREATE TABLE categoria (
    id_categoria integer NOT NULL,
    nom_categoria text NOT NULL,
    dsc_categoria text
);

CREATE SEQUENCE categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE categoria_id_categoria_seq OWNED BY categoria.id_categoria;

CREATE TABLE modalidad (
    id_modalidad character varying(1) NOT NULL,
    nom_modalidad character varying(100) NOT NULL
);

CREATE TABLE modalidad_categoria (
    id_categoria integer NOT NULL,
    id_modalidad character varying(1) NOT NULL
);

ALTER TABLE ONLY actividad ALTER COLUMN id_actividad SET DEFAULT nextval('actividad_id_actividad_seq'::regclass);

ALTER TABLE ONLY calendario ALTER COLUMN id_calendario SET DEFAULT nextval('calendario_id_calendario_seq'::regclass);

ALTER TABLE ONLY categoria ALTER COLUMN id_categoria SET DEFAULT nextval('categoria_id_categoria_seq'::regclass);

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pk PRIMARY KEY (id_actividad);

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT actividad_term_pk PRIMARY KEY (id_actividad, cal_item_id);

ALTER TABLE ONLY calendario
    ADD CONSTRAINT calendario_pk PRIMARY KEY (id_calendario);

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pk PRIMARY KEY (id_categoria);

ALTER TABLE ONLY modalidad_categoria
    ADD CONSTRAINT modalidad_categoria_pkey PRIMARY KEY (id_categoria, id_modalidad);

ALTER TABLE ONLY modalidad
    ADD CONSTRAINT modalidad_pk PRIMARY KEY (id_modalidad);

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_calendario_fk FOREIGN KEY (id_calendario) REFERENCES calendario(id_calendario) ON DELETE CASCADE;

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_categoria_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT actividad_term_actividad_fk FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad) ON DELETE CASCADE;

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT actividad_term_cal_item_fk FOREIGN KEY (cal_item_id) REFERENCES public.cal_items(cal_item_id) ON DELETE CASCADE;

ALTER TABLE ONLY modalidad_categoria
    ADD CONSTRAINT modalidad_categoria_categoria_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);
