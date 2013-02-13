-- Table: td_cal_inac_calendarios

-- DROP TABLE td_cal_inac_calendarios;

CREATE TABLE td_cal_inac_calendarios
(
  id_calendario serial NOT NULL,
  num_ano integer,
  fecha_publicacion date,
  ultima_actualizacion timestamp without time zone,
  CONSTRAINT id_calendario_pk PRIMARY KEY (id_calendario)
)
WITH (OIDS=TRUE);

-- Table: td_cal_inac_categorias

-- DROP TABLE td_cal_inac_categorias;

CREATE TABLE td_cal_inac_categorias
(
  id_categoria serial NOT NULL,
  nom_categoria character varying(200) NOT NULL,
  dsc_categoria character varying(200),
  especial bit(1),
  CONSTRAINT td_cal_inac_pk PRIMARY KEY (id_categoria)
)
WITH (OIDS=TRUE);

-- Table: td_cal_inac_actividades

-- DROP TABLE td_cal_inac_actividades;

CREATE TABLE td_cal_inac_actividades
(
  id_actividad serial NOT NULL,
  nom_actividad character varying(500) NOT NULL,
  id_categoria integer,
  fecha_inicio date,
  fecha_final date,
  dsc_actividad character varying(500),
  id_calendario integer,
  estado_publicacion boolean DEFAULT false,
  CONSTRAINT td_cal_inac_actividades_pkey PRIMARY KEY (id_actividad),
  CONSTRAINT td_cal_inac_actividades_id_calendario_fk FOREIGN KEY (id_calendario)
      REFERENCES td_cal_inac_calendarios (id_calendario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT td_cal_inac_actividades_id_categoria_fkey FOREIGN KEY (id_categoria)
      REFERENCES td_cal_inac_categorias (id_categoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (OIDS=TRUE);

CREATE TABLE td_cal_inac_actividades_temporal
(
  id_actividad integer NOT NULL,
  nom_actividad character varying(500) NOT NULL,
  nom_categoria character varying(100) NOT NULL,
  nom_modalidad character varying(100) NOT NULL,
  nom_periodo character varying(100) NOT NULL,
  fecha_inicio character varying(100) NOT NULL,
  fecha_final character varying(100) NOT NULL,
  dsc_actividad character varying(500),
  id_calendario integer,
  calendario integer,
  CONSTRAINT td_cal_inac_actividades_temporal_pkey PRIMARY KEY (id_actividad)
)
WITH (OIDS=TRUE);

ALTER TABLE td_admision_periodo ADD CONSTRAINT td_cal_inac_periodos_id_calendario_fk FOREIGN KEY (id_calendario)
      REFERENCES td_cal_inac_calendarios (id_calendario) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;

-- Table: td_cal_inac_modalidades

-- DROP TABLE td_cal_inac_modalidades;

CREATE TABLE td_cal_inac_modalidades
(
  id_modalidad character varying(1) NOT NULL,
  nom_modalidad character varying(100) NOT NULL,
  can_periodos smallint,
  es_especial bit(1),
  CONSTRAINT td_cal_inac_modalidades2_pkey PRIMARY KEY (id_modalidad),
  CONSTRAINT td_cal_inac_modalidades2_nom_modalidad_key UNIQUE (nom_modalidad),
  CONSTRAINT td_cal_inac_modalidades2_can_periodos_check CHECK (can_periodos > 0)
)
WITH (OIDS=TRUE);

-- Table: td_cal_inac_modalidadesxcategorias

-- DROP TABLE td_cal_inac_modalidadesxcategorias;

CREATE TABLE td_cal_inac_modalidadesxcategorias
(
  id_categoria integer NOT NULL,
  id_modalidad character varying(1) NOT NULL,
  CONSTRAINT td_cal_inac_modalidadesxcategorias_pkey1 PRIMARY KEY (id_categoria, id_modalidad),
  CONSTRAINT td_cal_inac_modalidadesxcategoria_id_categoria1_fkey FOREIGN KEY (id_categoria)
      REFERENCES td_cal_inac_categorias (id_categoria) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT td_cal_inac_modalidadesxcategorias_id_modalidad1_fkey FOREIGN KEY (id_modalidad)
      REFERENCES td_cal_inac_modalidades (id_modalidad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (OIDS=TRUE);

-- Table: td_cal_inac_periodosxactividades

-- DROP TABLE td_cal_inac_periodosxactividades;

CREATE TABLE td_cal_inac_periodosxactividades
(
  id_periodo integer NOT NULL,
  id_actividad integer NOT NULL,
  CONSTRAINT td_cal_inac_periodosxporactividades_pk PRIMARY KEY (id_periodo, id_actividad),
  CONSTRAINT td_admision_periodo_fk FOREIGN KEY (id_periodo)
      REFERENCES td_admision_periodo (id_term) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT td_cal_inac_actividades_id_actividad_fk FOREIGN KEY (id_actividad)
      REFERENCES td_cal_inac_actividades (id_actividad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (OIDS=FALSE);

-- Table: td_cal_inac_actividadesxterms

-- DROP TABLE td_cal_inac_actividadesxterms;

CREATE TABLE td_cal_inac_actividadesxterms
(
  id_actividad integer NOT NULL,
  cal_item_id integer NOT NULL,
  CONSTRAINT td_cal_inac_actividadesxterms_pkey PRIMARY KEY (id_actividad, cal_item_id),
  CONSTRAINT cal_item_fk FOREIGN KEY (cal_item_id)
      REFERENCES cal_items (cal_item_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT td_cal_inac_actividadesterms_id_actividad_fkey FOREIGN KEY (id_actividad)
      REFERENCES td_cal_inac_actividades (id_actividad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (OIDS=TRUE);

-- Table: td_cal_inac_modalidadesxactividad

-- DROP TABLE td_cal_inac_modalidadesxactividad;

CREATE TABLE td_cal_inac_modalidadesxactividad
(
  id_actividad integer NOT NULL,
  id_modalidad character varying(1) NOT NULL,
  CONSTRAINT td_cal_inac_modalidadesxactividad_pkey PRIMARY KEY (id_actividad, id_modalidad),
  CONSTRAINT td_cal_inac_actividades_id_actividad_fk FOREIGN KEY (id_actividad)
      REFERENCES td_cal_inac_actividades (id_actividad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT td_cal_inac_modalidadesxactividad_id_modalidad_fkey FOREIGN KEY (id_modalidad)
      REFERENCES td_cal_inac_modalidades (id_modalidad) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (OIDS=TRUE);
