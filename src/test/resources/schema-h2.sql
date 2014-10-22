-- Autogenerate: do not edit this file

CREATE TABLE BATCH_JOB_INSTANCE (
  JOB_INSTANCE_ID BIGINT       NOT NULL PRIMARY KEY,
  VERSION         BIGINT,
  JOB_NAME        VARCHAR(100) NOT NULL,
  JOB_KEY         VARCHAR(32)  NOT NULL,
  CONSTRAINT JOB_INST_UN UNIQUE (JOB_NAME, JOB_KEY)
);

CREATE TABLE BATCH_JOB_EXECUTION (
  JOB_EXECUTION_ID           BIGINT        NOT NULL PRIMARY KEY,
  VERSION                    BIGINT,
  JOB_INSTANCE_ID            BIGINT        NOT NULL,
  CREATE_TIME                TIMESTAMP     NOT NULL,
  START_TIME                 TIMESTAMP DEFAULT NULL,
  END_TIME                   TIMESTAMP DEFAULT NULL,
  STATUS                     VARCHAR(10),
  EXIT_CODE                  VARCHAR(2500),
  EXIT_MESSAGE               VARCHAR(2500),
  LAST_UPDATED               TIMESTAMP,
  JOB_CONFIGURATION_LOCATION VARCHAR(2500) NULL,
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
  STEP_EXECUTION_ID  BIGINT       NOT NULL PRIMARY KEY,
  VERSION            BIGINT       NOT NULL,
  STEP_NAME          VARCHAR(100) NOT NULL,
  JOB_EXECUTION_ID   BIGINT       NOT NULL,
  START_TIME         TIMESTAMP    NOT NULL,
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
  SERIALIZED_CONTEXT TEXT,
  CONSTRAINT STEP_EXEC_CTX_FK FOREIGN KEY (STEP_EXECUTION_ID)
  REFERENCES BATCH_STEP_EXECUTION (STEP_EXECUTION_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT (
  JOB_EXECUTION_ID   BIGINT        NOT NULL PRIMARY KEY,
  SHORT_CONTEXT      VARCHAR(2500) NOT NULL,
  SERIALIZED_CONTEXT TEXT,
  CONSTRAINT JOB_EXEC_CTX_FK FOREIGN KEY (JOB_EXECUTION_ID)
  REFERENCES BATCH_JOB_EXECUTION (JOB_EXECUTION_ID)
);

CREATE SEQUENCE BATCH_STEP_EXECUTION_SEQ MAXVALUE 9223372036854775807 NO CYCLE;
CREATE SEQUENCE BATCH_JOB_EXECUTION_SEQ MAXVALUE 9223372036854775807 NO CYCLE;
CREATE SEQUENCE BATCH_JOB_SEQ MAXVALUE 9223372036854775807 NO CYCLE;

-- GTFS Data
CREATE TABLE agency (
  id              BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system  VARCHAR(50)           NOT NULL,
  agency_id       VARCHAR(100),
  agency_name     VARCHAR(255)          NOT NULL,
  agency_url      VARCHAR(255)          NOT NULL,
  agency_timezone VARCHAR(100)          NOT NULL,
  agency_lang     VARCHAR(100),
  agency_phone    VARCHAR(100),
  agency_fare_url VARCHAR(100)
);

CREATE TABLE calendar_date (
  id             BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system VARCHAR(50)           NOT NULL,
  service_id     VARCHAR(255)          NOT NULL,
  date           VARCHAR(8)            NOT NULL,
  exception_type INT                   NOT NULL
);

CREATE TABLE calendar (
  id             BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system VARCHAR(50)           NOT NULL,
  service_id     VARCHAR(255)          NOT NULL,
  monday         INT                   NOT NULL,
  tuesday        INT                   NOT NULL,
  wednesday      INT                   NOT NULL,
  thursday       INT                   NOT NULL,
  friday         INT                   NOT NULL,
  saturday       INT                   NOT NULL,
  sunday         INT                   NOT NULL,
  start_date     VARCHAR(8)            NOT NULL,
  end_date       VARCHAR(8)            NOT NULL
);

CREATE TABLE fare_attribute (
  id                BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system    VARCHAR(50)           NOT NULL,
  fare_id           VARCHAR(100),
  price             VARCHAR(50)           NOT NULL,
  currency_type     VARCHAR(50)           NOT NULL,
  payment_method    INT                   NOT NULL,
  transfers         INT                   NOT NULL,
  transfer_duration VARCHAR(10),
  exception_type    INT                   NOT NULL,
  agency_id         INT
);

CREATE TABLE fare_rule (
  id             BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system VARCHAR(50)           NOT NULL,
  fare_id        VARCHAR(100),
  route_id       VARCHAR(100),
  origin_id      VARCHAR(100),
  destination_id VARCHAR(100),
  contains_id    VARCHAR(100)
);

CREATE TABLE feed_info (
  id                  BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system      VARCHAR(50)           NOT NULL,
  feed_publisher_name VARCHAR(100),
  feed_publisher_url  VARCHAR(255)          NOT NULL,
  feed_lang           VARCHAR(255)          NOT NULL,
  feed_start_date     VARCHAR(8),
  feed_end_date       VARCHAR(8),
  feed_version        VARCHAR(100)
);

CREATE TABLE frequency (
  id             BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system VARCHAR(50)           NOT NULL,
  trip_id        VARCHAR(100)          NOT NULL,
  start_time     VARCHAR(8)            NOT NULL,
  end_time       VARCHAR(8)            NOT NULL,
  headway_secs   VARCHAR(100)          NOT NULL,
  exact_times    INT
);

CREATE TABLE route (
  id               BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system   VARCHAR(50)           NOT NULL,
  route_id         VARCHAR(100),
  agency_id        VARCHAR(50),
  route_short_name VARCHAR(50)           NOT NULL,
  route_long_name  VARCHAR(255)          NOT NULL,
  route_type       VARCHAR(2)            NOT NULL,
  route_text_color VARCHAR(255),
  route_color      VARCHAR(255),
  route_url        VARCHAR(255),
  route_desc       VARCHAR(255)
);

CREATE TABLE shape (
  id                  BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system      VARCHAR(50)           NOT NULL,
  shape_id            VARCHAR(100)          NOT NULL,
  shape_pt_lat        DECIMAL(12, 10)         NOT NULL,
  shape_pt_lon        DECIMAL(12, 10)         NOT NULL,
  shape_pt_sequence   INT                   NOT NULL,
  shape_dist_traveled VARCHAR(50)
);

CREATE TABLE stop_time (
  id                     BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system         VARCHAR(50)           NOT NULL,
  trip_id                VARCHAR(100)          NOT NULL,
  arrival_time           VARCHAR(8)            NOT NULL,
  arrival_time_seconds   INT,
  departure_time         VARCHAR(8)            NOT NULL,
  departure_time_seconds INT,
  stop_id                VARCHAR(100)          NOT NULL,
  stop_sequence          VARCHAR(100)          NOT NULL,
  stop_headsign          VARCHAR(50),
  pickup_type            VARCHAR(2),
  drop_off_type          VARCHAR(2),
  shape_dist_traveled    VARCHAR(50)
);

CREATE TABLE stop (
  id                  BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system      VARCHAR(50)           NOT NULL,
  stop_id             VARCHAR(255),
  stop_code           VARCHAR(50),
  stop_name           VARCHAR(255)          NOT NULL,
  stop_desc           VARCHAR(255),
  stop_lat            DECIMAL(10, 6)        NOT NULL,
  stop_lon            DECIMAL(10, 6)        NOT NULL,
  stop_street         VARCHAR(255),
  stop_city           VARCHAR(255),
  stop_region         VARCHAR(255),
  stop_postcode       VARCHAR(255),
  stop_country        VARCHAR(255),
  zone_id             VARCHAR(255),
  stop_url            VARCHAR(255),
  location_type       VARCHAR(2),
  parent_station      VARCHAR(100),
  stop_timezone       VARCHAR(50),
  wheelchair_boarding INT
);

CREATE TABLE transfer (
  id                BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system    VARCHAR(50)           NOT NULL,
  from_stop_id      INT                   NOT NULL,
  to_stop_id        VARCHAR(8)            NOT NULL,
  transfer_type     INT                   NOT NULL,
  min_transfer_time VARCHAR(100)
);

CREATE TABLE trip (
  id                    BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  transit_system        VARCHAR(50)           NOT NULL,
  route_id              VARCHAR(100)          NOT NULL,
  service_id            VARCHAR(100)          NOT NULL,
  trip_id               VARCHAR(255),
  trip_headsign         VARCHAR(255),
  trip_short_name       VARCHAR(255),
  direction_id          INT,
  block_id              VARCHAR(11),
  shape_id              VARCHAR(11),
  wheelchair_accessible INT,
  bikes_allowed         INT
);
