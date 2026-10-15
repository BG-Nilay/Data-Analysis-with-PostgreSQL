-- 1. Count records by activity outcome
SELECT
COALESCE(pubchem_activity_outcome, 'Missing') AS activity_outcome,
COUNT(*) AS record_count
FROM pubchem.compound_activity
GROUP BY pubchem_activity_outcome
ORDER BY record_count DESC;

-- 2. Check missing values in key columns
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE pubchem_cid IS NULL) AS missing_cid,
    COUNT(*) FILTER (WHERE pubchem_sid IS NULL) AS missing_sid,
    COUNT(*) FILTER (WHERE pubchem_activity_outcome IS NULL) AS missing_outcome,
    COUNT(*) FILTER (WHERE ic50 IS NULL) AS missing_ic50
FROM pubchem.compound_activity;

-- 3. Check duplicate substance IDs
SELECT
    pubchem_sid,
    COUNT(*) AS record_count
FROM pubchem.compound_activity
GROUP BY pubchem_sid
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

-- 4. Check total records and columns
SELECT
    COUNT(*) AS total_records,
    (
        SELECT COUNT(*)
        FROM information_schema.columns
        WHERE table_schema = 'pubchem'
          AND table_name = 'compound_activity'
    ) AS total_columns
FROM pubchem.compound_activity;

-- 5. Missing values by column
SELECT
    c.column_name,
    COUNT(*) FILTER (
        WHERE (to_jsonb(t) -> c.column_name) = 'null'::jsonb
    ) AS missing_count,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE (to_jsonb(t) -> c.column_name) = 'null'::jsonb
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage
FROM pubchem.compound_activity AS t
CROSS JOIN information_schema.columns AS c
WHERE c.table_schema = 'pubchem'
  AND c.table_name = 'compound_activity'
GROUP BY c.column_name
ORDER BY missing_count DESC, c.column_name;

-- 6. Missing values report with total record count
SELECT
    c.column_name,
    COUNT(*) FILTER (
        WHERE (to_jsonb(t) -> c.column_name) = 'null'::jsonb
    ) AS missing_count,
    COUNT(*) AS total_records,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE (to_jsonb(t) -> c.column_name) = 'null'::jsonb
        ) / COUNT(*),
        2
    ) AS missing_percentage
FROM pubchem.compound_activity AS t
CROSS JOIN information_schema.columns AS c
WHERE c.table_schema = 'pubchem'
  AND c.table_name = 'compound_activity'
GROUP BY c.column_name
ORDER BY missing_percentage DESC, c.column_name;

-- 7. Analyze activity outcome distribution
SELECT
    COALESCE(pubchem_activity_outcome, 'Missing') AS activity_outcome,
    COUNT(*) AS record_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM pubchem.compound_activity
GROUP BY pubchem_activity_outcome
ORDER BY record_count DESC;

-- 8. Summarize IC50 measurements
SELECT
    COUNT(ic50) AS records_with_ic50,
    COUNT(*) FILTER (
        WHERE ic50 IS NULL
    ) AS missing_ic50,
    MIN(ic50) AS minimum_ic50,
    MAX(ic50) AS maximum_ic50,
    ROUND(AVG(ic50), 4) AS average_ic50,
    ROUND(
        (PERCENTILE_CONT(0.5)
            WITHIN GROUP (ORDER BY ic50))::numeric,
        4
    ) AS median_ic50
FROM pubchem.compound_activity;

-- 9. Check IC50 availability by activity outcome
SELECT
    pubchem_activity_outcome AS activity_outcome,
    COUNT(*) AS total_records,
    COUNT(ic50) AS records_with_ic50,
    COUNT(*) FILTER (
        WHERE ic50 IS NULL
    ) AS missing_ic50
FROM pubchem.compound_activity
GROUP BY pubchem_activity_outcome
ORDER BY pubchem_activity_outcome;

-- 10. Check duplicate compound IDs (CID)
SELECT
    pubchem_cid,
    COUNT(*) AS record_count
FROM pubchem.compound_activity
GROUP BY pubchem_cid
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

