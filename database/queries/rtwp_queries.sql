-- ============================================================
-- Requêtes RTWP - Analyses et statistiques interférences
-- ============================================================

USE incidents_reseau;

-- ── 1. Nombre total d'interférences ──────────────────────────
SELECT COUNT(*) AS total_interferences
FROM rtwp;

-- ── 2. Répartition par sévérité ──────────────────────────────
SELECT
    severity,
    COUNT(*) AS nombre,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rtwp), 2) AS pourcentage
FROM rtwp
WHERE severity != 'Severity'
GROUP BY severity
ORDER BY nombre DESC;

-- ── 3. Top 10 cellules avec le plus d'interférences ──────────
SELECT
    cell_name AS cellule,
    bbu_name AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN severity = 'Major' THEN 1 ELSE 0 END) AS major
FROM rtwp
WHERE cell_name IS NOT NULL
GROUP BY cell_name, bbu_name
ORDER BY total DESC
LIMIT 10;

-- ── 4. Interférences par mois ─────────────────────────────────
SELECT
    DATE_FORMAT(first_occurred, '%Y-%m') AS mois,
    COUNT(*) AS nombre
FROM rtwp
WHERE first_occurred IS NOT NULL
GROUP BY mois
ORDER BY mois DESC;

-- ── 5. Sites les plus affectés ────────────────────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total_interferences,
    COUNT(DISTINCT cell_name) AS cellules_affectees
FROM rtwp
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY total_interferences DESC
LIMIT 15;

-- ── 6. Interférences non résolues ────────────────────────────
SELECT
    id, bbu_name, cell_name, severity,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis
FROM rtwp
WHERE clearance_status = 'Uncleared'
  AND severity = 'Major'
ORDER BY first_occurred ASC;

-- ── 7. Taux de résolution ────────────────────────────────────
SELECT
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolues,
    SUM(CASE WHEN clearance_status = 'Uncleared' THEN 1 ELSE 0 END) AS non_resolues,
    ROUND(SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS taux_resolution
FROM rtwp;

-- ── 8. Interférences par heure de la journée ─────────────────
SELECT
    HOUR(first_occurred) AS heure,
    COUNT(*) AS nombre
FROM rtwp
WHERE first_occurred IS NOT NULL
GROUP BY heure
ORDER BY heure;

-- ── 9. Interférences récentes (7 derniers jours) ─────────────
SELECT
    bbu_name, cell_name, severity,
    first_occurred, clearance_status
FROM rtwp
WHERE first_occurred >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY first_occurred DESC;

-- ── 10. Comparaison Major vs Minor par site ───────────────────
SELECT
    bbu_name AS site,
    SUM(CASE WHEN severity = 'Major' THEN 1 ELSE 0 END) AS major,
    SUM(CASE WHEN severity = 'Minor' THEN 1 ELSE 0 END) AS minor
FROM rtwp
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY major DESC
LIMIT 10;