-- ============================================================
-- Requêtes ENV - Analyses alarmes environnement
-- ============================================================

USE incidents_reseau;

-- ── 1. Nombre total d'alarmes environnement ──────────────────
SELECT COUNT(*) AS total_alarmes
FROM alarmes_environnement;

-- ── 2. Répartition par sévérité ──────────────────────────────
SELECT
    severity,
    COUNT(*) AS nombre,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM alarmes_environnement), 2) AS pourcentage
FROM alarmes_environnement
WHERE severity != 'Severity'
GROUP BY severity
ORDER BY nombre DESC;

-- ── 3. Répartition par type d'alarme ────────────────────────
SELECT
    name AS type_alarme,
    COUNT(*) AS nombre
FROM alarmes_environnement
GROUP BY name
ORDER BY nombre DESC
LIMIT 15;

-- ── 4. Top 10 sites avec le plus d'alarmes ───────────────────
SELECT
    alarm_source AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN severity = 'Major' THEN 1 ELSE 0 END) AS major,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolues
FROM alarmes_environnement
WHERE alarm_source IS NOT NULL
GROUP BY alarm_source
ORDER BY total DESC
LIMIT 10;

-- ── 5. Alarmes par mois ───────────────────────────────────────
SELECT
    DATE_FORMAT(first_occurred, '%Y-%m') AS mois,
    COUNT(*) AS nombre
FROM alarmes_environnement
WHERE first_occurred IS NOT NULL
GROUP BY mois
ORDER BY mois DESC;

-- ── 6. Alarmes non résolues ───────────────────────────────────
SELECT
    id, alarm_source, name, severity,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis
FROM alarmes_environnement
WHERE clearance_status = 'Uncleared'
ORDER BY severity DESC, first_occurred ASC;

-- ── 7. Alarmes par type (énergie, sécurité, environnement) ───
SELECT
    type AS categorie,
    COUNT(*) AS nombre
FROM alarmes_environnement
WHERE type IS NOT NULL
GROUP BY type
ORDER BY nombre DESC;

-- ── 8. Taux de résolution global ─────────────────────────────
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolues,
    ROUND(SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS taux_pct
FROM alarmes_environnement;

-- ── 9. Alarmes critiques actives (Major + Uncleared) ─────────
SELECT
    alarm_source AS site,
    name AS alarme,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_active
FROM alarmes_environnement
WHERE clearance_status = 'Uncleared'
  AND severity = 'Major'
ORDER BY first_occurred ASC;

-- ── 10. Alarmes par jour de la semaine ───────────────────────
SELECT
    DAYNAME(first_occurred) AS jour,
    COUNT(*) AS nombre
FROM alarmes_environnement
WHERE first_occurred IS NOT NULL
GROUP BY jour, DAYOFWEEK(first_occurred)
ORDER BY DAYOFWEEK(first_occurred);