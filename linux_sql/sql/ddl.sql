DROP DATABASE IF EXISTS host_agent;
---create and connect to this database

CREATE DATABASE host_agent;
\c host_agent;

CREATE TABLE IF NOT EXISTS PUBLIC.host_info
(
	id	SERIAL NOT NULL,
	hostname VARCHAR NOT NULL,
	cpu_number INT NOT NULL,
	cpu_architecture VARCHAR NOT NULL,
	cpu_model VARCHAR NOT NULL,
	cpu_mhz FLOAT NOT NULL,
	L2_cache INT NOT NULL,
	total_mem INT NOT NULL,
	"timestamp" TIMESTAMP NOT NULL,
	CONSTRAINT host_info_pk PRIMARY KEY (id),
	CONSTRAINT host_info_unique UNIQUE (hostname)
);


--test sample statement
INSERT INTO host_info (id, hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, "timestamp") VALUES (1, 'spry-framework-236416.internal', 1, 'X86_64', 'Intel(R) Xeon(R) CPU @ 2.30GHz', 2300.000, 256, 601324, '2019-05-29 17:49:53');
--SELECT * FROM host_info;
--working :) 

CREATE TABLE IF NOT EXISTS PUBLIC.host_usage
(
	"timestamp" TIMESTAMP NOT NULL,
	host_id SERIAL NOT NULL,
	memory_free INT NOT NULL,
	cpu_idel INT NOT NULL,
	cpu_kernel INT NOT NULL,
	disk_io INT NOT NULL,
	disk_available INT NOT NULL,
	CONSTRAINT host_usage_fk FOREIGN KEY (host_id) REFERENCES host_info(id)
);


--test sample statement
--INSERT INTO host_usage ("timestamp", host_id, memory_free, cpu_idel, cpu_kernel, disk_io, disk_available) VALUES ('2019-05-29 16:53:28', 1, 256, 95, 0, 0, 31220);
--SELECT * FROM host_usage;
--working