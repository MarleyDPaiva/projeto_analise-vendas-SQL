                                         -- VISÃO GERAL DAS VENDAS


-- 1. QUAL É O FATURAMENTO TOTAL DA EMPRESA?
#Resultado:
   -- O faturamento total da empresa foi de R$ 398.282,00.   
SELECT SUM(quantidade * preco_unitario) AS faturamento_total
FROM itens_pedido;
# ----------------------------------------------------------------------------------------------------

-- 2. QUANTOS PEDIDOS FORAM REALIZADOS?
#Resultado:
	-- Foram realizados 150 pedidos
    
SELECT COUNT(*) AS 'total de pedidos'
FROM pedidos;
# ----------------------------------------------------------------------------------------------------

-- 3. QUANTO EM MÉDIA , CADA PEDIDO GERA DE RECEITA? 
#Resultado: 
	-- Cada pedido feito gera à empresa em média o valor de R$ 2655.21 
    
SELECT SUM(quantidade * preco_unitario)/ COUNT(DISTINCT pedido_id) AS 'TICKET MEDIO' 
FROM itens_pedido;
# ----------------------------------------------------------------------------------------------------

-- 4. QUANTOS PRODUTOS FORAM VENDIDOS?
#Resultado: 
	-- No total foram vendidos 380 produtos!

SELECT SUM(quantidade) AS 'Total de produtos vendidos' FROM itens_pedido;
# ----------------------------------------------------------------------------------------------------

-- 5.QUAL O VALOR MÉDIO DOS PRODUTOS VENDIDOS?
#Resultado: 
	-- o valor médio dos produtos vendidos foi de R$ 1300.366

SELECT AVG(preco_unitario) AS 'Preço medio'
FROM itens_pedido;
# ----------------------------------------------------------------------------------------------------

-- 6. QUAL FOI O MAIOR PEDIDO REALIZADO?
#Resultado:
	-- O maior pedido realizado foi o de ID  27 , com um valor de R$ 5799.80
    
SELECT pedido_id, SUM(quantidade * preco_unitario) AS valor_pedido
FROM itens_pedido GROUP BY pedido_id  ORDER BY valor_pedido DESC LIMIT 1;
# ----------------------------------------------------------------------------------------------------

												-- ANÁLISE DE CLIENTES

-- 7. QUAIS SÃO OS DEZ CLIENTES QUE MAIS GASTARAM ?
#Resultado:
	-- A lista a baixo mostra o nome dos clientes que mais gastaram e na frente do nome os respectivos gastos, com isso temos um TOP 10 de clientes
    -- que mais compraram conosco 
/* Leticia Costa -> 	10489.60
Helena Rocha ->	10089.60
Pedro Oliveira ->	9689.50
Mariana Alves -> 9599.60
Juliana Costa ->	8199.60
Daniel Ramos ->	7899.60
Maria Santos ->	7749.60
Larissa Mendes -> 	7649.60 
Manuela Castro ->	7599.60
Bianca Oliveira ->	7249.40
*/

SELECT c.id, c.nome, SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.id
JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC
LIMIT 10;
# ----------------------------------------------------------------------------------------------------

-- 8. QUANTOS PEDIDOS CADA CLIENTE REALIZOU ?
#Resultado:
	-- Essa consulta retorna 100 linhas nas quais , metade dos clientes fizeram 2 pedidos a outra metade apenas 1!!!

SELECT c.id , c.nome , COUNT(p.id) AS Quantidade_pedidos
FROM clientes c LEFT JOIN pedidos p 
ON p.cliente_id = c.id 
GROUP BY c.id , c.nome
ORDER BY Quantidade_pedidos DESC;
# ----------------------------------------------------------------------------------------------------

-- 9. QUANTOS CLIENTES NUNCA FIZERAM UM PEDIDO?
#Resultado:
	-- O resultado obtido foi que todos os clientes registrados fizeram no minimo 1 pedido!
    
SELECT c.id , c.nome FROM clientes c LEFT JOIN pedidos p
ON p.cliente_id = c.id WHERE p.id IS NULL;
# ----------------------------------------------------------------------------------------------------

