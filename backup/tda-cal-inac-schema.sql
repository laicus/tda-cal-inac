--
-- PostgreSQL database dump
--

-- Started on 2013-03-04 13:31:34 CST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 10 (class 2615 OID 1821618)
-- Name: td_sch_cal_inac; Type: SCHEMA; Schema: -; Owner: www-data
--

CREATE SCHEMA td_sch_cal_inac;


ALTER SCHEMA td_sch_cal_inac OWNER TO "www-data";

SET search_path = td_sch_cal_inac, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 757 (class 1259 OID 1821620)
-- Dependencies: 10
-- Name: actividad; Type: TABLE; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

CREATE TABLE actividad (
    id_actividad integer NOT NULL,
    nom_actividad character varying(500) NOT NULL,
    id_categoria integer,
    dsc_actividad text
);


ALTER TABLE td_sch_cal_inac.actividad OWNER TO "www-data";

--
-- TOC entry 758 (class 1259 OID 1821627)
-- Dependencies: 10 757
-- Name: actividad_id_actividad_seq; Type: SEQUENCE; Schema: td_sch_cal_inac; Owner: www-data
--

CREATE SEQUENCE actividad_id_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE td_sch_cal_inac.actividad_id_actividad_seq OWNER TO "www-data";

--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 758
-- Name: actividad_id_actividad_seq; Type: SEQUENCE OWNED BY; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER SEQUENCE actividad_id_actividad_seq OWNED BY actividad.id_actividad;


--
-- TOC entry 759 (class 1259 OID 1821629)
-- Dependencies: 10
-- Name: actividad_term; Type: TABLE; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

CREATE TABLE actividad_term (
    id_actividad integer NOT NULL,
    term_id integer NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    id_term_actividad integer NOT NULL
);


ALTER TABLE td_sch_cal_inac.actividad_term OWNER TO "www-data";

--
-- TOC entry 785 (class 1259 OID 1841071)
-- Dependencies: 759 10
-- Name: actividad_term_id_term_actividad_seq; Type: SEQUENCE; Schema: td_sch_cal_inac; Owner: www-data
--

CREATE SEQUENCE actividad_term_id_term_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE td_sch_cal_inac.actividad_term_id_term_actividad_seq OWNER TO "www-data";

--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 785
-- Name: actividad_term_id_term_actividad_seq; Type: SEQUENCE OWNED BY; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER SEQUENCE actividad_term_id_term_actividad_seq OWNED BY actividad_term.id_term_actividad;


SET default_with_oids = false;

--
-- TOC entry 787 (class 1259 OID 1841134)
-- Dependencies: 10
-- Name: cal_actividad; Type: TABLE; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

CREATE TABLE cal_actividad (
    id_cal_actividad integer NOT NULL,
    id_term_acitividad integer NOT NULL,
    cal_item_id integer NOT NULL,
    estado_publicacion boolean NOT NULL
);


ALTER TABLE td_sch_cal_inac.cal_actividad OWNER TO "www-data";

--
-- TOC entry 786 (class 1259 OID 1841132)
-- Dependencies: 787 10
-- Name: cal_actividad_id_cal_actividad_seq; Type: SEQUENCE; Schema: td_sch_cal_inac; Owner: www-data
--

CREATE SEQUENCE cal_actividad_id_cal_actividad_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE td_sch_cal_inac.cal_actividad_id_cal_actividad_seq OWNER TO "www-data";

--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 786
-- Name: cal_actividad_id_cal_actividad_seq; Type: SEQUENCE OWNED BY; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER SEQUENCE cal_actividad_id_cal_actividad_seq OWNED BY cal_actividad.id_cal_actividad;


SET default_with_oids = true;

--
-- TOC entry 760 (class 1259 OID 1821637)
-- Dependencies: 10
-- Name: categoria; Type: TABLE; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

CREATE TABLE categoria (
    id_categoria integer NOT NULL,
    nom_categoria text NOT NULL,
    dsc_categoria text
);


ALTER TABLE td_sch_cal_inac.categoria OWNER TO "www-data";

--
-- TOC entry 761 (class 1259 OID 1821643)
-- Dependencies: 760 10
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: td_sch_cal_inac; Owner: www-data
--

