#  Análise de Vendas e Desempenho Comercial com SQL

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![Database](https://img.shields.io/badge/Database-MySQL-orange)


##  Sobre o Projeto

Este projeto consiste em uma análise exploratória de dados relacionais de uma empresa do setor varejista e e-commerce. O objetivo principal foi extrair **insights estratégicos** a partir do histórico de vendas para apoiar a tomada de decisão nas áreas comercial, de estoque, gestão de clientes e planejamento financeiro. *(Nota: Os dados utilizados neste projeto são fictícios e foram estruturados para fins de estudo).*

A análise foi estruturada em 30 consultas SQL divididas em 7 dimensões do negócio:
1. **Desempenho Comercial Geral**
2. **Análise de Clientes**
3. **Análise de Produtos e Estoque**
4. **Análise de Categorias**
5. **Desempenho da Equipe de Vendas**
6. **Análise Financeira e Pagamentos**
7. **Análise Temporal e Tendências**



##  Tecnologias Utilizadas

* **SQL (Structured Query Language):** Consultas complexas, junções (`JOINs`), agregações (`GROUP BY`), condicionais (`CASE WHEN`) e funções de janela (`WINDOW FUNCTIONS` com `LAG`).
* **Git & GitHub:** Versionamento de código e documentação do projeto.



##  Estrutura do Banco de Dados

O modelo relacional é composto pelas seguintes tabelas:
* `clientes`: Cadastro de clientes e localização geográfica.
* `pedidos`: Registro dos pedidos, datas e vínculo com cliente e vendedor.
* `itens_pedido`: Detalhamento dos produtos por pedido, quantidades e preços unitários.
* `produtos`: Catálogo de produtos, preços de venda, custos e níveis de estoque.
* `categorias`: Classificação dos produtos.
* `vendedores`: Cadastro da equipe comercial.
* `pagamentos`: Meios de pagamento, valores e status da transação.



##  Principais Insights e Recomendações de Negócio

### 1. Desempenho Comercial

> **Métricas Principais:**
> * **Faturamento Total:** R$ 398.282,00
> * **Volume Total:** 150 pedidos (300 itens faturados)
> * **Ticket Médio:** R$ 2.655,21
> * **Preço Médio do Item:** R$ 1.300,37
> * **Média de Itens por Pedido:** 2,0 itens/pedido

**Insights de Negócio:**
* **Impacto de Vendas de Alto Valor:** O maior pedido isolado (ID 27, no valor de R$ 5.799,80) superou o ticket médio em **2,18 vezes**. Isso mostra que vendas pontuais de produtos *premium* ou volumes corporativos causam grande impacto na receita final.
* **Comportamento Multi-item:** A média de 2 itens por pedido indica uma disposição natural do consumidor para compras combinadas no mesmo checkout.

**Ações Recomendadas:**
* **Criação de Kits e Combos:** Desenvolver kits promocionais unindo produtos complementares para incentivar o acréscimo de um 3º item no carrinho, elevando o ticket médio.
* **Estratégia de Upsell:** Criar abordagens comerciais focadas nos produtos de maior valor para clientes com histórico de compras acima de R$ 5.000,00.



### 2. Análise de Clientes e Comportamento de Compra

> **Métricas Principais:**
> * **Base de Clientes Ativos:** 100% da base cadastrada realizou ao menos 1 compra (0 clientes inativos).
> * **Frequência de Compra:** 50% dos clientes realizaram 2 pedidos; os outros 50% realizaram apenas 1 pedido.
> * **Maior Gasto Acumulado (LTV):** Leticia Costa (R$ 10.489,60) e Helena Rocha (R$ 10.089,60).

**Insights de Negócio:**
* **Gargalo na Recorrência:** O teto de frequência é de **apenas 2 pedidos por cliente**. Não existem compradores recorrentes de longo prazo (3 ou mais compras), sinalizando baixa retenção pós-segunda compra ou ciclo de recompra longo.
* **Perfis de Ticket Distintos:** Livia Martins registrou o maior ticket médio por pedido individual (R$ 5.799,80), demonstrando a presença de perfis de compradores que exigem tratamento comercial diferenciado.
* **Alerta Crítico de Inadimplência:** A cliente com maior faturamento acumulado (Leticia Costa, com R$ 10.489,60) possui R$ 10.489,50 com status **PENDENTE**. O cliente de maior valor teórico representa também o maior risco atual de caixa.

**Ações Recomendadas:**
* **Programa de Fidelidade e Reativação:** Criar réguas de comunicação pós-venda automatizadas para engajar compradores após a 2ª compra.
* **Política de Crédito e Cobrança:** Ajustar a régua preventiva de cobrança e restringir novos pedidos para contas com pendências financeiras expressivas.
* **Atendimento VIP:** Canal de atendimento direto para o Top 10 Clientes em faturamento.



### 3. Análise de Produtos e Estoque

> **Métricas Principais:**
> * **Campeão de Vendas (Volume):** Headset Gamer (10 unidades).
> * **Líderes de Faturamento:** iPhone 15 (R$ 34.999,00) e PC Gamer Ryzen 5 (R$ 32.199,00).
> * **Maior Margem Unitária:** iPhone 15 (R$ 1.199,90/unidade) e PC Gamer Ryzen 5 (R$ 1.099,90/unidade).
> * **Produtos sem Giro:** Caderno de 200 Folhas e Agenda 2026 (0 vendas).

**Insights de Negócio:**
* **Divergência entre Volume e Receita:** Periféricos como o *Headset Gamer* puxam o volume físico, mas o faturamento real é sustentado por itens de alto valor das linhas *Tech* e *Consoles*.
* **Risco de Ruptura de Estoque :** Produtos cruciais de alta margem (*Xbox Series X*, *PlayStation 5* e *Geladeira Frost Free*) estão com estoque crítico (abaixo de 10 unidades).
* **Capital Parado em Papelaria:** Itens como *Caderno* e *Agenda* não registraram vendas, demonstrando desalinhamento com o perfil do público-alvo focado em tecnologia.

**Ações Recomendadas:**
* **Reposicionamento de Estoque:** Priorizar a compra e reposição imediata de *Consoles* e *Eletrodomésticos* de alta demanda.
* **Liquidação e Ajuste de Mix:** Liquidar a linha de papelaria para liberar espaço logístico e redefinir o catálogo com foco em acessórios eletrônicos.
* **Venda Cruzada (Cross-Selling):** Utilizar o *Headset Gamer* como item de atração em ofertas combinadas com *Notebooks* e *PCs Gamer*.



### 4. Análise de Categorias

> **Métricas Principais:**
> * **Campeã de Volume:** Escritório (maior quantidade de itens vendidos).
> * **Líder de Faturamento:** Informática (R$ 103.596,50 gerados).
> * **Líder em Margem Total:** Informática (R$ 26.246,50 de margem acumulada).

**Insights de Negócio:**
* **Categoria "Isca" vs. "Geradora de Caixa":** A categoria *Escritório* atrai volume e tráfego com produtos de menor ticket, enquanto *Informática* responde por mais de 25% da receita total e gera a maior lucratividade do negócio.
* **Concentração de Margem:** O resultado financeiro global da empresa é altamente dependente da performance da categoria de Informática.

**Ações Recomendadas:**
* **Kits Transversais:** Unir o volume de vendas de *Escritório* para alavancar produtos de *Informática* (ex: organizadores de mesa vendidos junto com periféricos).
* **Foco do Orçamento de Marketing:** Direcionar a maior fatia da verba publicitária para a categoria de Informática, onde o retorno sobre a margem é maior.



### 5. Análise de Desempenho da Equipe de Vendas

> **Métricas Principais:**
> * **Volume de Atendimento:** Empate técnico — 10 vendedores realizaram 8 vendas e os demais realizaram 7 vendas.
> * **Líder em Faturamento Geral:** Rafael Costa (R$ 23.892,70).
> * **Líder em Ticket Médio:** Thiago Nunes (R$ 3.148,34 por pedido).

**Insights de Negócio:**
* **Desconexão entre Volume e Faturamento:** A distribuição de clientes atendidos é uniforme entre os vendedores (7 a 8 pedidos cada), porém a diferença na receita total gerada por cada um é expressiva.
* **Especialização Informal:** Vendedores como Thiago Nunes apresentam melhor desempenho no fechamento de produtos de alto ticket.
* **Capacidade de Padronização:** O volume similar de conversões mostra que o treinamento do time focado em técnicas de *upsell* pode elevar o faturamento geral sem necessidade de novos leads.

**Ações Recomendadas:**
* **Mentoria Interna:** Utilizar os processos de venda dos líderes de faturamento e ticket médio para treinar a equipe.
* **Revisão do Plano de Incentivos:** Alinhar as comissões para premiar não apenas o volume de pedidos, mas o valor médio gerado por venda.



### 6. Análise Financeira & Métodos de Pagamento

> **Métricas Principais:**
> * **Método Preferencial:** PIX (66 transações / R$ 188.341,30 movimentados).
> * **Volume de Pendências:** 45 pagamentos com status PENDENTE.
> * **Capital a Receber (Risco de Caixa):** R$ 118.591,80 em aberto.

**Insights de Negócio:**
* **Dominância do PIX:** O PIX é a escolha prioritária do cliente, respondendo por quase metade do faturamento. Isso otimiza o fluxo de caixa das vendas concluídas e reduz despesas com taxas operacionais de cartão.
* **Risco Operacional no Capital de Giro:** **29,7% da receita total** (R$ 118.591,80 de R$ 398.282,00) encontra-se pendente de confirmação.
* **Concentração em Contas Específicas:** A maior pendência individual está concentrada na principal cliente da empresa (Leticia Costa, em Eusébio-CE, com R$ 10.489,50 pendentes).

**Ações Recomendadas:**
* **Incentivo à Liquidação Rápida:** Oferecer pequenos descontos no checkout para pagamentos via PIX para reduzir o volume de pedidos que ficam aguardando confirmação.
* **Régua de Cobrança e Bloqueio Preventivo:** Automatizar notificações de vencimento e suspender novos pedidos para cadastros com saldo em aberto expressivo.



### 7. Análise Temporal & Tendência de Crescimento

> **Métricas Principais:**
> * **Mês de Maior Faturamento:** Janeiro/2025 (R$ 54.450,10).
> * **Mês de Maior Volume:** Janeiro/2025.
> * **Maior Alta Mensal:** Julho (+61,43% em relação a junho).
> * **Maior Queda Mensal:** Fevereiro (-33,39% em relação a janeiro).

**Insights de Negócio:**
* **Comportamento Oscilante:** As vendas não apresentam uma tendência contínua de alta, mas sim ciclos de alta e baixa ao longo do ano (oscilando entre R$ 31 mil e R$ 54 mil).
* **Sazonalidade de Início e Meio do Ano:** Janeiro e Julho destacam-se como os picos de receita, impulsionados por renovações de início de ano e campanhas de meio de ano.

**Ações Recomendadas:**
* **Planejamento de Estoque Sazonal:** Antecipar compras para os meses de pico (Dezembro/Janeiro e Julho) evitando falta de produto.
* **Ações Promocionais em Meses de Baixa:** Criar ofertas direcionadas para suavizar as retrações observadas em fevereiro, junho e setembro.
* **Análise** Monitorar se os clientes adquiridos nos meses de pico retornam nos meses seguintes ou se realizam apenas uma compra pontual.



##  Conclusão Geral

A operação demonstra força comercial na categoria de **Informática** e grande eficiência no recebimento via **PIX**. Para sustentar o crescimento, a empresa deve focar em solucionar **três gargalos operacionais**:

1. **Gestão de Risco de Caixa:** Reduzir o índice de 29,7% de receitas pendentes.
2. **Retenção de Clientes:** Criar estratégias de recompra para aumentar a frequência além do teto atual de 2 pedidos por cliente.
3. **Previsibilidade de Receita:** Suavizar as oscilações mensais através de campanhas promocionais nos meses de menor movimento.



##  Como Executar o Projeto

1. Clone o repositório em sua máquina local:
```bash
git clone [https://github.com/MarleyDPaiva/projeto_analise-vendas-SQL.git](https://github.com/MarleyDPaiva/projeto_analise-vendas-SQL.git)
```
2. Abra seu gerenciador de banco de dados (MySQL Workbench, DBeaver, VS Code, etc.).
3. Execute o arquivo do schema/banco de dados para criar a estrutura das tabelas e inserir os dados.
4. Execute o arquivo `analises.sql` para rodar as 30 consultas e visualizar os resultados.

---
*Projeto desenvolvido para fins de estudos em Análise de Dados e SQL.*
