-- ============================================================
-- GBC - Carga Organización -> Región -> País -> Planta -> Línea
-- Fuente: Excel de plantas/líneas + organigrama de regiones.
-- Idempotente mediante ON CONFLICT.
-- Requiere migración de region/country/region_country aplicada.
-- ============================================================

BEGIN;

-- 1) ORGANIZACIONES
INSERT INTO core.organization (organization_code, organization_name, is_active)
VALUES
  ('ASIA', 'Asia', TRUE),
  ('BB', 'Bimbo Brasil', TRUE),
  ('BBU', 'Bimbo Bakeries USA', TRUE),
  ('BC', 'Bimbo Canada', TRUE),
  ('BL', 'Barcel', TRUE),
  ('BM', 'Bimbo Mexico', TRUE),
  ('BQ', 'Bimbo Quick Service Restaurant (QSR)', TRUE),
  ('EMEA', 'Europe, middle east and africa', TRUE),
  ('LAC', 'Latinoamérica Centro', TRUE),
  ('LAS', 'Latinoamérica Sur', TRUE)
ON CONFLICT (organization_code) DO UPDATE
SET organization_name = EXCLUDED.organization_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- 2) PAÍSES
INSERT INTO core.country (country_code, country_name, iso_alpha2, iso_alpha3, is_active)
VALUES
  ('ARG', 'Argentina', 'AR', 'ARG', TRUE),
  ('BRA', 'Brazil', 'BR', 'BRA', TRUE),
  ('CAN', 'Canada', 'CA', 'CAN', TRUE),
  ('CHL', 'Chile', 'CL', 'CHL', TRUE),
  ('CHN', 'China', 'CN', 'CHN', TRUE),
  ('COL', 'Colombia', 'CO', 'COL', TRUE),
  ('CRI', 'Costa Rica', 'CR', 'CRI', TRUE),
  ('HRV', 'Croacia', 'HR', 'HRV', TRUE),
  ('SLV', 'El Salvador', 'SV', 'SLV', TRUE),
  ('SVN', 'Eslovenia', 'SI', 'SVN', TRUE),
  ('FRA', 'France', 'FR', 'FRA', TRUE),
  ('GTM', 'Guatemala', 'GT', 'GTM', TRUE),
  ('HND', 'Honduras', 'HN', 'HND', TRUE),
  ('IND', 'India', 'IN', 'IND', TRUE),
  ('KAZ', 'Kazakhstan', 'KZ', 'KAZ', TRUE),
  ('KOR', 'Korea', 'KR', 'KOR', TRUE),
  ('MEX', 'Mexico', 'MX', 'MEX', TRUE),
  ('MNE', 'Montenegro', 'ME', 'MNE', TRUE),
  ('MAR', 'Morocco', 'MA', 'MAR', TRUE),
  ('PAN', 'Panama', 'PA', 'PAN', TRUE),
  ('PRY', 'Paraguay', 'PY', 'PRY', TRUE),
  ('PER', 'Peru', 'PE', 'PER', TRUE),
  ('PRT', 'Portugal', 'PT', 'PRT', TRUE),
  ('ROU', 'Romania', 'RO', 'ROU', TRUE),
  ('RUS', 'Russia', 'RU', 'RUS', TRUE),
  ('SRB', 'Serbia', 'RS', 'SRB', TRUE),
  ('ZAF', 'South Africa', 'ZA', 'ZAF', TRUE),
  ('ESP', 'Spain', 'ES', 'ESP', TRUE),
  ('CHE', 'Switzerland', 'CH', 'CHE', TRUE),
  ('TUN', 'Tunisia', 'TN', 'TUN', TRUE),
  ('TUR', 'Turkey', 'TR', 'TUR', TRUE),
  ('UKR', 'Ukraine', 'UA', 'UKR', TRUE),
  ('GBR', 'United Kingdom', 'GB', 'GBR', TRUE),
  ('USA', 'United States', 'US', 'USA', TRUE),
  ('URY', 'Uruguay', 'UY', 'URY', TRUE),
  ('VEN', 'Venezuela', 'VE', 'VEN', TRUE)
ON CONFLICT (country_code) DO UPDATE
SET country_name = EXCLUDED.country_name,
    iso_alpha2 = EXCLUDED.iso_alpha2,
    iso_alpha3 = EXCLUDED.iso_alpha3,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- 3) REGIONES
INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BCN', 'Bimbo China', TRUE
FROM core.organization
WHERE organization_code = 'ASIA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BIN', 'Bimbo India', TRUE
FROM core.organization
WHERE organization_code = 'ASIA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BB', 'Bimbo Brasil', TRUE
FROM core.organization
WHERE organization_code = 'BB'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BBU', 'Bimbo Bakeries USA', TRUE
FROM core.organization
WHERE organization_code = 'BBU'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BC', 'Bimbo Canada', TRUE
FROM core.organization
WHERE organization_code = 'BC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BL', 'Barcel México', TRUE
FROM core.organization
WHERE organization_code = 'BL'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BLU', 'Barcel USA', TRUE
FROM core.organization
WHERE organization_code = 'BL'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BM', 'Bimbo México', TRUE
FROM core.organization
WHERE organization_code = 'BM'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_CHINA', 'QSR China', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_COREA_SUR', 'QSR Corea del Sur', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_FRANCIA', 'QSR Francia', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_KAZAJISTAN', 'QSR Kazajistán', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_RUSIA', 'QSR Rusia', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_SUDAFRICA', 'QSR Sudáfrica', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_SUIZA', 'QSR Suiza', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_TURQUIA', 'QSR Turquía', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_UCRANIA', 'QSR Ucrania', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'QSR_USA', 'QSR Estados Unidos', TRUE
FROM core.organization
WHERE organization_code = 'BQ'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BBA', 'Bimbo Adria', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BI', 'Bimbo Iberia', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BMA', 'Bimbo Marruecos', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BRU', 'Bimbo Rumania', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BTN', 'Bimbo Túnez', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BUK', 'Bimbo UK', TRUE
FROM core.organization
WHERE organization_code = 'EMEA'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BCO', 'Bimbo Colombia', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BCR', 'Bimbo Costa Rica', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BES', 'Bimbo El Salvador', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BGU', 'Bimbo Guatemala', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BHO', 'Bimbo Honduras', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BPA', 'Bimbo Panamá', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BVE', 'Bimbo Venezuela', TRUE
FROM core.organization
WHERE organization_code = 'LAC'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BA', 'Bimbo Argentina', TRUE
FROM core.organization
WHERE organization_code = 'LAS'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BP', 'Bimbo Perú', TRUE
FROM core.organization
WHERE organization_code = 'LAS'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BPR', 'Bimbo Paraguay', TRUE
FROM core.organization
WHERE organization_code = 'LAS'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'BU', 'Bimbo Uruguay', TRUE
FROM core.organization
WHERE organization_code = 'LAS'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region (organization_id, region_code, region_name, is_active)
SELECT organization_id, 'IDEAL', 'Bimbo Chile / Ideal', TRUE
FROM core.organization
WHERE organization_code = 'LAS'
ON CONFLICT (organization_id, region_code) DO UPDATE
SET region_name = EXCLUDED.region_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- 4) REGION_COUNTRY
INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CHN'
WHERE o.organization_code = 'ASIA'
  AND r.region_code = 'BCN'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'IND'
WHERE o.organization_code = 'ASIA'
  AND r.region_code = 'BIN'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'BRA'
WHERE o.organization_code = 'BB'
  AND r.region_code = 'BB'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'USA'
WHERE o.organization_code = 'BBU'
  AND r.region_code = 'BBU'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CAN'
WHERE o.organization_code = 'BC'
  AND r.region_code = 'BC'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'MEX'
WHERE o.organization_code = 'BL'
  AND r.region_code = 'BL'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'USA'
WHERE o.organization_code = 'BL'
  AND r.region_code = 'BLU'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'MEX'
WHERE o.organization_code = 'BM'
  AND r.region_code = 'BM'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CHN'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_CHINA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'FRA'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_FRANCIA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'KAZ'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_KAZAJISTAN'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'KOR'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_COREA_SUR'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'RUS'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_RUSIA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'ZAF'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_SUDAFRICA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CHE'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_SUIZA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'TUR'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_TURQUIA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'UKR'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_UCRANIA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'USA'
WHERE o.organization_code = 'BQ'
  AND r.region_code = 'QSR_USA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'HRV'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BBA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'SVN'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BBA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'MNE'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BBA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'MAR'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BMA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'PRT'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BI'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'ROU'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BRU'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'SRB'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BBA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'ESP'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BI'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'TUN'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BTN'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'GBR'
WHERE o.organization_code = 'EMEA'
  AND r.region_code = 'BUK'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'COL'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BCO'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CRI'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BCR'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'SLV'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BES'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'GTM'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BGU'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'HND'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BHO'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'PAN'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BPA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'VEN'
WHERE o.organization_code = 'LAC'
  AND r.region_code = 'BVE'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'ARG'
WHERE o.organization_code = 'LAS'
  AND r.region_code = 'BA'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'CHL'
WHERE o.organization_code = 'LAS'
  AND r.region_code = 'IDEAL'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'PRY'
WHERE o.organization_code = 'LAS'
  AND r.region_code = 'BPR'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'PER'
WHERE o.organization_code = 'LAS'
  AND r.region_code = 'BP'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.region_country (region_id, country_id, is_active)
SELECT r.region_id, c.country_id, TRUE
FROM core.region r
JOIN core.organization o ON o.organization_id = r.organization_id
JOIN core.country c ON c.country_code = 'URY'
WHERE o.organization_code = 'LAS'
  AND r.region_code = 'BU'
ON CONFLICT (region_id, country_id) DO UPDATE
SET is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- 5) PLANTAS
INSERT INTO core.plant (
    organization_id, plant_code, plant_name,
    country_code, region_code, timezone_name,
    region_country_id, is_active
)
SELECT
    o.organization_id,
    'BJ_MANKATTAN_BEIJING',
    'BJ / Mankattan Beijing',
    'CHN',
    'BCN',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCN'
JOIN core.country c
  ON c.country_code = 'CHN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'SH_MANKATTAN_SHANGHAI',
    'SH / Mankattan Shanghai',
    'CHN',
    'BCN',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCN'
