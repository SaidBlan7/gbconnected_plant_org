-- ============================================================
-- GBC - Carga PROVISIONAL Organización -> Región -> País -> Planta -> Línea
-- Fuente: Excel de plantas/líneas + organigrama de regiones.
-- Idempotente mediante ON CONFLICT.
-- Requiere migración de region/country/region_country aplicada.
-- ============================================================

BEGIN;

-- ADVERTENCIA: sólo ejecutar con aceptación explícita de estas inferencias.

INSERT INTO core.organization (organization_code, organization_name, is_active)
VALUES
  ('BQ', 'Bimbo Quick Service Restaurant (QSR)', TRUE)
ON CONFLICT (organization_code) DO UPDATE
SET organization_name = EXCLUDED.organization_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.country (country_code, country_name, iso_alpha2, iso_alpha3, is_active)
VALUES
  ('BRA', 'Brazil', 'BR', 'BRA', TRUE),
  ('ITA', 'Italy', 'IT', 'ITA', TRUE)
ON CONFLICT (country_code) DO UPDATE
SET country_name = EXCLUDED.country_name,
    iso_alpha2 = EXCLUDED.iso_alpha2,
    iso_alpha3 = EXCLUDED.iso_alpha3,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_BRASIL', 'QSR Brasil', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_ITALIA', 'QSR Italia', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'BRA'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_BRASIL'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'ITA'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_ITALIA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'JAGUARINA',
    'Jaguarina',
    'BRA',
    'QSR_BRASIL',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_BRASIL'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'JUIZ_DE_FORA',
    'Juiz de Fora',
    'BRA',
    'QSR_BRASIL',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_BRASIL'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'OSASCO',
    'Osasco',
    'BRA',
    'QSR_BRASIL',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_BRASIL'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'POUSO_ALEGRE',
    'Pouso Alegre',
    'BRA',
    'QSR_BRASIL',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_BRASIL'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'BOMPORTO',
    'Bomporto',
    'ITA',
    'QSR_ITALIA',
    'Europe/Rome',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_ITALIA'
JOIN core.country c
  ON c.country_code = 'ITA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'ROME',
    'Rome',
    'ITA',
    'QSR_ITALIA',
    'Europe/Rome',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_ITALIA'
JOIN core.country c
  ON c.country_code = 'ITA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BQ'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGUETTE', 'Baguette', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'JAGUARINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'JAGUARINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'JUIZ_DE_FORA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'OSASCO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'POUSO_ALEGRE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'BOMPORTO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'BOMPORTO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ROME'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ROME'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

COMMIT;
