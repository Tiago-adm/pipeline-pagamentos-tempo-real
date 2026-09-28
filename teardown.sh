#!/usr/bin/env bash
# Derruba tudo que gera custo. Rode ao final de cada sessão de estudo.
set -e

echo "1. Parando statements do Flink..."
confluent flink statement list
echo "Pare manualmente cada statement 'Running' no console (Flink > Statements > Stop)"

echo "2. Deletando o conector CDC (cobra por hora mesmo pausado)..."
confluent connect cluster list
read -p "Copie o ID do conector e rode: confluent connect cluster delete <id> --force. ENTER para continuar."

echo "3. Deletando o compute pool do Flink..."
confluent flink compute-pool list
read -p "Copie o ID do pool e rode: confluent flink compute-pool delete <id> --force. ENTER para continuar."

echo "4. Confirmando que nada ficou rodando..."
confluent connect cluster list
confluent flink compute-pool list
confluent flink statement list

echo "5. Opcional — derruba tudo de uma vez, incluindo cluster e tópicos:"
echo "   confluent kafka cluster delete <lkc-id> --force"
echo "   confluent environment delete <env-id> --force"

echo "6. No Neon: o projeto pode ficar (free tier não cobra em repouso),"
echo "   ou delete em Settings > General > Delete project, se preferir."

echo "Teardown concluído."
