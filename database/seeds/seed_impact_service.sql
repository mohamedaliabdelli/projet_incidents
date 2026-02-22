-- ============================================================
-- Seed IMPACT SERVICE : Données de test
-- Description : 10 exemples d'alarmes impact service pour tests
-- ============================================================

USE incidents_reseau;

INSERT INTO impact_service (
    alarm_type, severity, alarm_source, name,
    first_occurred, cleared_on, clearance_status,
    bbu_name, cell_name, ne_type, alarm_id,
    operation_impact_flag, alarm_duration, maintenance_status
) VALUES
('Root alarm', 'Major', 'IMP_0301_LM', 'Cell Outage',              '2026-02-10 08:00:00', NULL,                  'Uncleared', 'IMP_0301_LM', 'CELL_A1', 'BTS3900', '28001', 'Yes', '--',                         'NORMAL'),
('Root alarm', 'Major', 'IMP_0302_LM', 'Sector Down',              '2026-02-11 09:00:00', '2026-02-11 11:00:00', 'Cleared',   'IMP_0302_LM', 'CELL_A2', 'BTS5900', '28002', 'Yes', '2 hours 0 minutes 0 seconds',  'NORMAL'),
('Root alarm', 'Major', 'IMP_0303_LM', 'Cell Outage',              '2026-02-12 10:00:00', NULL,                  'Uncleared', 'IMP_0303_LM', 'CELL_B1', 'BTS3900', '28001', 'Yes', '--',                         'EXPAND'),
('Root alarm', 'Major', 'IMP_0304_LM', 'RF Module Failure',        '2026-02-13 07:00:00', '2026-02-13 09:30:00', 'Cleared',   'IMP_0304_LM', 'CELL_B2', 'BTS5900', '28003', 'Yes', '2 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major', 'IMP_0305_LM', 'Baseband Failure',         '2026-02-14 11:00:00', NULL,                  'Uncleared', 'IMP_0305_LM', 'CELL_C1', 'BTS3900', '28004', 'Yes', '--',                         'NORMAL'),
('Root alarm', 'Major', 'IMP_0306_LM', 'Transport Link Down',      '2026-02-15 06:00:00', '2026-02-15 08:00:00', 'Cleared',   'IMP_0306_LM', 'CELL_C2', 'BTS5900', '28005', 'Yes', '2 hours 0 minutes 0 seconds',  'NORMAL'),
('Root alarm', 'Major', 'IMP_0307_LM', 'Cell Outage',              '2026-02-16 09:00:00', NULL,                  'Uncleared', 'IMP_0307_LM', 'CELL_D1', 'BTS3900', '28001', 'Yes', '--',                         'NORMAL'),
('Root alarm', 'Major', 'IMP_0308_LM', 'Power Amplifier Fault',    '2026-02-17 10:00:00', '2026-02-17 12:00:00', 'Cleared',   'IMP_0308_LM', 'CELL_D2', 'BTS5900', '28006', 'Yes', '2 hours 0 minutes 0 seconds',  'NORMAL'),
('Root alarm', 'Major', 'IMP_0309_LM', 'Cell Outage',              '2026-02-18 08:00:00', NULL,                  'Uncleared', 'IMP_0309_LM', 'CELL_E1', 'BTS3900', '28001', 'Yes', '--',                         'NORMAL'),
('Root alarm', 'Major', 'IMP_0310_LM', 'Sector Down',              '2026-02-19 07:00:00', NULL,                  'Uncleared', 'IMP_0310_LM', 'CELL_E2', 'BTS5900', '28002', 'Yes', '--',                         'NORMAL');