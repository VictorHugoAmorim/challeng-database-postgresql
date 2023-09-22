/* 
@Victor Hugo Amorim
SGBD: PostgreSQL  
Para resolver:
    1. Listar os usuários que fazem aniversário no dia de hoje e que a quantidade de vendas realizadas em Janeiro/2020 sejam superiores a 1500;
    2. Para cada mês de 2020, solicitamos que seja exibido um top 5 dos usuários que mais venderam ($) na
      categoria Celulares. Solicitamos o mês e ano da análise, nome e sobrenome do vendedor, quantidade de
      vendas realizadas, quantidade de produtos vendidos e o total vendido; 
    3. Solicitamos popular uma nova tabela com o preço e estado dos itens no final do dia. Considerar que
      esse processo deve permitir um reprocesso. Vale ressaltar que na tabela de item, vamos ter unicamente
      o último estado informado pela PK definida (esse item pode ser resolvido através de uma store procedure). 
*/
-- Questão 1
SELECT
   cr.customer_id
	,concat(cr.first_name,' ', cr.last_name) as nome_completo
   --Interpretação 1
   -- Caso considere "quantidade de vendas" a soma de produtos vendidos, use o calculo abaixo
   ,sum(so.quantity) as quantidade_produtos_vendidos
   --Interpretação 2
   -- Caso considere "quantidade de vendas" a soma de cada ordem (independente de quantidade de produtos vendidos), use o calculo abaixo
   --,count(DISTINCT so.order_id) as quantidade_de_vendas
FROM 
 	sale_order so
 	left JOIN customer cr
   ON so.customer_id = cr.customer_id
 WHERE 1=1
 	and so.order_date BETWEEN date('2020-01-01') and date('2020-01-31')
   and EXTRACT(MONTH FROM cr.date_of_birth) = EXTRACT(MONTH FROM CURRENT_DATE)
   and EXTRACT(DAY FROM cr.date_of_birth) = EXTRACT(DAY FROM CURRENT_DATE)
 GROUP BY 1
 --Interpretação 1
 HAVING sum(so.quantity) > 1500
 --Interpretação 2
 --HAVING count(DISTINCT so.order_id) > 1500

/*
Explicação: 
   Para o SQL acima foi utilizada a função 'concat' para junção de nome e sobrenome. Armazenando-os em apenas 1 coluna facilitará a leitura;
   A soma da coluna quantity foi necessária para termos todos números de vendas de cada vendedor;
   A contagem distinta da coluna order_id representa o nº de vendas, independente da quantidade de protudos vendidos em cada venda;
   Foi necessário uma ligação entre tabelas (sale_order e customer) para coletar os dados de usuario e venda;
   O comando Between foi usado para filtrar intervalo de tempo e a função extract auxilia na identificação de dia, mês e ano;
*/

 -- Questão 2
WITH vendas_celular_2020 as (
SELECT
	cr.customer_id
	,concat(cr.first_name,' ', cr.last_name) as nome_completo
    ,EXTRACT(YEAR FROM so.order_date) as ano
    ,EXTRACT(MONTH FROM so.order_date) as mes
    ,format('M%1$s Y%2$s', EXTRACT(MONTH FROM so.order_date), EXTRACT(YEAR FROM so.order_date)) as mes_do_ano
    ,count(DISTINCT so.order_id) as quantidade_de_vendas
    ,sum(so.quantity) as quantidade_produtos_vendidos
    ,sum(so.quantity * it.price) as valor_vendido
 FROM
 	sale_order so
 	left JOIN customer cr
    ON so.customer_id = cr.customer_id
    LEFT JOIN item it 
    on so.item_id = it.item_id 
    LEFT JOIN category ct 
    on ct.category_id = it.category_id
 WHERE 1=1
 	and EXTRACT(YEAR FROM so.order_date) = 2020
 	and ct.type_category_name = 'Celulares e Smartphones'
 GROUP BY 1,2,3,4,5
) , classificacao_vendas_celular_2020 as (
SELECT 
	ROW_NUMBER() OVER (
      PARTITION BY
      mes_do_ano
      ORDER BY 
      valor_vendido desc) 
   AS classificacao
   ,*
FROM
	vendas_celular_2020
)
SELECT
	classificacao
   ,customer_id
   ,nome_completo
   ,mes_do_ano
   ,quantidade_de_vendas
   ,quantidade_produtos_vendidos
   ,valor_vendido
FROM
	classificacao_vendas_celular_2020
WHERE
	classificacao <= 5
order by mes, classificacao, valor_vendido desc

/*
Explicação: 
   No SQL acima foi utilizado CTE (common table expression), ou "With Tables", para facilitar a manipulação, filtragem e gerar ranking com agrupamentos;
   Aqui temos o uso da função format, com ela podemos unir mês e ano em uma string, facilitando leitura e manipulação;
   Para encontrar o valor vendido, foi multiplicado a quantidade de venda pelo preço do produto;
   Foi utilizado o link 'Left Join' entre todas as tabelas criadas, assim coletamos todos os dados necessários para a resposta;
   A criação da classificação foi feita com uma window function, ordenada pelo valor de venda e particionada pelos meses do ano;
   Nos filtros, foram passados como parâmetro o ano e a categoria solicitada na questão. Por fim, o ranking só permite exibição até o nº 5;
*/

 -- Questão 3
CREATE OR REPLACE PROCEDURE PopulateItemPriceHistory()
-- parâmetro necessário para escrita de procedure no PostgreSQL
LANGUAGE plpgsql
AS $$
BEGIN
    -- Criação da tabela Item_historic (se ela não existir)
   CREATE TABLE IF NOT EXISTS Item_historic (
      item_id INT NOT NULL,
      item_description VARCHAR(255) NOT NULL,
      price DECIMAL(10, 2) NOT NULL,
      is_active BOOLEAN NOT NULL,
      execution_date TIMESTAMP
   );

    -- Deleta os registros existentes na tabela Item_historic, permitindo um reprocesso
   DELETE FROM Item_historic;

    -- Insere os registros no final do dia com base na tabela Item
    INSERT INTO Item_historic (item_id, item_description, price, is_active, execution_date)
    SELECT item_id, item_description, price, is_active, CURRENT_TIMESTAMP
    FROM Item;
    
    COMMIT;
END;
$$;
--Descomentar e executar o código abaixo após a criação da procedure
--    CALL populateitempricehistory();
--Descomentar e executar o código abaixo após a chamada da procedure
--    SELECT * FROM Item_historic;

/*
Explicação: 
   A Stored Procedure irá criar uma tabela nova para armazenar os dados solicitados na questão 3;
   Como a questão indica que existe um reprocessamento dos dados, a procedure irá apagar os dados antigos da tabela;
   As novas inserções serão definidas pela tabela 'Item', e então receberão a data e horario corrente local para identificação;
*/