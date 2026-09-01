-- ============================================================
-- GB Connected - Organizaciones y plantas por usuario Entra ID
-- Schema aislado para no chocar con otros catálogos existentes.
-- ============================================================

CREATE SCHEMA IF NOT EXISTS gb_access;

CREATE TABLE IF NOT EXISTS gb_access.organizations (
    id TEXT PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS gb_access.plants (
    id TEXT PRIMARY KEY,
    organization_id TEXT NOT NULL REFERENCES gb_access.organizations(id),
    code TEXT NOT NULL,
    name TEXT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (organization_id, code)
);

CREATE TABLE IF NOT EXISTS gb_access.user_plant_access (
    entra_tenant_id UUID NOT NULL,
    entra_object_id UUID NOT NULL,
    plant_id TEXT NOT NULL REFERENCES gb_access.plants(id),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (entra_tenant_id, entra_object_id, plant_id)
);

CREATE INDEX IF NOT EXISTS idx_user_plant_access_identity
    ON gb_access.user_plant_access(entra_tenant_id, entra_object_id)
    WHERE active = TRUE;

CREATE INDEX IF NOT EXISTS idx_plants_organization
    ON gb_access.plants(organization_id)
    WHERE active = TRUE;

CREATE OR REPLACE VIEW gb_access.v_user_organizations AS
SELECT DISTINCT
    ua.entra_tenant_id,
    ua.entra_object_id,
    o.id AS organization_id,
    o.code AS organization_code,
    o.name AS organization_name
FROM gb_access.user_plant_access ua
JOIN gb_access.plants p
  ON p.id = ua.plant_id
JOIN gb_access.organizations o
  ON o.id = p.organization_id
WHERE ua.active = TRUE
  AND p.active = TRUE
  AND o.active = TRUE;

CREATE OR REPLACE VIEW gb_access.v_user_plants AS
SELECT
    ua.entra_tenant_id,
    ua.entra_object_id,
    o.id AS organization_id,
    p.id AS plant_id,
    p.code AS plant_code,
    p.name AS plant_name
FROM gb_access.user_plant_access ua
JOIN gb_access.plants p
  ON p.id = ua.plant_id
JOIN gb_access.organizations o
  ON o.id = p.organization_id
WHERE ua.active = TRUE
  AND p.active = TRUE
  AND o.active = TRUE;
