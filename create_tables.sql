-- =====================================================================
-- EBAC - Exercício Módulo 2 (SQL / DDL)
-- Script de criação das tabelas de cliente (customer), produto (product)
-- e estoque (stock) no PostgreSQL.
-- Nomes de tabelas e colunas em inglês, conforme orientação da aula.
-- =====================================================================

-- Remove as tabelas caso já existam (ordem inversa por causa das FKs)
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;

-- ---------------------------------------------------------------------
-- Tabela de clientes
-- ---------------------------------------------------------------------
CREATE TABLE customer (
    id          SERIAL        PRIMARY KEY,
    first_name  VARCHAR(50)   NOT NULL,
    last_name   VARCHAR(100)  NOT NULL,
    document    VARCHAR(14)   NOT NULL UNIQUE,      -- CPF ou CNPJ, só números
    email       VARCHAR(150)  NOT NULL UNIQUE,
    phone       VARCHAR(20),
    birth_date  DATE,
    address     VARCHAR(200),
    city        VARCHAR(100),
    state       CHAR(2),
    zip_code    VARCHAR(8),
    active      BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- Tabela de produtos
-- ---------------------------------------------------------------------
CREATE TABLE product (
    id           SERIAL         PRIMARY KEY,
    sku          VARCHAR(30)    NOT NULL UNIQUE,     -- código interno do produto
    name         VARCHAR(150)   NOT NULL,
    description  TEXT,
    category     VARCHAR(50),
    brand        VARCHAR(50),
    unit         VARCHAR(10)    NOT NULL DEFAULT 'UN', -- UN, CX, KG...
    cost_price   NUMERIC(10, 2) NOT NULL CHECK (cost_price >= 0),
    sale_price   NUMERIC(10, 2) NOT NULL CHECK (sale_price >= 0),
    active       BOOLEAN        NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------------------
-- Tabela de estoque (uma linha por produto em cada depósito)
-- ---------------------------------------------------------------------
CREATE TABLE stock (
    id             SERIAL       PRIMARY KEY,
    product_id     INTEGER      NOT NULL,
    warehouse      VARCHAR(50)  NOT NULL,             -- depósito / local
    quantity       INTEGER      NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    min_quantity   INTEGER      NOT NULL DEFAULT 0 CHECK (min_quantity >= 0),
    max_quantity   INTEGER               CHECK (max_quantity >= 0),
    last_entry_at  TIMESTAMP,
    last_exit_at   TIMESTAMP,
    updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_stock_product
        FOREIGN KEY (product_id) REFERENCES product (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT uq_stock_product_warehouse
        UNIQUE (product_id, warehouse)
);
