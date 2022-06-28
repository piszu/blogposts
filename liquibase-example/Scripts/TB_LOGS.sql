CREATE TABLE TEST_USER.tb_logs (
  log_id         NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
  log_date       DATE NOT NULL,
  log_level      NUMBER NOT NULL,
  log_msg        VARCHAR2 (4000) NOT NULL,
  log_group      VARCHAR2 (4000),
  log_procedure  VARCHAR2 (4000),
  log_line       NUMBER,
  log_proc_type  VARCHAR2 (4000),

  CONSTRAINT tblg_pk PRIMARY KEY (log_id) USING INDEX
);
