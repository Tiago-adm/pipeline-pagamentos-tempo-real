-- Essencial: sem isso o CDC não mostra o "antes" de um UPDATE/DELETE
ALTER TABLE sales REPLICA IDENTITY FULL;