JOIN core.country c
  ON c.country_code = 'CHN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'BANGALORE',
    'Bangalore',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'CHENNAI',
    'Chennai',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'DEWAS',
    'Dewas',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'HYDERABAD_2',
    'Hyderabad 2',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'KHEDA',
    'Kheda',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'KITY',
    'Kity',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'KOCHI',
    'Kochi',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'KOLKATA',
    'Kolkata',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'MUMBAI',
    'Mumbai',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'NOIDA',
    'Noida',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'SARE_KHURD_1',
    'Sare Khurd 1',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'SARE_KHURD_2',
    'Sare Khurd 2',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'SONIPAT',
    'Sonipat',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'TAPUKARA',
    'Tapukara',
    'IND',
    'BIN',
    'Asia/Kolkata',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BIN'
JOIN core.country c
  ON c.country_code = 'IND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'ASIA'
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
    'BRASILIA_BBB',
    'Brasilia / BBB',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'DIADEMA',
    'Diadema',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'GUARAPUAVA',
    'Guarapuava',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'HORTOLANDIA',
    'Hortolandia',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'JACAREPAGUA',
    'Jacarepagua',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'PORTO_ALEGRE_BBPA',
    'Porto Alegre / BBPA',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'RECIFE_BBR',
    'Recife / BBR',
    'BRA',
    'BB',
    'America/Recife',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'RIO_DE_JANEIRO_BBRJ',
    'Río de Janeiro / BBRJ',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'SAO_PAULO_1_BBSP1',
    'São Paulo 1 / BBSP1',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'SAO_PAULO_2_BBSP2',
    'São Paulo 2 / BBSP2',
    'BRA',
    'BB',
    'America/Sao_Paulo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BB'
JOIN core.country c
  ON c.country_code = 'BRA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BB'
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
    'ALBANY_BREAD',
    'Albany Bread',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ALBANY_CAKE',
    'Albany Cake',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ARLINGTON',
    'Arlington',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ATLANTA',
    'Atlanta',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'BEAVERTON',
    'Beaverton',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'CARLISLE',
    'Carlisle',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'CHICAGO',
    'Chicago',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'CICERO',
    'Cicero',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'COMMERCE_CITY',
    'Commerce City',
    'USA',
    'BBU',
    'America/Denver',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'DENVER',
    'Denver',
    'USA',
    'BBU',
    'America/Denver',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'DUBUQUE',
    'Dubuque',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ELKHART',
    'Elkhart',
    'USA',
    'BBU',
    'America/Indiana/Indianapolis',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'EMMYS_ORGANIC_S',
    'Emmys Organic´s',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ESCONDIDO',
    'Escondido',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'FERGUS_FALLS',
    'Fergus Falls',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'FORTH_WORTH',
    'Forth Worth',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'FREDERICK',
    'Frederick',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'GASTONIA',
    'Gastonia',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'GRAND_PRAIRIE',
    'Grand Prairie',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'GRAND_RAPIDS',
    'Grand Rapids',
    'USA',
    'BBU',
    'America/Detroit',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'GREENWICH',
    'Greenwich',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'HAZLETON',
    'Hazleton',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'HAZLETON_CAKE',
    'Hazleton Cake',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'HOUSTON',
    'Houston',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'HUNTINGTON',
    'Huntington',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'KENT',
    'Kent',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'LACROSSE',
    'LaCrosse',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'LEHIGH_VALLEY',
    'Lehigh Valley',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'LENDERS_BAGEL_MATTOON',
    'Lenders Bagel - Mattoon',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'LONDON',
    'London',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'MERIDIAN',
    'Meridian',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'MONTEBELLO',
    'Montebello',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'NORTHUMBERLAND',
    'Northumberland',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'OCONOMOWOC',
    'Oconomowoc',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'OKLAHOMA_CITY',
    'Oklahoma City',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ORANGEBURG',
    'Orangeburg',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ORLANDO',
    'Orlando',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'OXNARD',
    'Oxnard',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'PHOENIX',
    'Phoenix',
    'USA',
    'BBU',
    'America/Phoenix',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'PLANCENTIA',
    'Plancentia',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'READING',
    'Reading',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'RIVIERA_BEACH',
    'Riviera Beach',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ROANOKE',
    'Roanoke',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ROCKWALL',
    'Rockwall',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'ROSEVILLE',
    'Roseville',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'S_SAN_FRANCISCO',
    'S. San Francisco',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'SACRAMENTO',
    'Sacramento',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'SALT_LAKE_CITY',
    'Salt Lake City',
    'USA',
    'BBU',
    'America/Denver',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'SAN_LUIS_OBISPO',
    'San Luis Obispo',
    'USA',
    'BBU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'SAYRE',
    'Sayre',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'SOUTH_ST_PAUL',
    'South St. Paul',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'TOPEKA',
    'Topeka',
    'USA',
    'BBU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'VALDESE',
    'Valdese',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'WILLIAMSPORT',
    'Williamsport',
    'USA',
    'BBU',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BBU'
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
    'CALGARY',
    'Calgary',
    'CAN',
    'BC',
    'America/Edmonton',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'DANDURAND',
    'Dandurand',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'EDMONTON',
    'Edmonton',
    'CAN',
    'BC',
    'America/Edmonton',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'HAMILTON',
    'Hamilton',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'LANGLEY',
    'Langley',
    'CAN',
    'BC',
    'America/Vancouver',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'LAVAL',
    'Laval',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'MONCTON',
    'Moncton',
    'CAN',
    'BC',
    'America/Moncton',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'NATURAL_BAKERY',
    'Natural bakery',
    'CAN',
    'BC',
    'America/Winnipeg',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'RIVERMEDE',
    'Rivermede',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'ST_JOHNS',
    'St. Johns',
    'CAN',
    'BC',
    'America/St_Johns',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'STONEMILL',
    'Stonemill',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'TRILLIUM',
    'Trillium',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'VACHON',
    'Vachon',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'VIAU_PLANT',
    'Viau Plant',
    'CAN',
    'BC',
    'America/Toronto',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'WINNIPEG',
    'Winnipeg',
    'CAN',
    'BC',
    'America/Winnipeg',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BC'
JOIN core.country c
  ON c.country_code = 'CAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BC'
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
    'BARCEL_ATITALAQUIA_BLA',
    'Barcel Atitalaquia / BLA',
    'MEX',
    'BL',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_LAGUNA_BLN',
    'Barcel Laguna / BLN',
    'MEX',
    'BL',
    'America/Monterrey',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_LERMA_BLM',
    'Barcel Lerma / BLM',
    'MEX',
    'BL',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_MEXICALLI_BLX',
    'Barcel Mexicalli/BLX',
    'MEX',
    'BL',
    'America/Tijuana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_MONTERREY_BLMT',
    'Barcel Monterrey/BLMT',
    'MEX',
    'BL',
    'America/Monterrey',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_MERIDA_BLY',
    'Barcel Mérida/BLY',
    'MEX',
    'BL',
    'America/Merida',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BARCEL_OCCIDENTE_BLO',
    'Barcel Occidente/BLO',
    'MEX',
    'BL',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BL'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'COPPELL_USA_BLUSA',
    'Coppell USA / BLUSA',
    'USA',
    'BLU',
    'America/Chicago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BLU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'POPCORNOPOLIS_BLUSA',
    'Popcornopolis /BLUSA',
    'USA',
    'BLU',
    'America/Los_Angeles',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BLU'
JOIN core.country c
  ON c.country_code = 'USA'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BL'
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
    'BIMBO_CENTRO_BC',
    'Bimbo Centro / BC',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_CHIHUAHUA_BCH',
    'Bimbo Chihuahua / BCH',
    'MEX',
    'BM',
    'America/Chihuahua',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_GOLFO_BG',
    'Bimbo Golfo /BG',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_HERMOSILLO_BW',
    'Bimbo Hermosillo / BW',
    'MEX',
    'BM',
    'America/Hermosillo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_MAZATLAN_BP',
    'Bimbo Mazatlán / BP',
    'MEX',
    'BM',
    'America/Mazatlan',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_MEXICALI_BBC',
    'Bimbo Mexicali /BBC',
    'MEX',
    'BM',
    'America/Tijuana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_MERIDA_BY',
    'Bimbo Mérida / BY',
    'MEX',
    'BM',
    'America/Merida',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_MEXICO_AZCAPOTZALCO_BMA',
    'Bimbo México Azcapotzalco / BMA',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_MEXICO_SANTA_MARIA_BMS',
    'Bimbo México Santa María /BMS',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_NORTE_BN',
    'Bimbo Norte / BN',
    'MEX',
    'BM',
    'America/Monterrey',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_OCCIDENTE_BO',
    'Bimbo Occidente / BO',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_PUEBLA_BPU',
    'Bimbo Puebla / BPU',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_PUEBLA_2_BPU2',
    'Bimbo Puebla 2 / BPU2',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_SAN_LUIS_BSL',
    'Bimbo San Luis / BSL',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_SURESTE_BS',
    'Bimbo Sureste / BS',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_TIJUANA_BTI',
    'Bimbo Tijuana /BTI',
    'MEX',
    'BM',
    'America/Tijuana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BIMBO_TOLUCA_BT',
    'Bimbo Toluca / BT',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'EL_GLOBO_EGL',
    'El Globo / EGL',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'GALLETAS_GABI_GG',
    'Galletas Gabi / GG',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'HAZPAN_HP',
    'Hazpan /HP',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'JULITAS_JUL',
    'Julitas / JUL',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'MARINELA_MEXICO_MM',
    'Marinela México / MM',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'MARINELA_NORTE_MN',
    'Marinela Norte / MN',
    'MEX',
    'BM',
    'America/Monterrey',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'MARINELA_NORTE_2',
    'Marinela Norte 2',
    'MEX',
    'BM',
    'America/Monterrey',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'MARINELA_OCCIDENTE_MO',
    'Marinela Occidente / MO',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'PLANTA_QUERETARO',
    'Planta Querétaro',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'SANISSIMO_SS',
    'Sanissimo /SS',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'SUANDY_MEXICO_SM',
    'Suandy México / SM',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'TEPEJI_TPJ',
    'Tepeji / TPJ',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'TIA_ROSA_TR',
    'Tía Rosa / TR',
    'MEX',
    'BM',
    'America/Mexico_City',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BM'
