#!/usr/bin/env bash
set -e

# Service accounts
confluent iam service-account create rangofest-producer --description "escreve nos topicos do rangofest"
confluent iam service-account create rangofest-consumer --description "le os topicos do rangofest"

# ACLs — troque SA_PRODUCER_ID e SA_CONSUMER_ID pelos IDs retornados acima
confluent kafka acl create --allow --service-account SA_PRODUCER_ID --operations write  --topic rangofest --prefix
confluent kafka acl create --allow --service-account SA_PRODUCER_ID --operations create --topic rangofest --prefix
confluent kafka acl create --allow --service-account SA_CONSUMER_ID --operations read   --topic rangofest --prefix
confluent kafka acl create --allow --service-account SA_CONSUMER_ID --operations read   --consumer-group rangofest --prefix
