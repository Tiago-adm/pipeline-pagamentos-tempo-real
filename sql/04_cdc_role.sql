-- Usuário dedicado ao conector, com o mínimo de permissão necessário
CREATE ROLE rangofest_cdc WITH LOGIN PASSWORD 'TROCAR_SENHA_AQUI' REPLICATION;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO rangofest_cdc;
