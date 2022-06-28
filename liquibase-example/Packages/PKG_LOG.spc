CREATE OR REPLACE PACKAGE TEST_USER.PKG_LOG IS

  default_level CONSTANT NUMBER := 10;
  trace_level_error CONSTANT NUMBER := 1;
  trace_level_warn CONSTANT NUMBER := 10;
  trace_level_info CONSTANT NUMBER := 50;
  trace_level_debug CONSTANT NUMBER := 100;

  -- Procedure logs information in DEBUG level
  PROCEDURE debug (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  );

  -- Procedure logs information in INFO level
  PROCEDURE info (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  );

  -- Procedure logs information in WARN level
  PROCEDURE warn (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  );

  -- Procedure logs information in ERROR level
  PROCEDURE error (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  );

END PKG_LOG;
/