CREATE SEQUENCE categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE td_sch_cal_inac.categoria_id_categoria_seq OWNER TO "www-data";

--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 761
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER SEQUENCE categoria_id_categoria_seq OWNED BY categoria.id_categoria;


--
-- TOC entry 762 (class 1259 OID 1821645)
-- Dependencies: 10
-- Name: modalidad; Type: TABLE; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

CREATE TABLE modalidad (
    id_modalidad character varying(1) NOT NULL,
    nom_modalidad character varying(100) NOT NULL
);


ALTER TABLE td_sch_cal_inac.modalidad OWNER TO "www-data";

--
-- TOC entry 4892 (class 2604 OID 1821651)
-- Dependencies: 758 757
-- Name: id_actividad; Type: DEFAULT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY actividad ALTER COLUMN id_actividad SET DEFAULT nextval('actividad_id_actividad_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 1841073)
-- Dependencies: 785 759
-- Name: id_term_actividad; Type: DEFAULT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY actividad_term ALTER COLUMN id_term_actividad SET DEFAULT nextval('actividad_term_id_term_actividad_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 1841137)
-- Dependencies: 787 786 787
-- Name: id_cal_actividad; Type: DEFAULT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY cal_actividad ALTER COLUMN id_cal_actividad SET DEFAULT nextval('cal_actividad_id_cal_actividad_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 1821653)
-- Dependencies: 761 760
-- Name: id_categoria; Type: DEFAULT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY categoria ALTER COLUMN id_categoria SET DEFAULT nextval('categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4897 (class 2606 OID 1821655)
-- Dependencies: 757 757
-- Name: actividad_pk; Type: CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pk PRIMARY KEY (id_actividad);


--
-- TOC entry 4901 (class 2606 OID 1821661)
-- Dependencies: 760 760
-- Name: categoria_pk; Type: CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pk PRIMARY KEY (id_categoria);


--
-- TOC entry 4903 (class 2606 OID 1821665)
-- Dependencies: 762 762
-- Name: modalidad_pk; Type: CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY modalidad
    ADD CONSTRAINT modalidad_pk PRIMARY KEY (id_modalidad);


--
-- TOC entry 4905 (class 2606 OID 1841139)
-- Dependencies: 787 787
-- Name: pk_id_cal_actividad; Type: CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT pk_id_cal_actividad PRIMARY KEY (id_cal_actividad);


--
-- TOC entry 4899 (class 2606 OID 1841125)
-- Dependencies: 759 759
-- Name: pk_id_term_actividad; Type: CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data; Tablespace: 
--

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT pk_id_term_actividad PRIMARY KEY (id_term_actividad);


--
-- TOC entry 4906 (class 2606 OID 1821671)
-- Dependencies: 757 760 4900
-- Name: actividad_categoria_fk; Type: FK CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_categoria_fk FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);


--
-- TOC entry 4908 (class 2606 OID 1841058)
-- Dependencies: 4896 759 757
-- Name: fk_actividad_dotlrn_term; Type: FK CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT fk_actividad_dotlrn_term FOREIGN KEY (id_actividad) REFERENCES actividad(id_actividad) ON DELETE CASCADE;


--
-- TOC entry 4909 (class 2606 OID 1841145)
-- Dependencies: 498 787
-- Name: fk_cal_item_id; Type: FK CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT fk_cal_item_id FOREIGN KEY (cal_item_id) REFERENCES public.cal_items(cal_item_id);


--
-- TOC entry 4907 (class 2606 OID 1841063)
-- Dependencies: 459 759
-- Name: fk_dotlrn_term_actividad; Type: FK CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY actividad_term
    ADD CONSTRAINT fk_dotlrn_term_actividad FOREIGN KEY (term_id) REFERENCES public.dotlrn_terms(term_id) ON DELETE CASCADE;


--
-- TOC entry 4910 (class 2606 OID 1841140)
-- Dependencies: 759 4898 787
-- Name: fk_id_term_actividad; Type: FK CONSTRAINT; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE ONLY cal_actividad
    ADD CONSTRAINT fk_id_term_actividad FOREIGN KEY (id_term_acitividad) REFERENCES actividad_term(id_term_actividad);


-- Completed on 2013-03-04 13:31:34 CST

--
-- PostgreSQL database dump complete
--

