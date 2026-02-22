-- ============================================================
-- Requêtes VSWR - Analyses et statistiques
-- ============================================================

USE incidents_reseau;

-- ── 1. Nombre total d'incidents ──────────────────────────────
SELECT COUNT(*) AS total_incidents
FROM vswr;

-- ── 2. Répartition par sévérité ──────────────────────────────
SELECT
    severity,
    COUNT(*) AS nombre,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vswr), 2) AS pourcentage
FROM vswr
WHERE severity != 'Severity'
GROUP BY severity
ORDER BY nombre DESC;

-- ── 3. Répartition par statut ─────────────────────────────────
SELECT
    clearance_status,
    COUNT(*) AS nombre
FROM vswr
GROUP BY clearance_status;

-- ── 4. Top 10 sites avec le plus d'incidents ─────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN severity = 'Major' THEN 1 ELSE 0 END) AS major,
    SUM(CASE WHEN severity = 'Minor' THEN 1 ELSE 0 END) AS minor
FROM vswr
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY total DESC
LIMIT 10;

-- ── 5. Incidents par mois ─────────────────────────────────────
SELECT
    DATE_FORMAT(first_occurred, '%Y-%m') AS mois,
    COUNT(*) AS nombre
FROM vswr
WHERE first_occurred IS NOT NULL
GROUP BY mois
ORDER BY mois DESC;

-- ── 6. Incidents non résolus (Uncleared) ─────────────────────
SELECT
    id, bbu_name, rru_name, severity,
    first_occurred, alarm_duration
FROM vswr
WHERE clearance_status = 'Uncleared'
ORDER BY first_occurred DESC;

-- ── 7. Durée moyenne des incidents résolus ────────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS incidents_resolus,
    alarm_duration
FROM vswr
WHERE clearance_status = 'Cleared'
GROUP BY bbu_name, alarm_duration
ORDER BY incidents_resolus DESC
LIMIT 20;

-- ── 8. Incidents par type de NE ──────────────────────────────
SELECT
    ne_type,
    COUNT(*) AS total,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolus
FROM vswr
GROUP BY ne_type;

-- ── 9. Incidents du dernier mois ─────────────────────────────
SELECT *
FROM vswr
WHERE first_occurred >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
ORDER BY first_occurred DESC;

-- ── 10. Incidents critiques non résolus depuis plus de 24h ───
SELECT
    id, bbu_name, rru_name, severity,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis
FROM vswr
WHERE clearance_status = 'Uncleared'
  AND severity = 'Major'
  AND first_occurred < DATE_SUB(NOW(), INTERVAL 24 HOUR)
ORDER BY first_occurred ASC;