-- ============================================================
-- Seed RTWP : Données de test
-- Description : 10 exemples d'alarmes RTWP pour les tests
-- ============================================================

USE incidents_reseau;

INSERT INTO rtwp (
    alarm_type, severity, alarm_source, name,
    first_occurred, cleared_on, clearance_status,
    bbu_name, cell_name, ne_type, alarm_id,
    alarm_duration, maintenance_status
) VALUES
('Root alarm', 'Major', 'SIT_0201_LM', 'RTWP Above Threshold', '2026-02-10 06:00:00', NULL,                  'Uncleared', 'SIT_0201_LM', 'CELL_01', 'BTS3900', '29001', '--',                         'NORMAL'),
('Root alarm', 'Major', 'SIT_0202_LM', 'RTWP Above Threshold', '2026-02-11 07:30:00', '2026-02-11 09:00:00', 'Cleared',   'SIT_0202_LM', 'CELL_02', 'BTS5900', '29001', '1 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Minor', 'SIT_0203_LM', 'RTWP Warning Level',   '2026-02-12 08:00:00', '2026-02-12 08:45:00', 'Cleared',   'SIT_0203_LM', 'CELL_03', 'BTS3900', '29002', '0 hours 45 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major', 'SIT_0204_LM', 'RTWP Above Threshold', '2026-02-13 10:00:00', NULL,                  'Uncleared', 'SIT_0204_LM', 'CELL_04', 'BTS5900', '29001', '--',                         'EXPAND'),
('Root alarm', 'Minor', 'SIT_0205_LM', 'RTWP Warning Level',   '2026-02-14 11:00:00', '2026-02-14 12:30:00', 'Cleared',   'SIT_0205_LM', 'CELL_05', 'BTS3900', '29002', '1 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major', 'SIT_0206_LM', 'RTWP Above Threshold', '2026-02-15 09:00:00', NULL,                  'Uncleared', 'SIT_0206_LM', 'CELL_06', 'BTS5900', '29001', '--',                         'NORMAL'),
('Root alarm', 'Major', 'SIT_0207_LM', 'RTWP Above Threshold', '2026-02-16 08:30:00', '2026-02-16 10:00:00', 'Cleared',   'SIT_0207_LM', 'CELL_07', 'BTS3900', '29001', '1 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Minor', 'SIT_0208_LM', 'RTWP Warning Level',   '2026-02-17 07:00:00', '2026-02-17 07:30:00', 'Cleared',   'SIT_0208_LM', 'CELL_08', 'BTS5900', '29002', '0 hours 30 minutes 0 seconds', 'NORMAL'),
('Root alarm', 'Major', 'SIT_0209_LM', 'RTWP Above Threshold', '2026-02-18 06:00:00', NULL,                  'Uncleared', 'SIT_0209_LM', 'CELL_09', 'BTS3900', '29001', '--',                         'NORMAL'),
('Root alarm', 'Minor', 'SIT_0210_LM', 'RTWP Warning Level',   '2026-02-19 05:30:00', '2026-02-19 06:00:00', 'Cleared',   'SIT_0210_LM', 'CELL_10', 'BTS5900', '29002', '0 hours 30 minutes 0 seconds', 'NORMAL');