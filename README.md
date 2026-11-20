# EBAC – Exercício Módulo 4 (SQL / Relacionamentos)

Relacionamento **1:N** entre as tabelas **product** e **stock** no PostgreSQL, feito com `ALTER TABLE`.

```
product (1) ──────< (N) stock
   id  <─────────────  product_id   (FOREIGN KEY)
```

- 1 produto pode ter vários registros de estoque (um por depósito).
- Cada registro de estoque pertence a um único produto.

## Arquivos

| Arquivo | O que faz |
|---|---|
| `create_tables.sql` | Cria as tabelas (Módulo 2) |
| `insert_data.sql` | Insere os dados (Módulo 3) |
| `alter_relationship.sql` | **Exercício deste módulo:** cria a chave estrangeira `fk_stock_product` com `ALTER TABLE` (`ON UPDATE CASCADE`, `ON DELETE RESTRICT`) e um índice em `stock.product_id` |

O `alter_relationship.sql` remove a constraint antes de recriar (`DROP CONSTRAINT IF EXISTS`), então pode ser rodado mais de uma vez sem erro.

## Como rodar

```bash
psql -U postgres -d nome_do_banco -f create_tables.sql
psql -U postgres -d nome_do_banco -f insert_data.sql
psql -U postgres -d nome_do_banco -f alter_relationship.sql
```
