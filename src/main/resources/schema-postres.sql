CREATE TABLE BATCH_JOB_INSTANCE (
  JOB_INSTANCE_ID BIGINT IDENTITY NOT NULL PRIMARY KEY,
  VERSION         BIGINT,
  JOB_NAME        VARCHAR(100)    NOT NULL,
  JOB_KEY         VARCHAR(32)     NOT NULL,
  CONSTRAINT JOB_INST_UN UNIQUE (JOB_NAME, JOB_KEY)
);

CREATE TABLE BATCH_JOB_EXECUTION (
  JOB_EXECUTION_ID           BIGINT IDENTITY NOT NULL PRIMARY KEY,
  VERSION                    BIGINT,
  JOB_INSTANCE_ID            BIGINT          NOT NULL,
  CREATE_TIME                TIMESTAMP       NOT NULL,
  START_TIME                 TIMESTAMP DEFAULT NULL,
  END_TIME                   TIMESTAMP DEFAULT NULL,
  STATUS                     VARCHAR(10),
  EXIT_CODE                  VARCHAR(2500),
  EXIT_MESSAGE               VARCHAR(2500),
  LAST_UPDATED               TIMESTAMP,
  JOB_CONFIGURATION_LOCATION VARCHAR(2500)   NULL,
  CONSTRAINT JOB_INST_EXEC_FK FOREIGN KEY (JOB_INSTANCE_ID)
  REFERENCES BATCH_JOB_INSTANCE (JOB_INSTANCE_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_PARAMS (
  JOB_EXECUTION_ID BIGINT       NOT NULL,
  TYPE_CD          VARCHAR(6)   NOT NULL,
  KEY_NAME         VARCHAR(100) NOT NULL,
  STRING_VAL       VARCHAR(250),
  DATE_VAL         TIMESTAMP DEFAULT NULL,
  LONG_VAL         BIGINT,
  DOUBLE_VAL       DOUBLE PRECISION,
  IDENTIFYING      CHAR(1)      NOT NULL,
  CONSTRAINT JOB_EXEC_PARAMS_FK FOREIGN KEY (JOB_EXECUTION_ID)
  REFERENCES BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION (
  STEP_EXECUTION_ID  BIGINT IDENTITY NOT NULL PRIMARY KEY,
  VERSION            BIGINT          NOT NULL,
  STEP_NAME          VARCHAR(100)    NOT NULL,
  JOB_EXECUTION_ID   BIGINT          NOT NULL,
  START_TIME         TIMESTAMP       NOT NULL,
  END_TIME           TIMESTAMP DEFAULT NULL,
  STATUS             VARCHAR(10),
  COMMIT_COUNT       BIGINT,
  READ_COUNT         BIGINT,
  FILTER_COUNT       BIGINT,
  WRITE_COUNT        BIGINT,
  READ_SKIP_COUNT    BIGINT,
  WRITE_SKIP_COUNT   BIGINT,
  PROCESS_SKIP_COUNT BIGINT,
  ROLLBACK_COUNT     BIGINT,
  EXIT_CODE          VARCHAR(2500),
  EXIT_MESSAGE       VARCHAR(2500),
  LAST_UPDATED       TIMESTAMP,
  CONSTRAINT JOB_EXEC_STEP_FK FOREIGN KEY (JOB_EXECUTION_ID)
  REFERENCES BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT (
  STEP_EXECUTION_ID  BIGINT        NOT NULL PRIMARY KEY,
  SHORT_CONTEXT      VARCHAR(2500) NOT NULL,
  SERIALIZED_CONTEXT LONGVARCHAR,
  CONSTRAINT STEP_EXEC_CTX_FK FOREIGN KEY (STEP_EXECUTION_ID)
  REFERENCES BATCH_STEP_EXECUTION (STEP_EXECUTION_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT (
  JOB_EXECUTION_ID   BIGINT        NOT NULL PRIMARY KEY,
  SHORT_CONTEXT      VARCHAR(2500) NOT NULL,
  SERIALIZED_CONTEXT LONGVARCHAR,
  CONSTRAINT JOB_EXEC_CTX_FK FOREIGN KEY (JOB_EXECUTION_ID)
  REFERENCES BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE SEQUENCE BATCH_STEP_EXECUTION_SEQ;
CREATE SEQUENCE BATCH_JOB_EXECUTION_SEQ;
CREATE SEQUENCE BATCH_JOB_SEQ;

CREATE TABLE STOP (
  ID VARCHAR NOT NULL PRIMARY KEY,
);