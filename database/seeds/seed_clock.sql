-- ============================================================
-- Seed CLOCK : Données de test
-- Description : 10 exemples d'alarmes horloge pour les tests
-- ============================================================

USE incidents_reseau;

INSERT INTO clock (
    alarm_type, severity, alarm_source, name,
    first_occurred, cleared_on, clearance_status,
    bbu_name, ne_type, alarm_id,
    alarm_duration, maintenance_status
) VALUES
('Root alarm', 'Major',  'SIT_0101_LM', 'Clock Synchronization Lost',         '2026-02-10 08:00:00', NULL,                  'Uncleared', 'SIT_0101_LM', 'BTS3900', '25000', '--',                         'NORMAL'),
('Root alarm', 'Major',  'SIT_0102_LM', 'Clock Reference Lost',               '2026-02-11 09:30:00', '2026-02-11 10:15:00', 'Cleared',   'SIT_0102_LM', 'BTS5900', '25001', '0 hours 45 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Minor',  'SIT_0103_LM', 'Clock Degraded',                     '2026-02-12 11:00:00', '2026-02-12 11:30:00', 'Cleared',   'SIT_0103_LM', 'BTS3900', '25002', '0 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major',  'SIT_0104_LM', 'Clock Synchronization Lost',         '2026-02-13 14:00:00', NULL,                  'Uncleared', 'SIT_0104_LM', 'BTS5900', '25000', '--',                         'EXPAND'),
('Root alarm', 'Minor',  'SIT_0105_LM', 'PTP Clock Quality Degraded',         '2026-02-14 16:00:00', '2026-02-14 17:00:00', 'Cleared',   'SIT_0105_LM', 'BTS3900', '25003', '1 hours 0 minutes 0 seconds',  'NORMAL'),
('Root alarm', 'Major',  'SIT_0106_LM', 'GPS Synchronization Lost',           '2026-02-15 07:00:00', NULL,                  'Uncleared', 'SIT_0106_LM', 'BTS5900', '25004', '--',                         'NORMAL'),
('Root alarm', 'Major',  'SIT_0107_LM', 'Clock Synchronization Lost',         '2026-02-16 10:00:00', '2026-02-16 11:30:00', 'Cleared',   'SIT_0107_LM', 'BTS3900', '25000', '1 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Minor',  'SIT_0108_LM', 'Clock Degraded',                     '2026-02-17 13:00:00', '2026-02-17 13:45:00', 'Cleared',   'SIT_0108_LM', 'BTS5900', '25002', '0 hours 45 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major',  'SIT_0109_LM', 'SyncE Reference Lost',               '2026-02-18 08:00:00', NULL,                  'Uncleared', 'SIT_0109_LM', 'BTS3900', '25005', '--',                         'NORMAL'),
('Root alarm', 'Minor',  'SIT_0110_LM', 'Clock Reference Quality Degraded',   '2026-02-19 09:00:00', '2026-02-19 09:30:00', 'Cleared',   'SIT_0110_LM', 'BTS5900', '25006', '0 hours 30 minutes 0 seconds', 'NORMAL');