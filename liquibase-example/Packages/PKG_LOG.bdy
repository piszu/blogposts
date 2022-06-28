CREATE OR REPLACE PACKAGE BODY TEST_USER.PKG_LOG IS

  -- This function sets the current logging level for the environment
  -- Needs customizasion
  FUNCTION getloglevel RETURN NUMBER IS
    ln_result NUMBER;
  BEGIN
    -- SELECT p.value INTO ln_result FROM tb_params p WHERE p.code = 'LOG_LEVEL';

    -- RETURN ln_result;
    RETURN trace_level_debug;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN default_level;
  END getloglevel;

  -- Procedure saves logs in the table
  PROCEDURE logger (
    pi_log_level  VARCHAR2,
    pi_msg        IN  VARCHAR2,
    pi_group      IN  VARCHAR2,
    pi_procedure  IN  VARCHAR2,
    pi_line       IN  NUMBER,
    pi_proc_type  IN  VARCHAR
  ) IS
    PRAGMA autonomous_transaction;
  BEGIN
    IF getloglevel < pi_log_level THEN
      RETURN;
    END IF;
    INSERT INTO tb_logs (
      log_date,
      log_level,
      log_msg,
      log_group,
      log_procedure,
      log_line,
      log_proc_type
    ) VALUES (
      sysdate,
      pi_log_level,
      pi_msg,
      pi_group,
      pi_procedure,
      pi_line,
      pi_proc_type
    );

    COMMIT;
  END logger;

  -- Procedure logs information in DEBUG level
  PROCEDURE debug (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  ) IS

    lv_owner   VARCHAR2 (200);
    lv_name    VARCHAR2 (500);
    ln_lineno  NUMBER;
    lv_caller  VARCHAR2 (200);
  BEGIN
    owa_util.who_called_me (lv_owner, lv_name,
                           ln_lineno, lv_caller);
    logger (trace_level_debug, pi_msg,
           pi_group, lv_owner || '.'
                     || lv_name,
           ln_lineno, lv_caller);

  END debug;

  -- Procedure logs information in INFO level
  PROCEDURE info (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  ) IS

    lv_owner   VARCHAR2 (200);
    lv_name    VARCHAR2 (500);
    ln_lineno  NUMBER;
    lv_caller  VARCHAR2 (200);
  BEGIN
    owa_util.who_called_me (lv_owner, lv_name,
                           ln_lineno, lv_caller);
    logger (trace_level_info, pi_msg,
           pi_group, lv_owner || '.'
                     || lv_name,
           ln_lineno, lv_caller);

  END info;

  -- Procedure logs information in WARN level
  PROCEDURE warn (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  ) IS

    lv_owner   VARCHAR2 (200);
    lv_name    VARCHAR2 (500);
    ln_lineno  NUMBER;
    lv_caller  VARCHAR2 (200);
  BEGIN
    owa_util.who_called_me (lv_owner, lv_name,
                           ln_lineno, lv_caller);
    logger (trace_level_warn, pi_msg,
           pi_group, lv_owner || '.'
                     || lv_name,
           ln_lineno, lv_caller);

  END warn;

  -- Procedure logs information in ERROR level
  PROCEDURE error (
    pi_msg    IN  VARCHAR2,
    pi_group  IN  VARCHAR2
  ) IS

    lv_owner   VARCHAR2 (200);
    lv_name    VARCHAR2 (500);
    ln_lineno  NUMBER;
    lv_caller  VARCHAR2 (200);
  BEGIN
    owa_util.who_called_me (lv_owner, lv_name,
                           ln_lineno, lv_caller);
    logger (trace_level_error, pi_msg,
           pi_group, lv_owner || '.'
                     || lv_name,
           ln_lineno, lv_caller);

  END error;

END PKG_LOG;
/
