-- ============================================================
-- Requêtes CLOCK - Analyses et statistiques horloge
-- ============================================================

USE incidents_reseau;

-- ── 1. Nombre total d'incidents horloge ──────────────────────
SELECT COUNT(*) AS total_incidents
FROM clock;

-- ── 2. Répartition par sévérité ──────────────────────────────
SELECT
    severity,
    COUNT(*) AS nombre,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clock), 2) AS pourcentage
FROM clock
WHERE severity != 'Severity'
GROUP BY severity
ORDER BY nombre DESC;

-- ── 3. Répartition par statut ─────────────────────────────────
SELECT
    clearance_status,
    COUNT(*) AS nombre
FROM clock
GROUP BY clearance_status;

-- ── 4. Top 10 sites avec le plus d'incidents horloge ─────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN severity = 'Major' THEN 1 ELSE 0 END) AS major,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolus
FROM clock
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY total DESC
LIMIT 10;

-- ── 5. Incidents par mois ─────────────────────────────────────
SELECT
    DATE_FORMAT(first_occurred, '%Y-%m') AS mois,
    COUNT(*) AS nombre
FROM clock
WHERE first_occurred IS NOT NULL
GROUP BY mois
ORDER BY mois DESC;

-- ── 6. Types d'alarmes horloge les plus fréquentes ───────────
SELECT
    name AS type_alarme,
    COUNT(*) AS nombre
FROM clock
GROUP BY name
ORDER BY nombre DESC
LIMIT 10;

-- ── 7. Incidents non résolus ──────────────────────────────────
SELECT
    id, bbu_name, name, severity,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis
FROM clock
WHERE clearance_status = 'Uncleared'
ORDER BY first_occurred ASC;

-- ── 8. Incidents par source système ──────────────────────────
SELECT
    source_system,
    COUNT(*) AS total
FROM clock
GROUP BY source_system;

-- ── 9. Incidents résolus dans la journée ─────────────────────
SELECT COUNT(*) AS resolus_24h
FROM clock
WHERE clearance_status = 'Cleared'
  AND cleared_on >= DATE_SUB(NOW(), INTERVAL 24 HOUR);

-- ── 10. Taux de résolution par site ──────────────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolus,
    ROUND(SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS taux_resolution
FROM clock
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY taux_resolution ASC
LIMIT 15;