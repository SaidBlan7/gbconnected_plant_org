CREATE SCHEMA IF NOT EXISTS app_security;
CREATE TABLE IF NOT EXISTS app_security.user_plant_access (
    entra_tenant_id uuid,
    entra_object_id uuid,
    plant_id bigint,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by varchar(255) DEFAULT 'GBC_ACCESS_API' NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by varchar(255) DEFAULT 'GBC_ACCESS_API' NOT NULL,
    CONSTRAINT user_plant_access_pkey PRIMARY KEY(entra_tenant_id, entra_object_id, plant_id)
);
CREATE INDEX IF NOT EXISTS idx_user_plant_access_user ON app_security.user_plant_access(entra_tenant_id, entra_object_id);
INSERT INTO app_security.user_plant_access(entra_tenant_id,entra_object_id,plant_id)
VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa','bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',1),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa','bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',2)
ON CONFLICT DO NOTHING;