JOIN core.country c
  ON c.country_code = 'MEX'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'BM'
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
    'BEIJING_BQBJ',
    'Beijing / BQBJ',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'HANGZHOU_BQHZ',
    'Hangzhou / BQHZ',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'SHANGHAI_BQSH',
    'Shanghai / BQSH',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'SHENYANG_BQSY',
    'Shenyang / BQSY',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'SICHUAN_MANKATTAN_CHENGDU_BQCD',
    'Sichuan Mankattan (ChengDu) / BQCD',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'TIANJIN_BQTJ',
    'Tianjin / BQTJ',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'XIAOGAN',
    'Xiaogan',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'ZHONGSHAN',
    'Zhongshan',
    'CHN',
    'QSR_CHINA',
    'Asia/Shanghai',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_CHINA'
JOIN core.country c
  ON c.country_code = 'CHN'
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
    'AIX',
    'Aix',
    'FRA',
    'QSR_FRANCIA',
    'Europe/Paris',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_FRANCIA'
JOIN core.country c
  ON c.country_code = 'FRA'
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
    'BQ_CHATELLERAULT',
    'BQ Chatellerault',
    'FRA',
    'QSR_FRANCIA',
    'Europe/Paris',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_FRANCIA'
JOIN core.country c
  ON c.country_code = 'FRA'
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
    'FLEURY',
    'Fleury',
    'FRA',
    'QSR_FRANCIA',
    'Europe/Paris',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_FRANCIA'
JOIN core.country c
  ON c.country_code = 'FRA'
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
    'PLESSIS',
    'Plessis',
    'FRA',
    'QSR_FRANCIA',
    'Europe/Paris',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_FRANCIA'
JOIN core.country c
  ON c.country_code = 'FRA'
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
    'KAZAJISTAN',
    'Kazajistán',
    'KAZ',
    'QSR_KAZAJISTAN',
    'Asia/Almaty',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_KAZAJISTAN'
JOIN core.country c
  ON c.country_code = 'KAZ'
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
    'SOUTH_KOREA_BQSK',
    'South Korea / BQSK',
    'KOR',
    'QSR_COREA_SUR',
    'Asia/Seoul',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_COREA_SUR'
JOIN core.country c
  ON c.country_code = 'KOR'
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
    'MOSCOW',
    'Moscow',
    'RUS',
    'QSR_RUSIA',
    'Europe/Moscow',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_RUSIA'
JOIN core.country c
  ON c.country_code = 'RUS'
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
    'CAPETOWN',
    'Capetown',
    'ZAF',
    'QSR_SUDAFRICA',
    'Africa/Johannesburg',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_SUDAFRICA'
JOIN core.country c
  ON c.country_code = 'ZAF'
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
    'PRETORIA',
    'Pretoria',
    'ZAF',
    'QSR_SUDAFRICA',
    'Africa/Johannesburg',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_SUDAFRICA'
JOIN core.country c
  ON c.country_code = 'ZAF'
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
    'SWITZERLAND',
    'Switzerland',
    'CHE',
    'QSR_SUIZA',
    'Europe/Zurich',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_SUIZA'
JOIN core.country c
  ON c.country_code = 'CHE'
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
    'TURKEY',
    'Turkey',
    'TUR',
    'QSR_TURQUIA',
    'Europe/Istanbul',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_TURQUIA'
JOIN core.country c
  ON c.country_code = 'TUR'
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
    'UKRAINE',
    'Ukraine',
    'UKR',
    'QSR_UCRANIA',
    'Europe/Kyiv',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_UCRANIA'
JOIN core.country c
  ON c.country_code = 'UKR'
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
    'AIRPORT_OH',
    'Airport (OH)',
    'USA',
    'QSR_USA',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_USA'
JOIN core.country c
  ON c.country_code = 'USA'
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
    'DENVER',
    'Denver',
    'USA',
    'QSR_USA',
    'America/Denver',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_USA'
JOIN core.country c
  ON c.country_code = 'USA'
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
    'EAST_POINTE_OH',
    'East Pointe (OH)',
    'USA',
    'QSR_USA',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_USA'
JOIN core.country c
  ON c.country_code = 'USA'
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
    'VALDOSTA',
    'Valdosta',
    'USA',
    'QSR_USA',
    'America/New_York',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'QSR_USA'
JOIN core.country c
  ON c.country_code = 'USA'
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
    'DONJA_ZELINA',
    'Donja Zelina',
    'HRV',
    'BBA',
    'Europe/Zagreb',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'HRV'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'GROSUPLJE',
    'Grosuplje',
    'SVN',
    'BBA',
    'Europe/Ljubljana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SVN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KRANJ_1',
    'Kranj 1',
    'SVN',
    'BBA',
    'Europe/Ljubljana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SVN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KRANJ_2',
    'Kranj 2',
    'SVN',
    'BBA',
    'Europe/Ljubljana',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SVN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'DANILOVGRAD_SPUZ',
    'DANILOVGRAD/Spuz',
    'MNE',
    'BBA',
    'Europe/Podgorica',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'MNE'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'CASABLANCA',
    'Casablanca',
    'MAR',
    'BMA',
    'Africa/Casablanca',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BMA'
JOIN core.country c
  ON c.country_code = 'MAR'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'ALBERGARIA',
    'Albergaria',
    'PRT',
    'BI',
    'Europe/Lisbon',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'PRT'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'SINTRA',
    'Sintra',
    'PRT',
    'BI',
    'Europe/Lisbon',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'PRT'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'BRAILA',
    'Braila',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'BRASOV',
    'Brasov',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'BUZAU',
    'Buzau',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'CHITILA',
    'Chitila',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'CLUJ',
    'Cluj',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'CRAIOVA',
    'Craiova',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'DUMBRAVITA',
    'Dumbravita',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'IASI',
    'Iasi',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'IASI_BISCUITS',
    'Iasi Biscuits',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KARAMOLEGOS',
    'Karamolegos',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'LIBERTATEA',
    'Libertatea',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PITESTI',
    'Pitesti',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'RAMNICU_VALCEA',
    'Ramnicu Valcea',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'TARGOVISTE',
    'Targoviste',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'TARGU_JIU',
    'Targu Jiu',
    'ROU',
    'BRU',
    'Europe/Bucharest',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BRU'
JOIN core.country c
  ON c.country_code = 'ROU'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'JAKOVO',
    'JAKOVO',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KRAGUJEVAC_1',
    'KRAGUJEVAC 1',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KRAGUJEVAC_2',
    'KRAGUJEVAC 2',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'KRALJEVO',
    'KRALJEVO',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'LESKOVAC',
    'LESKOVAC',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'LOZNICA',
    'LOZNICA',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'NIS_1',
    'NIŠ 1',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'NOVI_SAD',
    'NOVI SAD',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'NIS_2',
    'Niš 2',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PANCEVO',
    'PANČEVO',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PARACIN',
    'PARAĆIN',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PUDARCI',
    'PUDARCI',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'SUBOTICA_1',
    'SUBOTICA 1',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'SUBOTICA_2',
    'SUBOTICA 2',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'VELIKA_PLANA',
    'VELIKA PLANA',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'ZAJECAR',
    'ZAJEČAR',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'ZRENJANIN',
    'ZRENJANIN',
    'SRB',
    'BBA',
    'Europe/Belgrade',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BBA'
JOIN core.country c
  ON c.country_code = 'SRB'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'AGUIMES',
    'Agüimes',
    'ESP',
    'BI',
    'Atlantic/Canary',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'AMARITTA',
    'Amaritta',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'GUADALAJARA',
    'Guadalajara',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'LAS_MERCEDES',
    'Las Mercedes',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'MEDINA',
    'Medina',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PATERNA',
    'Paterna',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'PUENTE_GENIL',
    'Puente Genil',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'SOLARES',
    'Solares',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'ZARAGOZA',
    'Zaragoza',
    'ESP',
    'BI',
    'Europe/Madrid',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BI'
JOIN core.country c
  ON c.country_code = 'ESP'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'GIGA',
    'Giga',
    'TUN',
    'BTN',
    'Africa/Tunis',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BTN'
JOIN core.country c
  ON c.country_code = 'TUN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'SOPACO',
    'SOPACO',
    'TUN',
    'BTN',
    'Africa/Tunis',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BTN'
JOIN core.country c
  ON c.country_code = 'TUN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'MAIDSTONE',
    'Maidstone',
    'GBR',
    'BUK',
    'Europe/London',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BUK'
JOIN core.country c
  ON c.country_code = 'GBR'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'RO_ROTHERHAM',
    'RO / Rotherham',
    'GBR',
    'BUK',
    'Europe/London',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BUK'
JOIN core.country c
  ON c.country_code = 'GBR'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'EMEA'
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
    'BARRANQUILLA_BCOB',
    'Barranquilla / BCOB',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'CALI_BCOC',
    'Cali / BCOC',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'FROZEN_COLOMBIA_BCOF',
    'Frozen Colombia / BCOF',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'MEDELLIN_BCOM',
    'Medellin / BCOM',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'TENJO_BCOT',
    'Tenjo / BCOT',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'TENJO_BCOT_2',
    'Tenjo / BCOT 2',
    'COL',
    'BCO',
    'America/Bogota',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCO'
JOIN core.country c
  ON c.country_code = 'COL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'BIMBO_COSTA_RICA_BCR',
    'Bimbo Costa Rica / BCR',
    'CRI',
    'BCR',
    'America/Costa_Rica',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCR'
JOIN core.country c
  ON c.country_code = 'CRI'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'BIZCOCHERA_LA_ZARCERENA',
    'Bizcochera La Zarcereña',
    'CRI',
    'BCR',
    'America/Costa_Rica',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCR'
JOIN core.country c
  ON c.country_code = 'CRI'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'ZARCERENA_1',
    'Zarcereña 1',
    'CRI',
    'BCR',
    'America/Costa_Rica',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BCR'
JOIN core.country c
  ON c.country_code = 'CRI'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'EL_SALVADOR',
    'El Salvador',
    'SLV',
    'BES',
    'America/El_Salvador',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BES'
JOIN core.country c
  ON c.country_code = 'SLV'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'BIMBO_GUATEMALA_BGU',
    'Bimbo Guatemala / BGU',
    'GTM',
    'BGU',
    'America/Guatemala',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BGU'