-- 10. QUAL CLIENTE REALIZOU MAIS PEDIDOS?
#Resultado:
	-- Aqui retornou o cliente João da silva de id 1(por causa  da clausula (LIMIT 1) , com  2 pedidos
    -- mas é importante lembrar que 50 clientes pediram duas vezes támbem
    
SELECT c.id , c.nome , COUNT(p.id) AS Quantidade_pedidos
FROM clientes c JOIN pedidos p ON p.cliente_id = c.id 
GROUP BY c.id , c.nome
ORDER BY Quantidade_pedidos DESC LIMIT 1;
# ----------------------------------------------------------------------------------------------------

-- 11. QUANTO CADA CLIENTE GASTOU EM MEDIA POR PEDIDO?
#Resultado:
	-- vamos mostar apenas os 5 primeiros que foram :  
 /* 'Livia Martins', '5799.80'
'Douglas Mendes', '5399.80'
'Leticia Costa', '5244.80'
'Helena Rocha', '5044.80'
'Alex Nunes', '4999.80' */ -- eses foram os principais clientes que mais gastaram na media por pedido na nossa empresa!!!!

SELECT c.id, c.nome, ROUND(AVG(pedido_total), 2) AS ticket_medio
FROM clientes c
JOIN ( SELECT p.id AS pedido_id, p.cliente_id, SUM(ip.quantidade * ip.preco_unitario) AS pedido_total
FROM pedidos p JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY p.id, p.cliente_id
) AS pedidos_cliente ON pedidos_cliente.cliente_id = c.id
GROUP BY c.id, c.nome
ORDER BY ticket_medio DESC;
# ----------------------------------------------------------------------------------------------------

                                                              -- ANALISANDO OS PRODUTOS
 
-- 12. QUAIS SÂO OS PRODUTOS MAIS VENDIDOS?
#Resultado:
	-- O produto mais vendido foi o 'headset gamer' com 10 unidades vendidas , seguido por 3 Notebooks 
-- Inspiron ,Notebook IdeaPad e Notebook Aspire com 7 unidades vendidas de cada

SELECT pr.id , pr.nome_produto, COUNT(ip.quantidade) AS Quantidade_vendida 
FROM produtos pr JOIN itens_pedido ip ON ip.produto_id = pr.id 
GROUP BY pr.id , pr.nome_produto 
ORDER BY Quantidade_vendida DESC;
# ----------------------------------------------------------------------------------------------------

-- 13. QUAL O TOP 3 PRODUTOS QUE GERARAM O MAIOR FATURAMENTO?
#Resultado:
	-- OS 3 produtos com os quais mais faturamos foram : o 'iPhone 15' com um total de R$ 34.999 , seguido por´'Pc gamer ryzen 5' com R$ 32.199 e 'XBOX series X'
-- com R$ 30.099

SELECT pr.id , pr.nome_produto, SUM(ip.quantidade * ip.preco_unitario)  AS faturamento_total
FROM produtos pr JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY pr.id , pr.nome_produto
ORDER BY faturamento_total DESC LIMIT 3;
# ----------------------------------------------------------------------------------------------------

-- 14. QUAIS PRODUTOS NUNCA FORAM VENDIDOS?
#Resultado:
	-- Observamos que o produto 'caderno de 200 folhas' e 'agenda 2026' , náo foram vendidos nenhuma vez

SELECT pr.id, pr.nome_produto
FROM produtos pr LEFT JOIN itens_pedido ip
ON ip.produto_id = pr.id
WHERE ip.id IS NULL;
# ----------------------------------------------------------------------------------------------------

-- 15. QUAIS PRODUTOS POSSUEM ESTOQUE BAIXO (10 sendo baixo)?
#Resultado:
	-- os produtos xbox series x , playstation 5 e geladeira frostfree estão com estoque baixo , tendo 7 , 8 e 8 unidades respectivamente

SELECT id , nome_produto, estoque ,
CASE
   WHEN estoque < 10 THEN 'Estoque Baixo'
   ELSE 'Estoque Normal'
   END AS status_estoque
FROM produtos
WHERE estoque < 10
ORDER BY estoque;
# ----------------------------------------------------------------------------------------------------

-- 16.QUAIS PRODUTOS POSSUEM A MAIOR MARGEM?
#Resultado:
	-- os produtos com maior margem são:
	-- nome   ,  preço  ,   custo ,  margem unitaria
-- 'iPhone 15', '4999.90', '3800.00', '1199.90'
-- 'PC Gamer Ryzen 5','4599.90', '3500.00', '1099.90'
 -- com uma margem  de mais de 1000 R$

SELECT id, nome_produto,preco, custo,(preco - custo) AS margem_unitaria
FROM produtos
ORDER BY margem_unitaria DESC;
# ----------------------------------------------------------------------------------------------------
--                                                               ANALISANDO AS CATEGORIAS

-- 17.  QUAL CATEGORIA VENDE MAIS?
#Resultado:
	-- De acordo com nossa query , a categoria 'escritório' destacou-se como a que mais vendeu

SELECT c.nome as categoria, SUM(ip.quantidade) as  quantidade_vendida
FROM categorias c JOIN produtos pr ON pr.categoria_id = c.id 
JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY c.id, c.nome
ORDER BY quantidade_vendida DESC;
# ----------------------------------------------------------------------------------------------------

-- 18. QUAL CATEGORIA GERA MAIS FATURAMENTO?
#Resultado:
	-- minha consulta mostrou que a categoria informatica é a que teve um maior faturamento no total, com R$ 103.596,50

SELECT c.nome AS categoria, SUM(ip.quantidade * ip.preco_unitario) AS faturamento_total
FROM categorias c JOIN produtos pr ON pr.categoria_id = c.id
JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY  c.id , c.nome 
ORDER BY faturamento_total DESC;
# ----------------------------------------------------------------------------------------------------

-- 19.QUAL CATEGORIA POSSUI A MAIOR MARGEM?
#Resultado:
	-- A categoria informatica apresentou a amior margem com o valor de R$ 26.246,50

SELECT c.id, c.nome AS categoria, SUM((pr.preco - pr.custo) * ip.quantidade) AS margem_total
FROM categorias c JOIN produtos pr ON pr.categoria_id = c.id
JOIN itens_pedido ip ON ip.produto_id = pr.id
GROUP BY c.id, c.nome
ORDER BY margem_total DESC LIMIT 1;
# ----------------------------------------------------------------------------------------------------
 --                                                             ANALISANDO OS VENDEDORES

-- 20. QUAL VENDEDOR REALIZOU MAIS VENDAS?
#Resultado:
	-- Obtivemos um empate, 10 vendedores com 8 vendas no total e o resto empatados com 7

SELECT v.id , v.nome, COUNT(p.id) AS quantidade_pedidos
FROM vendedores v JOIN pedidos p ON p.vendedor_id = v.id
GROUP BY v.id , v.nome 
ORDER BY quantidade_pedidos DESC;
# ----------------------------------------------------------------------------------------------------

-- 21. QUAL VENDEDOR GEROU O MAIOR FATURAMENTO?
#Resultado: 
	-- o vendedor 'Rafael Costa' obteve com suas vendas um valor de	R$23.892.70

SELECT v.id , v.nome, SUM(ip.quantidade * ip.preco_unitario) AS faturamento_total
FROM vendedores v JOIN pedidos p ON p.vendedor_id = v.id JOIN itens_pedido 	ip ON ip.pedido_id = p.id
GROUP BY v.id , v.nome 
ORDER BY faturamento_total DESC LIMIT 1;
# ----------------------------------------------------------------------------------------------------

-- 22. QUAL O TICKET MÉDIO DE CADA VENDEDOR?
#Resultado: 
	-- A consulta abaixo mostra o ticket medio de todos os vendedores , mas vou destacar o 'thiago Nunes' que tem o maior
    -- valor entre as médias com R$ 3148.34

SELECT v.id, v.nome, COUNT(DISTINCT pc.pedido_id) AS quantidade_pedidos,
SUM(pc.valor_pedido) AS faturamento_total, ROUND(AVG(pc.valor_pedido), 2) AS ticket_medio
FROM vendedores v
JOIN ( SELECT p.id AS pedido_id,p.vendedor_id, SUM(ip.quantidade * ip.preco_unitario) AS valor_pedido
FROM pedidos p JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY p.id,p.vendedor_id
) AS pc 
ON pc.vendedor_id = v.id
GROUP BY v.id, v.nome
ORDER BY ticket_medio DESC;
# ----------------------------------------------------------------------------------------------------

                                        -- ANALISE DA PARTE FINANCEIRA - PAGAMENTOS
                                        
-- 23. QUAL A FORMA DE PAGAMENTO MAIS UTILIZADA?
#Resultado: 
	-- o método de pagamento mais utilizado foi o PIX com 66 ocorrências 
    
SELECT forma_pagamento, COUNT(*) AS quantidade FROM pagamentos
GROUP BY forma_pagamento ORDER BY quantidade DESC;
# ----------------------------------------------------------------------------------------------------

-- 24.  QUAL FORMA DE PAGAMENTO MOVIMENTO MAIS DINHEIRO?
#Resultado: 
	-- Novamente o pix aparece aqui com um avglor total de R$ 188.341.30

SELECT forma_pagamento , SUM(valor) AS valor_total 
FROM pagamentos
GROUP BY forma_pagamento
ORDER BY valor_total DESC;                                        
# ----------------------------------------------------------------------------------------------------                                        

-- 25. QUANTOS PAGAMENTOS ESTÃO PENDENTES?
#Resultado: 
	-- 45 pagamentos estão pendentes

SELECT COUNT(*) AS pendentes FROM  pagamentos
WHERE status ='PENDENTE';
# ----------------------------------------------------------------------------------------------------                                        

-- 26. QUAL O VALOR TOTAL PENDENTE?
#Resultado: 
	-- Estamos com R$ 118.591.80 pra receber , estão pendentes!!!

SELECT  SUM(valor) AS total_pendente FROM  pagamentos
WHERE status ='PENDENTE';

                                  -- Bonus - Clientes que possuem pagamentos pendentes

SELECT c.id, c.nome,c.cidade,c.estado,SUM(pg.valor) AS valor_pendente
FROM clientes c
JOIN pedidos p
    ON p.cliente_id = c.id
JOIN pagamentos pg
    ON pg.pedido_id = p.id
WHERE pg.status = 'Pendente'
GROUP BY c.id,c.nome,c.cidade,c.estado
ORDER BY valor_pendente DESC; 
-- Essa consulta mostra os clientes com pagamentos pendentes , destque para 'leticia Costa' de Eusébio-CE que tem um pagamneto de 10489.50 a fazer!!
# ----------------------------------------------------------------------------------------------------                                        

                                                             -- ANÁLISE TEMPORAL
-- 27. QUANTO A EMPRESA VENDEU POR MÊS?
#Resultado: 
	-- Aqui vemos o resultado, das vendas por mes da empresa
    
-- mes   valor    
/*  1    54450.10
	2	36271.70
	3	35185.50
	4	46561.30
	5	35536.60
	6	31195.90
	7	50361.10
	8	35536.60
	9	31195.90
	10	41987.30
    */
SELECT YEAR(p.data_pedido) AS ano,
       MONTH(p.data_pedido) AS mes,
SUM(ip.quantidade * ip.preco_unitario) AS faturamento 
FROM pedidos p JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY YEAR(p.data_pedido), MONTH(p.data_pedido) 
ORDER BY mes , ano;                                          
# ----------------------------------------------------------------------------------------------------                                        

-- 28 QUAL MÊS TEVE O MAIOR FATURAMENTO?
#Resultado: 
	-- observamos que o mês 1(ou seja , janeiro) teve o maior faturamento com R$ 54450.10
    
SELECT MONTH(p.data_pedido) AS mes,
SUM(ip.quantidade * ip.preco_unitario) AS faturamento 
FROM pedidos p JOIN itens_pedido ip ON ip.pedido_id = p.id
GROUP BY  MONTH(p.data_pedido) 
ORDER BY faturamento DESC;
# ----------------------------------------------------------------------------------------------------      

-- 29. QUAL MES TEVE MAIS PEDIDOS?
#Resultado: 
	-- Janeiro foi o mês com mais pedidos 
    
 SELECT MONTH(p.data_pedido) AS mes,
 YEAR(p.data_pedido) AS ano , COUNT(DISTINCT p.id) AS total_pedidos
 FROM pedidos p JOIN itens_pedido ip ON ip.pedido_id = p.id
 GROUP BY MONTH(p.data_pedido) , YEAR(p.data_pedido)
 ORDER BY total_pedidos DESC;
# ----------------------------------------------------------------------------------------------------      

-- 30. AS VENDAS ESTÃO CRESCENDO OU DIMINUINDO? 	
#Resultado: 
	 /*
As vendas apresentam comportamento oscilante ao longo de 2025,
sem uma tendência contínua de crescimento.
O maior crescimento mensal ocorreu em julho, com aumento de 61,43%
em relação a junho. Já a maior queda ocorreu em fevereiro,
quando o faturamento diminuiu 33,39% em relação a janeiro.
O maior faturamento do período analisado ocorreu em janeiro,
com R$ 54.450,10.
*/

WITH vendas_mensais AS (
    SELECT
        YEAR(p.data_pedido) AS ano,
        MONTH(p.data_pedido) AS mes,
        SUM(ip.quantidade * ip.preco_unitario) AS faturamento
    FROM pedidos p
    JOIN itens_pedido ip
        ON ip.pedido_id = p.id
    GROUP BY
        YEAR(p.data_pedido),
        MONTH(p.data_pedido)
)
SELECT
    ano,
    mes,
    ROUND(faturamento, 2) AS faturamento,

    ROUND(
        LAG(faturamento) OVER (
            ORDER BY ano, mes
        ),
        2
    ) AS faturamento_mes_anterior,

    ROUND(
        faturamento - LAG(faturamento) OVER (
            ORDER BY ano, mes
        ),
        2
    ) AS variacao,

    ROUND(
        (
            (faturamento - LAG(faturamento) OVER (
                ORDER BY ano, mes
            ))
            / LAG(faturamento) OVER (
                ORDER BY ano, mes
            )
        ) * 100,
        2
    ) AS variacao_percentual

FROM vendas_mensais
ORDER BY ano, mes;


