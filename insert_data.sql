-- =====================================================================
-- EBAC - Exercício Módulo 3 (SQL / DML)
-- Script de inserção de dados nas tabelas customer, product e stock.
-- Pré-requisito: tabelas criadas pelo create_tables.sql (Módulo 2).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Clientes
-- ---------------------------------------------------------------------
INSERT INTO customer (first_name, last_name, document, email, phone, birth_date, address, city, state, zip_code)
VALUES
    ('Ana',      'Souza',      '12345678901', 'ana.souza@email.com',      '(71) 98811-2233', '1990-03-15', 'Rua das Flores, 120',       'Salvador',       'BA', '40015000'),
    ('Bruno',    'Lima',       '23456789012', 'bruno.lima@email.com',     '(11) 97722-3344', '1985-07-22', 'Av. Paulista, 1500',        'São Paulo',      'SP', '01310100'),
    ('Carla',    'Mendes',     '34567890123', 'carla.mendes@email.com',   '(21) 96633-4455', '1993-11-02', 'Rua do Catete, 45',         'Rio de Janeiro', 'RJ', '22220000'),
    ('Diego',    'Ferreira',   '45678901234', 'diego.ferreira@email.com', '(31) 95544-5566', '1988-01-30', 'Av. Afonso Pena, 800',      'Belo Horizonte', 'MG', '30130000'),
    ('Eduarda',  'Rocha',      '56789012345', 'eduarda.rocha@email.com',  '(91) 94455-6677', '1996-05-18', 'Tv. Padre Eutíquio, 300',   'Belém',          'PA', '66023000'),
    ('Felipe',   'Almeida',    '67890123456', 'felipe.almeida@email.com', '(41) 93366-7788', '1979-09-09', 'Rua XV de Novembro, 210',   'Curitiba',       'PR', '80020310'),
    ('Mercado',  'Bom Preço',  '11222333000144', 'compras@bompreco.com.br', '(71) 3333-4444', NULL,       'Av. Tancredo Neves, 1000',  'Salvador',       'BA', '41820020');

-- ---------------------------------------------------------------------
-- Produtos
-- ---------------------------------------------------------------------
INSERT INTO product (sku, name, description, category, brand, unit, cost_price, sale_price)
VALUES
    ('NB-001', 'Notebook 15"',            'Notebook 15,6 polegadas, 16 GB RAM, SSD 512 GB', 'Informática', 'Dell',      'UN', 3200.00, 4299.90),
    ('MS-002', 'Mouse sem fio',           'Mouse óptico sem fio, 1600 DPI',                 'Periféricos', 'Logitech',  'UN',   45.00,   89.90),
    ('TC-003', 'Teclado mecânico',        'Teclado mecânico ABNT2, switch azul',            'Periféricos', 'Redragon',  'UN',  150.00,  279.90),
    ('MN-004', 'Monitor 27"',             'Monitor 27 polegadas, Full HD, 75 Hz',           'Informática', 'LG',        'UN',  780.00, 1199.00),
    ('HS-005', 'Headset USB',             'Headset com microfone, conexão USB',             'Áudio',       'JBL',       'UN',  120.00,  229.90),
    ('PP-006', 'Papel A4 (caixa)',        'Caixa com 10 resmas de papel A4, 75 g',          'Escritório',  'Chamex',    'CX',  180.00,  259.90),
    ('CB-007', 'Cabo HDMI 2 m',           'Cabo HDMI 2.0, 2 metros',                        'Acessórios',  'Multilaser','UN',   12.00,   34.90);

-- ---------------------------------------------------------------------
-- Estoque
-- O product_id é buscado pelo SKU com um subselect, para não depender
-- do número gerado pelo SERIAL.
-- ---------------------------------------------------------------------
INSERT INTO stock (product_id, warehouse, quantity, min_quantity, max_quantity, last_entry_at)
VALUES
    ((SELECT id FROM product WHERE sku = 'NB-001'), 'Salvador',   25,  5,  60, '2026-11-10 09:30:00'),
    ((SELECT id FROM product WHERE sku = 'NB-001'), 'São Paulo',  40, 10, 100, '2026-11-12 14:00:00'),
    ((SELECT id FROM product WHERE sku = 'MS-002'), 'Salvador',  150, 30, 400, '2026-11-08 10:15:00'),
    ((SELECT id FROM product WHERE sku = 'TC-003'), 'Salvador',   60, 15, 150, '2026-11-05 16:45:00'),
    ((SELECT id FROM product WHERE sku = 'MN-004'), 'São Paulo',  18,  5,  50, '2026-11-11 11:20:00'),
    ((SELECT id FROM product WHERE sku = 'HS-005'), 'Belém',      35, 10,  80, '2026-11-09 08:50:00'),
    ((SELECT id FROM product WHERE sku = 'PP-006'), 'Salvador',  200, 50, 500, '2026-11-14 13:10:00'),
    ((SELECT id FROM product WHERE sku = 'CB-007'), 'Belém',       3, 20, 200, '2026-10-28 15:30:00');

-- ---------------------------------------------------------------------
-- Conferência dos dados inseridos
-- ---------------------------------------------------------------------
SELECT * FROM customer;
SELECT * FROM product;
SELECT * FROM stock;

-- Clientes da Bahia e de São Paulo (IN)
SELECT first_name, last_name, city, state
FROM customer
WHERE state IN ('BA', 'SP');

-- Produtos abaixo do estoque mínimo (WHERE + subselect)
SELECT sku, name
FROM product
WHERE id IN (SELECT product_id FROM stock WHERE quantity < min_quantity);