JOIN core.country c
  ON c.country_code = 'GTM'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'BIMBO_HONDURAS_BHO',
    'Bimbo Honduras / BHO',
    'HND',
    'BHO',
    'America/Tegucigalpa',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BHO'
JOIN core.country c
  ON c.country_code = 'HND'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'BIMBO_PANAMA_BPA',
    'Bimbo Panamá / BPA',
    'PAN',
    'BPA',
    'America/Panama',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BPA'
JOIN core.country c
  ON c.country_code = 'PAN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'VENEZUELA_BVEG',
    'Venezuela / BVEG',
    'VEN',
    'BVE',
    'America/Caracas',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BVE'
JOIN core.country c
  ON c.country_code = 'VEN'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAC'
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
    'CORDOBA_HIR',
    'Córdoba / HIR',
    'ARG',
    'BA',
    'America/Argentina/Cordoba',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BA'
JOIN core.country c
  ON c.country_code = 'ARG'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'PILAR_HIZ',
    'Pilar / HIZ',
    'ARG',
    'BA',
    'America/Argentina/Buenos_Aires',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BA'
JOIN core.country c
  ON c.country_code = 'ARG'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'VALENTE',
    'Valente',
    'ARG',
    'BA',
    'America/Argentina/Buenos_Aires',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BA'
JOIN core.country c
  ON c.country_code = 'ARG'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'VILLA_TESEI_HID',
    'Villa Tesei / HID',
    'ARG',
    'BA',
    'America/Argentina/Buenos_Aires',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BA'
JOIN core.country c
  ON c.country_code = 'ARG'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'CHILLAN',
    'Chillan',
    'CHL',
    'IDEAL',
    'America/Santiago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'IDEAL'
JOIN core.country c
  ON c.country_code = 'CHL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'IDEAL',
    'Ideal',
    'CHL',
    'IDEAL',
    'America/Santiago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'IDEAL'
JOIN core.country c
  ON c.country_code = 'CHL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'NUTRABIEN',
    'Nutrabien',
    'CHL',
    'IDEAL',
    'America/Santiago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'IDEAL'
JOIN core.country c
  ON c.country_code = 'CHL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'QUILICURA',
    'Quilicura',
    'CHL',
    'IDEAL',
    'America/Santiago',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'IDEAL'
JOIN core.country c
  ON c.country_code = 'CHL'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'ASUNCION',
    'Asunción',
    'PRY',
    'BPR',
    'America/Asuncion',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BPR'
JOIN core.country c
  ON c.country_code = 'PRY'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'LIMA_CALLAO',
    'Lima / Callao',
    'PER',
    'BP',
    'America/Lima',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BP'
JOIN core.country c
  ON c.country_code = 'PER'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'MONTEVIDEO_PBU',
    'Montevideo / PBU',
    'URY',
    'BU',
    'America/Montevideo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BU'
JOIN core.country c
  ON c.country_code = 'URY'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
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
    'PLANTA_TIMOTE',
    'Planta Timote',
    'URY',
    'BU',
    'America/Montevideo',
    rc.region_country_id,
    TRUE
FROM core.organization o
JOIN core.region r
  ON r.organization_id = o.organization_id
 AND r.region_code = 'BU'
JOIN core.country c
  ON c.country_code = 'URY'
JOIN core.region_country rc
  ON rc.region_id = r.region_id
 AND rc.country_id = c.country_id
WHERE o.organization_code = 'LAS'
ON CONFLICT (organization_id, plant_code) DO UPDATE
SET plant_name = EXCLUDED.plant_name,
    country_code = EXCLUDED.country_code,
    region_code = EXCLUDED.region_code,
    timezone_name = EXCLUDED.timezone_name,
    region_country_id = EXCLUDED.region_country_id,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- 6) LÍNEAS
INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ASIA_BUN_LINE', 'Asia Bun Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_SLICE_BREAD_LINE', 'Big Slice Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CIABATTA_LINE', 'Ciabatta Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DOFI_LINE', 'Dofi Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SHOUSI_NATURAL_YEAST_LINE', 'Shousi & Natural yeast Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SMALL_SLICE_BREAD_LINE', 'Small Slice Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWEET_BUN_LINE', 'Sweet Bun Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BJ_MANKATTAN_BEIJING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CAKE_LINE', 'Cake Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CIABATTA_LINE', 'Ciabatta Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HANDMADE_LINE', 'Handmade Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICE_BREAD_LINE', 'Slice Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SMALL_SLICE_BREAD_LINE', 'Small Slice Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWEET_BREAD_LINE', 'Sweet Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SH_MANKATTAN_SHANGHAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BANGALORE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'BANGALORE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'CHENNAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'CHENNAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'DEWAS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'DEWAS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'HYDERABAD_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'HYDERABAD_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KHEDA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICE_BREAD_LINE', 'Slice Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KHEDA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_1', 'Bread Line 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_2', 'Bread Line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_3', 'Bread Line 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_4', 'Bread Line 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_5', 'Bread Line 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE_12', 'Bun Line 12', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE_7', 'Bun Line 7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE_8', 'Bun Line 8', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE_9_44', 'Bun Line 9+44', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BURGER_LINE_44', 'Burger Line 44', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'COOKIES_RUSK_CRUMBS_LINE_11', 'COOKIES & RUSK CRUMBS Line 11', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CAKE_LINE_13', 'Cake Line 13', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CAKE_LINE_14', 'Cake Line 14', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUMB_LINE_39', 'Crumb Line 39', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUMB_LINE_40', 'Crumb Line 40', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUMB_LINE_41', 'Crumb Line 41', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUMB_LINE_42', 'Crumb Line 42', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FLAT_BREAD_LINE_46', 'Flat Bread Line 46', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MARUNDA_LINE_27', 'Marunda Line 27', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MARUNDA_LINE_28', 'Marunda Line 28', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MILJY_PETHA_LINE_38', 'Miljy Petha Line 38', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'NAMKEEN_LINE_22', 'Namkeen Line 22', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'NAMKEEN_LINE_23', 'Namkeen Line 23', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RUSK_LINE_43', 'Rusk Line 43', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_1', 'Bread Line 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_2', 'Bread Line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CAKE_LINE', 'Cake Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CHAPATHI_LINE', 'Chapathi line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RUSK_LINE', 'Rusk Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_LINE', 'SBG Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOCHI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_1', 'Bread Line 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_2', 'Bread Line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CREAM_BUN_MAKE_UP_LINE', 'Cream Bun Make up Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DANIS_LACHHA_BUN_LINE', 'Danis/Lachha Bun Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'OPEN_TOP_BREAD_LINE', 'Open Top Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'KOLKATA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_1', 'Bread Line 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'MUMBAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_2', 'Bread Line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'MUMBAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_3', 'Bread Line 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'MUMBAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'MUMBAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWEET_BAKED_GOODS_LINE', 'Sweet Baked goods Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'MUMBAI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'NOIDA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICED_BREAD_LINE', 'Sliced Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'NOIDA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICED_BREAD_LINE', 'Sliced Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SARE_KHURD_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SARE_KHURD_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICED_BREAD_LINE', 'Sliced Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SARE_KHURD_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_LINE', 'Tortilla Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SARE_KHURD_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SONIPAT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICED_BREAD_LINE', 'Sliced Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SONIPAT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_LINE', 'Tortilla Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'SONIPAT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'TAPUKARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FLAT_BREAD_LINE', 'Flat Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'TAPUKARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SLICED_BREAD_LINE', 'Sliced Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'ASIA'
  AND p.plant_code = 'TAPUKARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES', 'Panes', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'BRASILIA_BBB'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_1', 'Panes 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'DIADEMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_2', 'Panes 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'DIADEMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_3', 'Panes 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'DIADEMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_4', 'Panes 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'DIADEMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_1', 'Panes 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'GUARAPUAVA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_2', 'Panes 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'GUARAPUAVA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_3', 'Panes 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'GUARAPUAVA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_1', 'Panes 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_2', 'Panes 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_3', 'Panes 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_4', 'Panes 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_5', 'Panes 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_6', 'Panes 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'HORTOLANDIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_1', 'Panes 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'JACAREPAGUA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANES_2', 'Panes 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'JACAREPAGUA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'PORTO_ALEGRE_BBPA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'PORTO_ALEGRE_BBPA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'PORTO_ALEGRE_BBPA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RECIFE_BBR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RECIFE_BBR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_MOLIDO', 'Pan Molido', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RECIFE_BBR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bolleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RIO_DE_JANEIRO_BBRJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RIO_DE_JANEIRO_BBRJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILHA', 'Tortilha', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'RIO_DE_JANEIRO_BBRJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CHIPS', 'Chips', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_MOLIDO', 'Pan Molido', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUES', 'Panques', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTELERIA', 'Pastelería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TAKIS', 'Takis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_1_BBSP1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_2_BBSP2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BB'
  AND p.plant_code = 'SAO_PAULO_2_BBSP2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_BREAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_BREAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_BREAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L2_COOKIES', 'SBG L2 Cookies', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_CAKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L3_LITTLE_BITES', 'SBG L3 LIttle Bites', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_CAKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L4_LITTLE_BITES', 'SBG L4 Little Bites', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ALBANY_CAKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L1', 'Bagel L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ARLINGTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ATLANTA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ATLANTA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'BEAVERTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L4', 'Rolls/Buns L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'BEAVERTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L1_DONUTS', 'SBG L1 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CARLISLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L2_DONUTS', 'SBG L2 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CARLISLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L3_DONUTS', 'SBG L3 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CARLISLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L4_DONUTS', 'SBG L4 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CARLISLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RING_MUFFINS_L3', 'Ring Muffins L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CHICAGO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L1', 'Rolls/Buns L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CHICAGO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L1_SNACK_CAKES', 'SBG L1 Snack Cakes', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CICERO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L2_LITTLE_BITES', 'SBG L2 Little Bites', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CICERO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L3_LITTLE_BITES', 'SBG L3 LIttle Bites', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CICERO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L4_SNACK_CAKES', 'SBG L4 Snack Cakes', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CICERO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L5_LITTLE_BITES', 'SBG L5 Little Bites', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'CICERO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'COMMERCE_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'COMMERCE_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'DENVER'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'DUBUQUE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'DUBUQUE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L3', 'Bread L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ELKHART'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L4', 'Rolls/Buns L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ELKHART'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L1', 'TEM L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ELKHART'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L2', 'TEM L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ELKHART'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L1_COOKIES', 'SBG L1 Cookies', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'EMMYS_ORGANIC_S'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ESCONDIDO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ESCONDIDO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FERGUS_FALLS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FORTH_WORTH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L4', 'Rolls/Buns L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FORTH_WORTH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L7_DONUTS', 'SBG L7 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FORTH_WORTH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L1', 'TEM L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FREDERICK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L2', 'TEM L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FREDERICK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L3', 'TEM L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FREDERICK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L4', 'TEM L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'FREDERICK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GASTONIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RING_MUFFINS_L7', 'Ring Muffins L7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GRAND_PRAIRIE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'THINS_BAGELS_L4', 'Thins/Bagels L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GRAND_PRAIRIE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_L1', 'Tortillas L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GRAND_PRAIRIE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GRAND_RAPIDS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GRAND_RAPIDS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GREENWICH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GREENWICH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L7', 'TEM L7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GREENWICH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L8', 'TEM L8', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GREENWICH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L9', 'TEM L9', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'GREENWICH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HAZLETON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'NEW_RUSTIK_BREAD', 'New Rustik Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HAZLETON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HAZLETON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L1_CAKE', 'SBG L1 Cake', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HAZLETON_CAKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L2_CAKE', 'SBG L2 Cake', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HAZLETON_CAKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HOUSTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HOUSTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HUNTINGTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HUNTINGTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'HUNTINGTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L1', 'Bagel L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'KENT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DRY_L1', 'Dry L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LACROSSE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LEHIGH_VALLEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LEHIGH_VALLEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LEHIGH_VALLEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L1', 'Bagel L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LENDERS_BAGEL_MATTOON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L2', 'Bagel L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LENDERS_BAGEL_MATTOON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L3', 'Bagel L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LENDERS_BAGEL_MATTOON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LONDON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'LONDON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MERIDIAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MERIDIAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MERIDIAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MONTEBELLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L3', 'Bread L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MONTEBELLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L5', 'Rolls/Buns L5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MONTEBELLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SBG_L8_DONUTS', 'SBG L8 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'MONTEBELLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'NORTHUMBERLAND'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'NORTHUMBERLAND'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OCONOMOWOC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OCONOMOWOC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OKLAHOMA_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OKLAHOMA_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ORANGEBURG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ORANGEBURG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ORANGEBURG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ORLANDO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L3', 'Crusty/Baguette L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OXNARD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L4', 'Crusty/Baguette L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OXNARD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HEARTH_L1', 'Hearth L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OXNARD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HEARTH_L2', 'Hearth L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'OXNARD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'PHOENIX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'PHOENIX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L1', 'TEM L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'PLANCENTIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L2', 'TEM L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'PLANCENTIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'READING'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TEM_L1', 'TEM L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'RIVIERA_BEACH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ARTISAN_L6', 'Artisan L6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L5', 'Bagel L5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L2', 'Crusty/Baguette L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L3', 'Crusty/Baguette L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L4', 'Crusty/Baguette L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUSTY_BAGUETTE_L7', 'Crusty/Baguette L7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HEARTH_L1', 'Hearth L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROANOKE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROCKWALL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROCKWALL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROSEVILLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'ROSEVILLE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'S_SAN_FRANCISCO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'S_SAN_FRANCISCO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RING_MUFFINS_L4', 'Ring Muffins L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'S_SAN_FRANCISCO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SACRAMENTO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SACRAMENTO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SALT_LAKE_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L3', 'Bread L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SALT_LAKE_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L4', 'Rolls/Buns L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SALT_LAKE_CITY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ARTISAN_L1', 'Artisan L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SAN_LUIS_OBISPO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SAYRE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_L1', 'Bagel L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'SOUTH_ST_PAUL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'TOPEKA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L2', 'Rolls/Buns L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'TOPEKA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L1', 'Bread L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'VALDESE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_L2', 'Bread L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'VALDESE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L3', 'Rolls/Buns L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'VALDESE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROLLS_BUNS_L1', 'Rolls/Buns L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BBU'
  AND p.plant_code = 'WILLIAMSPORT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL', 'Bagel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'CALGARY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ARTISAN', 'Artisan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'DANDURAND'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'DANDURAND'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'EDMONTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'EDMONTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISH_MUFFINS', 'English Muffins', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'EDMONTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'EDMONTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'HAMILTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'LANGLEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'LANGLEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'LAVAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'LAVAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'MONCTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'MONCTON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'NATURAL_BAKERY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL', 'Bagel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'RIVERMEDE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWING', 'Swing', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'ST_JOHNS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWING_LINE', 'SWING LINE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'STONEMILL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISHMUF', 'ENGLISHMUF', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_A', 'TORTILLA A', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_B', 'TORTILLA B', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_C', 'Tortilla C', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'TRILLIUM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BEBE', 'BÉBÉ', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CARAMEL', 'CARAMEL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FA_COOKIES', 'FA COOKIES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FLAKY', 'FLAKY', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'JOS_LOUIS', 'JOS LOUIS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PIQUE', 'PIQUE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TART_MOON', 'TART-MOON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'VAILLANT', 'VAILLANT', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'VARIETE', 'VARIETE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VACHON'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VIAU_PLANT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VIAU_PLANT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'VIAU_PLANT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWING', 'Swing', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BC'
  AND p.plant_code = 'WINNIPEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_MIX', 'BIG MIX', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CHICHARRON', 'CHICHARRON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'EXTRUIDOS_HARINA_TRIGO', 'EXTRUIDOS HARINA TRIGO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_1', 'MAÍZ LAMINADO (MAÍZ 1)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_2', 'MAÍZ LAMINADO (MAÍZ 2)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_3', 'MAÍZ LAMINADO (MAÍZ 3)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_PALOMERO_PALOMITA', 'MAÍZ PALOMERO (PALOMITA)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_COMAL', 'TOSTADAS (COMAL)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_01', 'TOSTADAS (TOSTADAS 01)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_02', 'TOSTADAS (TOSTADAS 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_03', 'TOSTADAS (TOSTADAS 03)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_04', 'TOSTADAS (TOSTADAS 04)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_05', 'TOSTADAS (TOSTADAS 05)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_TOSTADAS_06', 'TOSTADAS (TOSTADAS 06)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_ATITALAQUIA_BLA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_MIX', 'BIG MIX', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CACAHUATE_FRITO', 'CACAHUATE FRITO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CACAHUATE_JAPONES', 'CACAHUATE JAPONES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CHICHARRON', 'CHICHARRON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'EXTRUIDOS_HARINA_TRIGO', 'EXTRUIDOS HARINA TRIGO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOT_NUTS_CACAHUATE_ENGROSADO', 'HOT NUTS (CACAHUATE ENGROSADO)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_EXTRUIDO_MAIZ_03', 'MAÍZ EXTRUIDO (MAÍZ 03)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_02', 'MAÍZ LAMINADO (MAÍZ 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_04', 'MAÍZ LAMINADO (MAÍZ 04)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_PALOMERO', 'MAÍZ PALOMERO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIP_S', 'PAPA (CHIP´S)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_PAPA_CONTINUA', 'PAPA (PAPA CONTINUA)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIP_S_2', 'Papa (Chip´s 2)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LAGUNA_BLN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CACAHUATE_FRITO', 'CACAHUATE FRITO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CACAHUATE_JAPONES', 'CACAHUATE JAPONES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'EXTRUIDOS_HARINA_TRIGO_SCHAFF', 'EXTRUIDOS HARINA TRIGO (SCHAFF)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOT_NUTS_CACAHUATE_ENGROSADO', 'HOT NUTS (CACAHUATE ENGROSADO)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_EXTRUIDO_MAIZ_03', 'MAÍZ EXTRUIDO (MAÍZ 03)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_01', 'MAÍZ LAMINADO (MAÍZ 01)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_02', 'MAÍZ LAMINADO (MAÍZ 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_05', 'MAÍZ LAMINADO (MAÍZ 05)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_PALOMERO_PALOMITA_CONDIMENTADA', 'MAÍZ PALOMERO (PALOMITA CONDIMENTADA)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_PALOMERO_PALOMITA_KARAMELADA', 'MAÍZ PALOMERO (PALOMITA KARAMELADA)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_6', 'Maíz 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PALOMITA_BATCH', 'PALOMITA BATCH', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIPS_01', 'PAPA (CHIPS 01)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIPS_02', 'PAPA (CHIPS 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIPS_03', 'PAPA (CHIPS 03)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIPS_04', 'PAPA (CHIPS 04)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_CHIPS_05', 'PAPA (CHIPS 05)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_PAPA_CONTINUA_50', 'PAPA (PAPA CONTINUA 50)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA_PAPACONTINUA_21', 'PAPA (PAPACONTINUA 21)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PREPARADOS', 'PREPARADOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_LERMA_BLM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO', 'MAÍZ LAMINADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MEXICALLI_BLX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_2', 'Maíz 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MEXICALLI_BLX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_3', 'Maíz 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MEXICALLI_BLX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA', 'PAPA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MEXICALLI_BLX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_2', 'MAIZ LAMINADO (MAIZ 2)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MONTERREY_BLMT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_3', 'MAIZ LAMINADO (MAIZ 3)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MONTERREY_BLMT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_4', 'MAIZ LAMINADO (MAIZ 4)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MONTERREY_BLMT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_1', 'MAÍZ LAMINADO (MAÍZ 1)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MONTERREY_BLMT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_MIX', 'BIG MIX', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CHICHARRON', 'CHICHARRON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_EXTRUIDO_MAIZ_02', 'MAÍZ EXTRUIDO (MAÍZ 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_01', 'MAÍZ LAMINADO (MAÍZ 01)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_PALOMERO', 'MAÍZ PALOMERO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA', 'PAPA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_MERIDA_BLY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_MIX', 'BIG MIX', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CACAHUATE_JAPONES', 'CACAHUATE JAPONES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOT_NUTS', 'Hot Nuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_1', 'Maíz 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_EXTRUIDO', 'Maíz Extruido', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAPA', 'PAPA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'BARCEL_OCCIDENTE_BLO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_01', 'MAÍZ LAMINADO (MAIZ 01)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_02', 'MAÍZ LAMINADO (MAIZ 02)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_LAMINADO_MAIZ_03', 'MAÍZ LAMINADO (MAIZ 03)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_4', 'Maíz 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_5', 'Maíz 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAIZ_EXTRUIDO', 'Maíz Extruido', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'COPPELL_USA_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK', 'POPCORN SNACK', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_2', 'POPCORN SNACK 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_3', 'POPCORN SNACK 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_4', 'POPCORN SNACK 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_5', 'POPCORN SNACK 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_6', 'POPCORN SNACK 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POPCORN_SNACK_7', 'POPCORN SNACK 7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BL'
  AND p.plant_code = 'POPCORNOPOLIS_BLUSA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_BOLLERIA_SAL', 'BC BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_DONAS_CAKE_1', 'BC DONAS CAKE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_DONAS_CAKE_2', 'BC DONAS CAKE 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_MOLIDO', 'BC MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_PAN_DE_CAJA_1', 'BC PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_PAN_DE_CAJA_2', 'BC PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_PANQUELERIA', 'BC PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_TORTILLAS_1', 'BC TORTILLAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BC_TORTILLAS_2', 'BC TORTILLAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CENTRO_BC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_BOLLERIA_MIXTA', 'BCH BOLLERIA MIXTA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_BOLLERIA_SAL', 'BCH BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_DONAS_CAKE', 'BCH DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_MOLIDO', 'BCH MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_PAN_DE_CAJA', 'BCH PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_PANQUELERIA', 'BCH PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_REBANADAS', 'BCH REBANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BCH_TORTILLAS', 'BCH TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_CHIHUAHUA_BCH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_BOLLERIA_DULCE', 'BG BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_BOTANA_EMPAQUE_PAPAS', 'BG BOTANA EMPAQUE PAPAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_DONAS_CAKE', 'BG DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_MOLIDO', 'BG MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_PAN_DE_CAJA_1', 'BG PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_PAN_TOSTADO', 'BG PAN TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_PANQUELERIA', 'BG PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BG_TORTILLAS', 'BG TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_GOLFO_BG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_BOLLERIA_MIXTA', 'BW BOLLERIA MIXTA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_DONAS_CAKE', 'BW DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_MOLIDO', 'BW MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_PAN_DE_CAJA', 'BW PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_PANQUELERIA', 'BW PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_REBANADAS', 'BW REBANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_TORTILLAS', 'BW TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BW_TOSTADAS', 'BW TOSTADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLINAS_2', 'Tortillinas 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_HERMOSILLO_BW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_BOLLERIA_SAL', 'BP BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_DONAS_CAKE', 'BP DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_MOLIDO', 'BP MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_PAN_DE_CAJA', 'BP PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_PANQUELERIA', 'BP PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_TORTILLAS', 'BP TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_TOSTADAS', 'BP TOSTADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BP_TOTOPOS', 'BP TOTOPOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MAZATLAN_BP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_BOLLERIA_DULCE', 'BBC BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_BOLLERIA_SAL', 'BBC BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_BUNUELOS', 'BBC BUÑUELOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_DANES', 'BBC DANES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_DONAS_CAKE', 'BBC DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_GALLETERIA', 'BBC GALLETERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_HOJALDRE', 'BBC HOJALDRE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_MOLIDO', 'BBC MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_PAN_DE_CAJA', 'BBC PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_PAN_TOSTADO', 'BBC PAN TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_PANQUELERIA', 'BBC PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_PASTELERIA_2', 'BBC PASTELERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_TORTILLAS', 'BBC TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BBC_TOSTADAS', 'BBC TOSTADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICALI_BBC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_BOLLERIA_SAL', 'BY BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_GALLETERIA', 'BY GALLETERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_MALVAVISCO', 'BY MALVAVISCO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_MOLIDO', 'BY MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_PAN_DE_CAJA', 'BY PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_PASTELERIA', 'BY PASTELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_TORTILLAS', 'BY TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BY_TOTOPOS', 'BY TOTOPOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MERIDA_BY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_BOLLERIA_SAL_1', 'BMA BOLLERIA SAL 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_BOLLERIA_SAL_2', 'BMA BOLLERIA SAL 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_DONAS_CAKE_1', 'BMA DONAS CAKE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_DONAS_CAKE_2', 'BMA DONAS CAKE 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_DONAS_YEAST', 'BMA DONAS YEAST', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_MOLIDO', 'BMA MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_PAN_DE_CAJA_1', 'BMA PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_PAN_DE_CAJA_2', 'BMA PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMA_PANQUELERIA', 'BMA PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_AZCAPOTZALCO_BMA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_BOLLERIA_DULCE', 'BMS BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_PAN_DE_CAJA_1', 'BMS PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_PAN_DE_CAJA_2', 'BMS PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_1', 'BMS TORTILLAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_2', 'BMS TORTILLAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_3', 'BMS TORTILLAS 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_4', 'BMS TORTILLAS 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_5', 'BMS TORTILLAS 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BMS_TORTILLAS_6', 'BMS TORTILLAS 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_MEXICO_SANTA_MARIA_BMS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_BOLLERIA_DULCE_1', 'BN BOLLERIA DULCE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_BOLLERIA_DULCE_2', 'BN BOLLERIA DULCE 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_BOLLERIA_SAL_1', 'BN BOLLERIA SAL 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_BOLLERIA_SAL_2', 'BN BOLLERIA SAL 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_BUNUELOS', 'BN BUÑUELOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_DONAS_CAKE', 'BN DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_MOLIDO', 'BN MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_PAN_DE_CAJA_1', 'BN PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_PAN_DE_CAJA_2', 'BN PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_PANQUELERIA_1', 'BN PANQUELERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_PANQUELERIA_2', 'BN PANQUELERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_REBANADAS', 'BN REBANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_TORTILLAS', 'BN TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_TOSTADAS_1', 'BN TOSTADAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BN_TOSTADAS_2', 'BN TOSTADAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_NORTE_BN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_BOLLERIA_DULCE', 'BO BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_BOLLERIA_MIXTA', 'BO BOLLERIA MIXTA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_BOLLERIA_SAL', 'BO BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_MOLIDO', 'BO MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_PAN_DE_CAJA_1', 'BO PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_PAN_DE_CAJA_2', 'BO PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_REBANADAS', 'BO REBANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_TORTILLAS_1', 'BO TORTILLAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BO_TORTILLAS_2', 'BO TORTILLAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_OCCIDENTE_BO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_BOLLERIA_MIXTA', 'BPU BOLLERIA MIXTA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_BOLLERIA_SAL', 'BPU BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_BUNUELOS', 'BPU BUÑUELOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_DONAS_CAKE', 'BPU DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_MOLIDO', 'BPU MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_PAN_DE_CAJA', 'BPU PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_PAN_TOSTADO', 'BPU PAN TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_PANQUELERIA', 'BPU PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU_TORTILLAS', 'BPU TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_BPU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BPU2_DANES_1', 'BPU2 DANES 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_PUEBLA_2_BPU2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_BOLLERIA_SAL', 'BSL BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_HOT_CAKES', 'BSL HOT CAKES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_MOL', 'BSL MOL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_PAN_DE_CAJA_1', 'BSL PAN DE CAJA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_PAN_DE_CAJA_2', 'BSL PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_PAN_TOSTADO', 'BSL PAN TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_PANQUELERIA', 'BSL PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_THINS', 'BSL THINS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BSL_TORTILLAS', 'BSL TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SAN_LUIS_BSL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_BOLLERIA_SAL', 'BS BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_MOLIDO', 'BS MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_PAN_DE_CAJA', 'BS PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_PAN_TOSTADO', 'BS PAN TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_PANQUELERIA', 'BS PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_TORTILLAS', 'BS TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_TOSTADAS_1', 'BS TOSTADAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BS_TOSTADAS_2', 'BS TOSTADAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_SURESTE_BS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_BAGEL', 'BTI BAGEL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_BOLLERIA_SAL', 'BTI BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_GALLETERIA', 'BTI GALLETERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_GALLETERIA_2', 'BTI Galletería 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_MALVAVISCO', 'BTI MALVAVISCO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_PAN_DE_CAJA', 'BTI PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_PAN_DE_CAJA_2', 'BTI PAN DE CAJA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTI_PANQUELERIA', 'BTI PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TIJUANA_BTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_BOLLERIA_ARTESANAL', 'BT BOLLERIA ARTESANAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_BOLLERIA_DULCE', 'BT BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_BOLLERIA_MIXTA', 'BT BOLLERIA MIXTA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_BOLLERIA_SAL', 'BT BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_DONAS_CAKE', 'BT DONAS CAKE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_HOT_CAKES', 'BT HOT CAKES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_MOLIDO', 'BT MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_PAN_DE_CAJA', 'BT PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_TORTILLAS', 'BT TORTILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BT_TOSTADAS', 'BT TOSTADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'BIMBO_TOLUCA_BT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CREPAS', 'Crepas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_DANES', 'GLO DANES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_DANES_2', 'GLO DANES 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_DONAS_YEAST', 'GLO DONAS YEAST', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_GALLETA_ARROZ', 'GLO GALLETA ARROZ', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_GELATINAS', 'GLO GELATINAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_HELADOS', 'GLO HELADOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PANES', 'GLO PANES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PASTELES_1', 'GLO PASTELES 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PASTELES_2', 'GLO PASTELES 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PASTELES_3', 'GLO PASTELES 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PASTELES_4', 'GLO PASTELES 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLO_PASTELES_CONGELADOS', 'GLO PASTELES CONGELADOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'WAFLES', 'Wafles', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'EL_GLOBO_EGL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_EMPANADAS', 'GM EMPANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_GALLETERIA_1', 'GM GALLETERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_GALLETERIA_2', 'GM GALLETERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_GALLETERIA_4', 'GM GALLETERIA 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_GALLETERIA_5', 'GM GALLETERIA 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_GALLETERIA_6', 'GM GALLETERIA 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_MOLIDO', 'GM MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_TOST_HORNEADA_1', 'GM TOST. HORNEADA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_TOST_HORNEADA_2', 'GM TOST. HORNEADA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_TOST_HORNEADA_3', 'GM TOST. HORNEADA 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_TOST_HORNEADA_4', 'GM TOST. HORNEADA 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GM_TOST_HORNEADA_5', 'GM TOST. HORNEADA 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'GALLETAS_GABI_GG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_BOLLERIA_DULCE', 'HZ BOLLERIA DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_DANES', 'HZ DANES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_HOJALDRE', 'HZ HOJALDRE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_PAN_RUSTICO_1', 'HZ PAN RUSTICO 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_PAN_RUSTICO_2', 'HZ PAN RUSTICO 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_PANQUELERIA', 'HZ PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_SANDWICH_1', 'HZ SANDWICH 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HZ_SANDWICH_2', 'HZ SANDWICH 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'HAZPAN_HP'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'JUL_EMPANADAS', 'JUL EMPANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'JULITAS_JUL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_GALLETERIA_1', 'MM GALLETERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_GALLETERIA_2', 'MM GALLETERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_GALLETERIA_3', 'MM GALLETERIA 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_GAUFRETTE_1', 'MM GAUFRETTE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_GAUFRETTE_2', 'MM GAUFRETTE 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_MALVAVISCO_1', 'MM MALVAVISCO 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_MALVAVISCO_2', 'MM MALVAVISCO 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_PASTELERIA_1', 'MM PASTELERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_PASTELERIA_2', 'MM PASTELERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_PAY', 'MM PAY', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MM_SWISS_ROLL', 'MM SWISS ROLL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_MEXICO_MM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_CRACKER', 'MN CRACKER', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_DANES', 'MN DANES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_GALLETERIA', 'MN GALLETERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_HOJALDRE', 'MN HOJALDRE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_MALVAVISCO', 'MN MALVAVISCO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_PANQUELERIA', 'MN PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_PASTELERIA_1', 'MN PASTELERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_PASTELERIA_2', 'MN PASTELERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN_SWISS_ROLL', 'MN SWISS ROLL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_MN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN2_MINI_MUFFIN', 'MN2 MINI MUFFIN', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MN2_PASTELERIA_PANQUELERIA', 'MN2 PASTELERIA PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_NORTE_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_GALLETERIA_1', 'MO GALLETERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_GALLETERIA_2', 'MO GALLETERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_GALLETERIA_3', 'MO GALLETERIA 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_GALLETERIA_4', 'MO GALLETERIA 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_MALVAVISCO_1', 'MO MALVAVISCO 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_MALVAVISCO_2', 'MO MALVAVISCO 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_PASTELERIA_1', 'MO PASTELERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_PASTELERIA_2', 'MO PASTELERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MO_SWISS_ROLL', 'MO SWISS ROLL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'MARINELA_OCCIDENTE_MO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SQT_SALMAS_1', 'SQT SALMAS 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'PLANTA_QUERETARO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SQT_TOST_HORNEADA_1', 'SQT TOST HORNEADA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'PLANTA_QUERETARO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SS_GALLETA_ARROZ', 'SS GALLETA ARROZ', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SANISSIMO_SS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SS_TOST_HORNEADA_1', 'SS TOST HORNEADA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SANISSIMO_SS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SS_TOST_HORNEADA_2', 'SS TOST HORNEADA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SANISSIMO_SS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SS_TOST_HORNEADA_3', 'SS TOST HORNEADA 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SANISSIMO_SS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SS_TOST_HORNEADA_4', 'SS TOST HORNEADA 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SANISSIMO_SS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_BARRAS', 'SM BARRAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_CEREALES', 'SM CEREALES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_1', 'SM GALLETERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_2', 'SM GALLETERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_3', 'SM GALLETERIA 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_4', 'SM GALLETERIA 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_5', 'SM GALLETERIA 5', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_6', 'SM GALLETERIA 6', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_7', 'SM GALLETERIA 7', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GALLETERIA_8', 'SM GALLETERIA 8', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SM_GAUFRETTE', 'SM GAUFRETTE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'SUANDY_MEXICO_SM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_BOLLERIA_SAL', 'BTJ BOLLERIA SAL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_BUNUELOS', 'BTJ BUÑUELOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_MOLIDO', 'BTJ MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_PAN_DE_CAJA', 'BTJ PAN DE CAJA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_PANKO', 'BTJ PANKO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BTJ_REBANADAS', 'BTJ REBANADAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TEPEJI_TPJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_DANES_1', 'TR DANES 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_DANES_2', 'TR DANES 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_DANES_3', 'TR DANES 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_GALLETERIA_1', 'TR GALLETERIA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_GALLETERIA_2', 'TR GALLETERIA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_HOJALDRE_1', 'TR HOJALDRE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_HOJALDRE_2', 'TR HOJALDRE 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_MARGARINAS', 'TR MARGARINAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TR_PANQUELERIA', 'TR PANQUELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BM'
  AND p.plant_code = 'TIA_ROSA_TR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'BEIJING_BQBJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'HANGZHOU_BQHZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LAMINATION', 'Lamination', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'HANGZHOU_BQHZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MACARON', 'Macaron', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'HANGZHOU_BQHZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SHANGHAI_BQSH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISH_MUFFIN', 'English Muffin', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SHANGHAI_BQSH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SHENYANG_BQSY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SICHUAN_MANKATTAN_CHENGDU_BQCD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGEL_LINE', 'Bagel Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TIANJIN_BQTJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TIANJIN_BQTJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISH_MUFFIN', 'English Muffin', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TIANJIN_BQTJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRIED_DOUGHSTICK', 'Fried Doughstick', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TIANJIN_BQTJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'XIAOGAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'IMPROVER_PREMIX', 'Improver/Premix', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'XIAOGAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_LINE', 'Bun line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ZHONGSHAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CAKE_LINE', 'Cake Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ZHONGSHAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MCGRIDDLE', 'McGriddle', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ZHONGSHAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWEET_BREAD_LINE', 'Sweet Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'ZHONGSHAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'AIX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISH_MUFFINS', 'English Muffins', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'AIX'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_ROLLS_LINE', 'Buns & Rolls line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'BQ_CHATELLERAULT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'FLEURY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'PLESSIS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'KAZAJISTAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SOUTH_KOREA_BQSK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN_2', 'Bun 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SOUTH_KOREA_BQSK'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'MOSCOW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MUFFIN', 'Muffin', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'MOSCOW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PIE', 'Pie', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'MOSCOW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'MOSCOW'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'CAPETOWN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'PRETORIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'PRETORIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_1', 'Buns 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'SWITZERLAND'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TURKEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PIZZA_DOUGH', 'Pizza dough', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'TURKEY'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'UKRAINE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'AIRPORT_OH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_1', 'Buns 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'DENVER'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_2', 'Buns 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'DENVER'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ENGLISH_MUFFINS', 'English Muffins', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'DENVER'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'EAST_POINTE_OH'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUN', 'Bun', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'BQ'
  AND p.plant_code = 'VALDOSTA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'DONJA_ZELINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'DONJA_ZELINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GROSUPLJE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GROSUPLJE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PARTIALLY_BAKED_BREAD_PASTRY_LINE', 'Partially baked bread & pastry line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GROSUPLJE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTRY_LINE', 'Pastry line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GROSUPLJE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIAL_BREAD_LINE', 'Special Bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GROSUPLJE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRANJ_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE', 'Bread Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRANJ_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'DANILOVGRAD_SPUZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PIZZA', 'PIZZA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CASABLANCA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAIN_MIXTA', 'Pain Mixta', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CASABLANCA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTEL', 'Pastel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CASABLANCA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CASABLANCA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'COMBO_PAN_CC_Y_SC', 'Combo Pan (cc y sc)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ALBERGARIA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bolleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLYCAO', 'Bollycao', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DOKYO', 'Dokyo', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DOKYO_2', 'Dokyo 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SINTRA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_L1', 'Bread Gostol 1 - L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRAILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2_L3', 'Bread Gostol 2 - L3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRAILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRASOV'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRASOV'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROUND_BREAD_GOSTOL_2', 'Round Bread Gostol 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRASOV'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIALITIES_LINE', 'Specialities Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BRASOV'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_L1', 'Bread Gostol 1 - L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'BUZAU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE_KONING', 'Buns Line-Koning', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRISPY_BITE_RONDO', 'Crispy Bite - Rondo', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MECATHERM_ROLLS', 'Mecatherm Rolls', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWEET_PRODUCT_COZONAC_CANOL', 'Sweet Product(COZONAC) - Canol', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOAST_LINE_KAAK', 'Toast Line KAAK', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CHITILA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CLUJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_KORNFEIL', 'Bread-Kornfeil', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CLUJ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_L1', 'Bread Gostol 1 - L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CRAIOVA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2_L4', 'Bread Gostol 2 - L4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'CRAIOVA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_L1', 'Bread Gostol 1 - L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'DUMBRAVITA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_GOSTOL_1', 'Bread Line Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'IASI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_LINE_GOSTOL_2', 'Bread Line Gostol 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'IASI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIALITIES_LINE', 'Specialities Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'IASI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BISCUITS_N1', 'Biscuits N1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'IASI_BISCUITS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BISCUITS_N2', 'Biscuits N2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'IASI_BISCUITS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOAST_LINE_L1', 'Toast Line L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KARAMOLEGOS'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LIBERTATEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2', 'Bread Gostol 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LIBERTATEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_KORNFEIL', 'Bread Kornfeil', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LIBERTATEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PITESTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2', 'Bread Gostol 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PITESTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_TUNEL', 'Bread Tunel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PITESTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_PASTRY_FRITCH', 'Frozen Pastry FRITCH', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PITESTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIALITIES', 'Specialities', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PITESTI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_LINE', 'Bread Gostol 1 Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RAMNICU_VALCEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2_LINE', 'Bread Gostol 2 Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RAMNICU_VALCEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIALITIES_LINE', 'Specialities Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RAMNICU_VALCEA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1_L1', 'Bread Gostol 1 - L1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGOVISTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_2_L2', 'Bread Gostol 2 - L2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGOVISTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_GOSTOL_1', 'Bread Gostol 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGU_JIU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD_TUNEL', 'Bread Tunel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGU_JIU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PRETZEL', 'Pretzel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGU_JIU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ROUND_PRETZEL_LINE_FRITCH', 'Round Pretzel Line Fritch', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'TARGU_JIU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'JAKOVO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRAGUJEVAC_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTRY_LINE', 'Pastry line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRAGUJEVAC_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOAST_BREAD', 'Toast Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRAGUJEVAC_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREADCRUMBS_LINE', 'Breadcrumbs line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRAGUJEVAC_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRAGUJEVAC_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'KRALJEVO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LESKOVAC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LOZNICA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NIS_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_AND_PACKAGED_FLAT_BREAD_LINE', 'Frozen and packaged flat bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NIS_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_AND_PACKAGED_BREAD_LINE', 'Frozen and packaged bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NOVI_SAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_AND_PACKAGED_BREAD_LINE_2', 'Frozen and packaged bread line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NOVI_SAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NOVI_SAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE_2', 'Frozen line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NOVI_SAD'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTRY_LINE', 'Pastry line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'NIS_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PANCEVO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RUSK_BREAD_LINE', 'Rusk bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PANCEVO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PARACIN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS_LINE', 'Buns Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTRY_LINE', 'Pastry line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SOFT_DOUGH_LINE', 'Soft dough line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SPECIAL_BREAD_LINE', 'Special Bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUDARCI'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SUBOTICA_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SUBOTICA_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FROZEN_LINE', 'Frozen line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SUBOTICA_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'VELIKA_PLANA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD_LINE', 'Fresh & Sliced bread line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZAJECAR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'FRESH_SLICED_BREAD', 'Fresh & Sliced bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZRENJANIN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AGUIMES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'COMBO_PAN_CC_Y_SC', 'Combo Pan (cc y sc)', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AGUIMES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AGUIMES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOJALDRE', 'Hojaldre', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AGUIMES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BREAD', 'Bread', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AMARITTA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUNS', 'Buns', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'AMARITTA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GUADALAJARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'L5_DONUTS', 'L5 Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GUADALAJARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GUADALAJARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RUSTIK', 'Rustik', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GUADALAJARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'THINS', 'Thins', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GUADALAJARA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LAS_MERCEDES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SIN_CORTEZA', 'Sin Corteza', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LAS_MERCEDES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'VARIEDADES', 'Variedades', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'LAS_MERCEDES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIZCOCHO', 'Bizcocho', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CROISSANT', 'Croissant', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRUAPAN_E09_HOJALD', 'Cruapan - E09-HOJALD', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GALLETAS', 'Galletas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOJALDRE_E08_HOJALD', 'Hojaldre - E08-HOJALD', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAGDAGUR', 'Magdagur', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAGDALENAS_ARTESANAS', 'Magdalenas Artesanas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAGDALENAS_REDONDAS', 'Magdalenas Redondas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'NAPOLITANA', 'Napolitana', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MEDINA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA_SALADA', 'Bollería Salada', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PATERNA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PATERNA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLYCAO', 'Bollycao', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONETES', 'Donetes', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LAR', 'LAR', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTEL_VAPS', 'Pastel VAPS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SIN_CORTEZA', 'Sin Corteza', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TAKIS', 'Takis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'PUENTE_GENIL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BAGELS', 'Bagels', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOLARES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOLARES'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CROISSANT', 'Croissant', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MAGDALENAS', 'Magdalenas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_DE_LECHE', 'Pan de Leche', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANKIS', 'Pankis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTEL', 'Pastel', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'ZARAGOZA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BRO', 'BRO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GIGA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BARTQUETTE_TARTALETTE', 'Bartquette/Tartalette', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GIGA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GLIMEK', 'Glimek', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GIGA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LAS_3', 'Las 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GIGA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LAS_4', 'Las 4', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'GIGA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'COMAS_DUBAI', 'Comas-Dubai', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'COMAS_MAROC', 'Comas-maroc', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GOR', 'Gor', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LASE2', 'LASE2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MINIPAIN', 'MINIPAIN', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'POL', 'POL', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TON', 'TON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TRP', 'TRP', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TRNCH', 'Trnch', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'SOPACO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LINE_1', 'Line 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MAIDSTONE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LINE_2', 'Line 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MAIDSTONE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LINE_3', 'Line 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'MAIDSTONE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'LIBERTY_LINE', 'Liberty Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RO_ROTHERHAM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MANHATTAN_LINE', 'Manhattan Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RO_ROTHERHAM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TAKIS', 'Takis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RO_ROTHERHAM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TRIBECA_LINE', 'Tribeca Line', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'EMEA'
  AND p.plant_code = 'RO_ROTHERHAM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BARRANQUILLA_BCOB'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panquelería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BARRANQUILLA_BCOB'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BARRANQUILLA_BCOB'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'CALI_BCOC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO', 'TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'CALI_BCOC'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CONGELADO_HOJALDRE_BAGUETTE_PAN_PITA', 'Congelado, Hojaldre, Baguette, Pan Pita', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'FROZEN_COLOMBIA_BCOF'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CROAPAN', 'Croapan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'FROZEN_COLOMBIA_BCOF'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'MEDELLIN_BCOM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panquelería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'MEDELLIN_BCOM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TRADICIONAL', 'Tradicional', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'MEDELLIN_BCOM'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'AREPAS', 'Arepas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIMBUNUELOS', 'Bimbuñuelos', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLIDO_MIGA', 'Molido / Miga', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_14000', 'Pan 14000', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_9600', 'Pan 9600', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_PITA', 'Pan Pita', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panquelería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA_PASTELERIA', 'Panquelería-Pasteleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTELERIA', 'Pasteleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA_MAIZ', 'Tortilla Maíz', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_1', 'Tortillas 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_2', 'Tortillas 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_DE_ARROZ', 'Tostadas de arroz', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO_1', 'Tostado 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO_2', 'Tostado 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO_3', 'Tostado 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONAS', 'Donas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOJALDRE', 'Hojaldre', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SNACKS', 'Snacks', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'TENJO_BCOT_2'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLIDO', 'MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_PITA', 'Pan Pita', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA_HOJALDRE', 'Panqueleria / Hojaldre', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SANISSIMO_I', 'Sanissimo I', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SANISSIMO_II', 'Sanissimo II', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SWISS_ROLL', 'Swiss Roll', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS_DE_ARROZ', 'Tostadas de arroz', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_COSTA_RICA_BCR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SECOS_SALADOS', 'Secos / salados', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIZCOCHERA_LA_ZARCERENA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'EMPANADAS_GALLETAS', 'Empanadas / Galletas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'ZARCERENA_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOJALDRE', 'Hojaldre', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'ZARCERENA_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panqueleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'ZARCERENA_1'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIG_MIX', 'BIG MIX', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TAKIS', 'Takis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS', 'Tostadas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'EL_SALVADOR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'CRACKER', 'Cracker', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONAS', 'Donas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GALLETAS', 'Galletas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MALVAVISCO', 'Malvavisco', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_12800', 'Pan 12800', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_MIXTA', 'Pan mixta', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQ_BOLL', 'Panq-Boll', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO', 'TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADAS', 'Tostadas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_GUATEMALA_BGU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GALLETERIA', 'Galleteria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_HONDURAS_BHO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SANDWICHADO', 'Sandwichado', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_HONDURAS_BHO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SUAVICREMA', 'Suavicrema', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_HONDURAS_BHO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_PANAMA_BPA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'BIMBO_PANAMA_BPA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA_MIXTA', 'Bollería Mixta', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLIDO_MIGA', 'Molido / Miga', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_1', 'Pan 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_2', 'Pan 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO', 'TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLA', 'Tortilla', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAC'
  AND p.plant_code = 'VENEZUELA_BVEG'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'CORDOBA_HIR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'CORDOBA_HIR'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA_II', 'Bollería II', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PILAR_HIZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_I', 'PAN I', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PILAR_HIZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_II', 'Pan II', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PILAR_HIZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PILAR_HIZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_2', 'Tortillas 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PILAR_HIZ'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BUDIN', 'BUDIN', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'VALENTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MADALENAS', 'MADALENAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'VALENTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANETONE', 'Panetone', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'VALENTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'VAINILLAS', 'VAINILLAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'VALENTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'VILLA_TESEI_HID'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'CHILLAN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ALFAJORES', 'ALFAJORES', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'ALFAJORES_2', 'ALFAJORES 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'HOJALDRE_1', 'HOJALDRE 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_PITA_1', 'PAN PITA 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_PITA_2', 'PAN PITA 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PIZZA', 'PIZZA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_2', 'Pan 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panqueleria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RALLADO', 'RALLADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_2', 'Tortillas 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_3', 'Tortillas 3', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'IDEAL'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BIZCOCHOS', 'BIZCOCHOS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'NUTRABIEN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GALLETERIA', 'Galleteria', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'NUTRABIEN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SALMAS', 'Salmas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'NUTRABIEN'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TAKIS', 'Takis', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'QUILICURA'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BARRAS', 'Barras', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'GRISINES', 'Grisines', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PASTEL_DULCE', 'PASTEL DULCE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN_BOLLERIA_SALADA', 'Pan / Bollería salada', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANETONE', 'Panetone', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA', 'Panquelería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'ASUNCION'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLIDO', 'MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANETON', 'PANETON', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PANQUELERIA_PASTELERIA', 'PANQUELERIA-PASTELERIA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PITA', 'PITA', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PAN', 'Pan', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SALMAS', 'SALMAS', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'SALMAS_2', 'SALMAS 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TOSTADO', 'TOSTADO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS', 'Tortillas', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'TORTILLAS_2', 'Tortillas 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'LIMA_CALLAO'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'BOLLERIA', 'Bollería', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'MONTEVIDEO_PBU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLDE', 'MOLDE', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'MONTEVIDEO_PBU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MOLIDO', 'MOLIDO', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'MONTEVIDEO_PBU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'PBH', 'PBH', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'MONTEVIDEO_PBU'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'DONUTS', 'Donuts', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PLANTA_TIMOTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MECATHERM_1', 'Mecatherm 1', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PLANTA_TIMOTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'MECATHERM_2', 'Mecatherm 2', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PLANTA_TIMOTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO core.production_line (plant_id, line_code, line_name, is_active)
SELECT p.plant_id, 'RADEMAKER', 'Rademaker', TRUE
FROM core.plant p
JOIN core.organization o ON o.organization_id = p.organization_id
WHERE o.organization_code = 'LAS'
  AND p.plant_code = 'PLANTA_TIMOTE'
ON CONFLICT (plant_id, line_code) DO UPDATE
SET line_name = EXCLUDED.line_name,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

COMMIT;
