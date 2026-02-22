-- ============================================================
-- Migration 005 : Création table IMPACT SERVICE
-- Description   : Alarmes avec impact sur les services réseau
-- Date          : 2026
-- ============================================================

USE incidents_reseau;

DROP TABLE IF EXISTS impact_service;

CREATE TABLE impact_service (
    id                              INT AUTO_INCREMENT PRIMARY KEY,
    alarm_type                      VARCHAR(100),
    severity                        VARCHAR(50),
    alarm_source                    VARCHAR(100),
    name                            VARCHAR(200),
    comment                         TEXT,
    last_occurred                   DATETIME,
    cleared_on                      DATETIME,
    location_information            TEXT,
    occurrence_times                VARCHAR(50),
    ne_type                         VARCHAR(50),
    mo_name                         VARCHAR(200),
    first_occurred                  DATETIME,
    acknowledged_on                 DATETIME,
    cleared_by                      VARCHAR(100),
    acknowledged_by                 VARCHAR(100),
    clearance_status                VARCHAR(50),
    acknowledgement_status          VARCHAR(50),
    additional_information          TEXT,
    type                            VARCHAR(100),
    alarm_duration                  VARCHAR(100),
    alarm_id                        VARCHAR(50),
    associated_alarm_group_id       VARCHAR(100),
    auto_clear                      VARCHAR(20),
    bbu_name                        VARCHAR(100),
    clearance_type                  VARCHAR(100),
    common_alarm_identifier         VARCHAR(100),
    dev_root_csn                    VARCHAR(100),
    equipment_alarm_serial_number   VARCHAR(50),
    external_resource_id            VARCHAR(100),
    list_serial_number              VARCHAR(100),
    log_serial_number               VARCHAR(100),
    maintenance_status              VARCHAR(50),
    ne_address                      VARCHAR(50),
    object_type                     VARCHAR(100),
    operation_impact_flag           VARCHAR(50),
    rru_name                        VARCHAR(100),
    received_on                     DATETIME,
    request_id                      VARCHAR(50),
    toggling_times                  VARCHAR(50),
    user_label                      VARCHAR(100),
    enodeb_id                       VARCHAR(50),
    gnodeb_id                       VARCHAR(50),
    source_system                   VARCHAR(100),
    rf_site_name                    VARCHAR(100),
    cell_name                       VARCHAR(100),
    trouble_ticket_id               VARCHAR(50),
    maintenance_region              VARCHAR(100),
    subnet                          VARCHAR(200),
    link_name                       VARCHAR(100),
    link_type                       VARCHAR(100),
    ne_virtual_mark                 VARCHAR(20),
    occurrence_notify_time          DATETIME,
    clearance_notify_time           DATETIME,

    INDEX idx_severity              (severity),
    INDEX idx_clearance_status      (clearance_status),
    INDEX idx_first_occurred        (first_occurred),
    INDEX idx_operation_impact      (operation_impact_flag),
    INDEX idx_bbu_name              (bbu_name)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Alarmes avec impact service - services réseau affectés';