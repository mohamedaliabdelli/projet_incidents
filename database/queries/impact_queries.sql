-- ============================================================
-- Requêtes IMPACT SERVICE - Analyses et statistiques
-- ============================================================

USE incidents_reseau;

-- ── 1. Nombre total d'incidents avec impact service ──────────
SELECT COUNT(*) AS total_incidents
FROM impact_service;

-- ── 2. Répartition par sévérité ──────────────────────────────
SELECT
    severity,
    COUNT(*) AS nombre,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM impact_service), 2) AS pourcentage
FROM impact_service
WHERE severity != 'Severity'
GROUP BY severity
ORDER BY nombre DESC;

-- ── 3. Répartition par statut ─────────────────────────────────
SELECT
    clearance_status,
    COUNT(*) AS nombre
FROM impact_service
GROUP BY clearance_status;

-- ── 4. Top 10 sites les plus impactés ────────────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total,
    COUNT(DISTINCT cell_name) AS cellules_impactees,
    SUM(CASE WHEN clearance_status = 'Uncleared' THEN 1 ELSE 0 END) AS actifs
FROM impact_service
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY total DESC
LIMIT 10;

-- ── 5. Types d'alarmes les plus fréquentes ───────────────────
SELECT
    name AS type_alarme,
    COUNT(*) AS nombre,
    SUM(CASE WHEN clearance_status = 'Uncleared' THEN 1 ELSE 0 END) AS actifs
FROM impact_service
GROUP BY name
ORDER BY nombre DESC
LIMIT 10;

-- ── 6. Incidents par mois ─────────────────────────────────────
SELECT
    DATE_FORMAT(first_occurred, '%Y-%m') AS mois,
    COUNT(*) AS nombre,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolus
FROM impact_service
WHERE first_occurred IS NOT NULL
GROUP BY mois
ORDER BY mois DESC;

-- ── 7. Incidents actifs avec impact opérationnel ─────────────
SELECT
    id, bbu_name, cell_name, name,
    severity, first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis,
    operation_impact_flag
FROM impact_service
WHERE clearance_status = 'Uncleared'
  AND operation_impact_flag = 'Yes'
ORDER BY first_occurred ASC;

-- ── 8. Taux de résolution par site ────────────────────────────
SELECT
    bbu_name AS site,
    COUNT(*) AS total,
    SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) AS resolus,
    ROUND(SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS taux_resolution
FROM impact_service
WHERE bbu_name IS NOT NULL
GROUP BY bbu_name
ORDER BY taux_resolution ASC
LIMIT 15;

-- ── 9. Incidents non résolus depuis plus de 24h ───────────────
SELECT
    id, bbu_name, cell_name, name, severity,
    first_occurred,
    TIMESTAMPDIFF(HOUR, first_occurred, NOW()) AS heures_depuis
FROM impact_service
WHERE clearance_status = 'Uncleared'
  AND first_occurred < DATE_SUB(NOW(), INTERVAL 24 HOUR)
ORDER BY first_occurred ASC;

-- ── 10. Résumé global impact service ─────────────────────────
SELECT
    COUNT(*)                                                                        AS total,
    SUM(CASE WHEN clearance_status = 'Cleared'   THEN 1 ELSE 0 END)                AS resolus,
    SUM(CASE WHEN clearance_status = 'Uncleared' THEN 1 ELSE 0 END)                AS actifs,
    SUM(CASE WHEN severity = 'Major'             THEN 1 ELSE 0 END)                AS major,
    SUM(CASE WHEN severity = 'Minor'             THEN 1 ELSE 0 END)                AS minor,
    SUM(CASE WHEN operation_impact_flag = 'Yes'  THEN 1 ELSE 0 END)                AS impact_operationnel,
    ROUND(SUM(CASE WHEN clearance_status = 'Cleared' THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 1)                                                            AS taux_resolution_pct
FROM impact_service;