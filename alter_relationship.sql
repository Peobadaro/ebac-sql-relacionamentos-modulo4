-- =====================================================================
-- EBAC - Exercício Módulo 4 (SQL / Relacionamentos)
-- Relacionamento entre as tabelas product e stock com ALTER TABLE.
--
-- Tipo de relacionamento: 1 para N (1:N)
--   - 1 produto pode ter N registros de estoque (um por depósito)
--   - cada registro de estoque pertence a exatamente 1 produto
--
-- A chave estrangeira fica no lado N (stock.product_id -> product.id).
-- Pré-requisito: tabelas criadas pelo create_tables.sql (Módulo 2).
-- =====================================================================

-- Remove o relacionamento caso já exista, para o script poder ser
-- executado mais de uma vez sem erro
ALTER TABLE stock
    DROP CONSTRAINT IF EXISTS fk_stock_product;

-- Garante que todo registro de estoque tenha um produto
ALTER TABLE stock
    ALTER COLUMN product_id SET NOT NULL;

-- Cria o relacionamento 1:N entre product e stock
--   ON UPDATE CASCADE  -> se o id do produto mudar, o estoque acompanha
--   ON DELETE RESTRICT -> não deixa apagar um produto que tem estoque
ALTER TABLE stock
    ADD CONSTRAINT fk_stock_product
        FOREIGN KEY (product_id) REFERENCES product (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;

-- Índice na chave estrangeira para deixar as consultas de junção
-- (product x stock) mais rápidas
CREATE INDEX IF NOT EXISTS idx_stock_product_id
    ON stock (product_id);

-- ---------------------------------------------------------------------
-- Conferência: estoque de cada produto usando o relacionamento
-- ---------------------------------------------------------------------
SELECT p.sku,
       p.name,
       s.warehouse,
       s.quantity
FROM product p
JOIN stock s ON s.product_id = p.id
ORDER BY p.sku, s.warehouse;
