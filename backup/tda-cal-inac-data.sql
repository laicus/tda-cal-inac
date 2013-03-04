--
-- PostgreSQL database dump
--

-- Started on 2013-03-04 13:32:09 CST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = td_sch_cal_inac, pg_catalog;



--
-- TOC entry 4914 (class 0 OID 1821645)
-- Dependencies: 762
-- Data for Name: modalidad; Type: TABLE DATA; Schema: td_sch_cal_inac; Owner: www-data
--

ALTER TABLE modalidad DISABLE TRIGGER ALL;

INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('B', 'BIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('C', 'CUATRIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('M', 'MENSUAL');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('S', 'SEMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('T', 'TRIMESTRE');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('A', 'ANUAL');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('H', 'HUMANISTICA');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('I', 'INTENSIVO');
INSERT INTO modalidad (id_modalidad, nom_modalidad) VALUES ('V', 'VERANO');


ALTER TABLE modalidad ENABLE TRIGGER ALL;

-- Completed on 2013-03-04 13:32:09 CST

--
-- PostgreSQL database dump complete
--

