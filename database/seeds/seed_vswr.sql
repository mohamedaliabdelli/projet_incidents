-- ============================================================
-- Seed VSWR : Données de test
-- Description : 10 exemples d'alarmes VSWR pour les tests
-- ============================================================

USE incidents_reseau;

INSERT INTO vswr (
    alarm_type, severity, alarm_source, name,
    first_occurred, cleared_on, clearance_status,
    bbu_name, rru_name, ne_type, alarm_id,
    alarm_duration, maintenance_status
) VALUES
('Root alarm', 'Major',  'TUN_0165_BO_RO', 'RF Unit VSWR Threshold Crossed', '2026-02-18 11:38:53', NULL,                  'Uncleared', 'TUN_0165_BO_RO', NULL,    'BTS3900', '26529', '--',                        'NORMAL'),
('Root alarm', 'Major',  'TUN_0165_BO_RO', 'RF Unit VSWR Threshold Crossed', '2026-02-18 11:37:35', NULL,                  'Uncleared', 'TUN_0165_BO_RO', 'RRU62', 'BTS3900', '26529', '--',                        'NORMAL'),
('Root alarm', 'Minor',  'ARI_0056_LM',    'RF Unit VSWR Threshold Crossed', '2026-02-18 11:39:41', '2026-02-18 11:40:14', 'Cleared',   'ARI_0056_LM',    'RRU22', 'BTS5900', '26529', '0 hours 0 minutes 33 seconds', 'NORMAL'),
('Root alarm', 'Minor',  'ARI_0056_LM',    'RF Unit VSWR Threshold Crossed', '2026-02-18 11:23:25', '2026-02-18 11:38:27', 'Cleared',   'ARI_0056_LM',    'RRU22', 'BTS5900', '26529', '0 hours 15 minutes 2 seconds', 'NORMAL'),
('Root alarm', 'Major',  'TUN_0165_BO_RO', 'RF Unit VSWR Threshold Crossed', '2026-02-18 11:28:53', '2026-02-18 11:38:53', 'Cleared',   'TUN_0165_BO_RO', NULL,    'BTS3900', '26529', '0 hours 10 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major',  'TUN_0165_BO_RO', 'RF Unit VSWR Threshold Crossed', '2026-02-18 11:26:53', '2026-02-18 11:28:53', 'Cleared',   'TUN_0165_BO_RO', NULL,    'BTS3900', '26529', '0 hours 2 minutes 0 seconds',  'NORMAL'),
('Root alarm', 'Major',  'NAB_0182_LM',    'RF Unit VSWR Threshold Crossed', '2025-07-10 14:29:35', NULL,                  'Uncleared', 'NAB_0182_LM',    'RRU92', 'BTS3900', '26529', '--',                        'EXPAND'),
('Root alarm', 'Major',  'TUN_0280_BO_TR', 'RF Unit VSWR Threshold Crossed', '2025-07-23 13:50:41', NULL,                  'Uncleared', 'TUN_0280_BO_TR', 'RRU63', 'BTS3900', '26529', '--',                        'NORMAL'),
('Root alarm', 'Minor',  'SIT_0010_LM',    'RF Unit VSWR Threshold Crossed', '2026-01-15 09:12:00', '2026-01-15 09:45:00', 'Cleared',   'SIT_0010_LM',    'RRU01', 'BTS5900', '26529', '0 hours 33 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major',  'KAS_0033_LM',    'RF Unit VSWR Threshold Crossed', '2026-01-20 14:00:00', NULL,                  'Uncleared', 'KAS_0033_LM',    'RRU11', 'BTS3900', '26529', '--',                        'NORMAL');