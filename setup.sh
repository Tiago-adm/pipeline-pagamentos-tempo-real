#!/usr/bin/env bash
# Sobe a fundação do pipeline no Confluent Cloud.
# Pré-requisitos: Confluent CLI logado, Postgres (Neon) já criado e com
# replicação lógica habilitada em Settings > Postgres > Logical Replication.
set -e

echo "1. Criando environment..."
confluent environment create rangofest

echo "Copie o env-id acima e rode:"
echo "  confluent environment use <env-id>"
read -p "Pressione ENTER depois de rodar o comando acima..."

echo "2. Criando cluster Basic..."
confluent kafka cluster create rangofest-cluster --cloud aws --region sa-east-1 --type basic

echo "Copie o lkc-id acima e rode:"
echo "  confluent kafka cluster use <lkc-id>"
read -p "Pressione ENTER depois de rodar o comando acima..."

echo "3. Criando service accounts e ACLs..."
bash scripts/acls.sh

echo "4. Rode manualmente no Neon (SQL Editor), nesta ordem:"
echo "   sql/01_create_tables.sql"
echo "   sql/03_replica_identity.sql"
echo "   sql/04_cdc_role.sql"
echo "   sql/05_publication.sql"

echo "5. Registre o schema (Confluent Cloud > Schema Registry):"
echo "   conteudo de schemas/sale.avsc, subject rangofest-sales-value"

echo "6. Crie o conector (Confluent Cloud > Connectors > Postgres CDC Source V2):"
echo "   use os valores de connectors/postgres-cdc-source-v2.json e do seu .env"

echo "7. Crie o compute pool do Flink (Flink > Compute pools, AWS sa-east-1)"
echo "   e rode sql/06_flink_fraud_rule.sql no SQL Workspace."

echo "Setup concluído — confira o README para os passos de evidência."
