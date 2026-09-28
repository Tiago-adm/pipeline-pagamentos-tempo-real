-- Só necessário se você partir de um schema com nomes antigos;
-- documenta o que foi feito durante o desenvolvimento deste projeto.
ALTER TABLE cards RENAME COLUMN name TO holder_name;
ALTER TABLE cards RENAME COLUMN number TO masked_number;
ALTER TABLE sales RENAME COLUMN sale_date TO created_at;
ALTER TABLE sales ALTER COLUMN created_at SET DEFAULT now();
