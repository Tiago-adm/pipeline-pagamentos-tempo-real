-- Rodar com o usuário DONO das tabelas (não com rangofest_cdc),
-- porque rangofest_cdc não tem privilégio para criar publicações.
CREATE PUBLICATION dbz_publication FOR TABLE sales, cards, trucks;
