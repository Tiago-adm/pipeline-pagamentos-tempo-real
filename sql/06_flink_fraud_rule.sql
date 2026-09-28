-- Converte o changelog de vendas em stream append-only
CREATE TABLE `rangofest-sales-events` AS
SELECT id AS sale_id, card_id, truck_id, amount, created_at
FROM TO_CHANGELOG(input => TABLE `rangofest.public.sales`)
WHERE op = 'INSERT';

-- Regra: 3 transações no mesmo cartão em 60 segundos = alerta
CREATE TABLE `rangofest-fraud-alerts` AS
SELECT *
FROM `rangofest-sales-events`
MATCH_RECOGNIZE (
  PARTITION BY card_id
  ORDER BY `$rowtime`
  MEASURES
    FIRST(A.sale_id)   AS first_sale_id,
    LAST(A.sale_id)    AS last_sale_id,
    COUNT(A.sale_id)   AS tx_count,
    SUM(A.amount)      AS total_amount,
    LAST(A.created_at) AS last_tx_at
  ONE ROW PER MATCH
  AFTER MATCH SKIP PAST LAST ROW
  PATTERN (A{3}) WITHIN INTERVAL '60' SECOND
  DEFINE
    A AS A.amount >= 0
) AS fraud;
