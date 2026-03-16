# 📊 Netflix Movies – Análise de Portfólio

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-green?logo=pandas)
![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-ML-orange?logo=scikitlearn)
![Tableau](https://img.shields.io/badge/Tableau-Data%20Viz-orange?logo=tableau)
![SQLite](https://img.shields.io/badge/SQLite-Database-lightgrey?logo=sqlite)
![Google%20Sheets](https://img.shields.io/badge/Google%20Sheets-Analysis-brightgreen?logo=googlesheets)
![Status](https://img.shields.io/badge/Status-Finalizado-success)

## 📌 Overview
Projeto desenvolvido pelo **Squad Katherine Johnson** no Bootcamp de **Business Intelligence da WoMakersCode**, em parceria com a **Localiza**.

A iniciativa utiliza o dataset **Netflix Movies and TV Shows**, disponibilizado no Kaggle, e aplica técnicas de **tratamento de dados, enriquecimento via API, modelagem analítica, visualização e Machine Learning** para explorar padrões e tendências no catálogo da plataforma.


## 🎯 Objetivo
Transformar dados brutos do catálogo da Netflix em **informações estruturadas e análises exploratórias**, permitindo identificar padrões relacionados a **gêneros, duração, classificação indicativa, países e tendências do catálogo ao longo do tempo**.

## 🧩 Estrutura

O projeto foi desenvolvido em **7 etapas sequenciais**, cobrindo desde a definição do problema até a análise exploratória e modelagem analítica. Recomenda-se explorar os arquivos seguindo a ordem abaixo.

---

### 1️⃣ 🔹 Definição de Objetivo, MVP e criação de Plano de Curadoria

📄 Arquivo: *(plano_curadoria.pdf)*

Na primeira etapa, definimos como MVP do projeto as seguintes entregas:

- **Enriquecimento de dados via API (TMDB)** para complementar informações ausentes como diretor, elenco e país.
- **Pipeline de ETL em Python utilizando Prefect**, responsável pela extração, transformação e geração do dataset final estruturado.
- **Modelagem e consultas analíticas em SQLite**, incluindo normalização de gêneros e países e criação de rankings analíticos.
- **Análises exploratórias e estatísticas**, investigando padrões do catálogo como distribuição de títulos, evolução temporal e correlações entre variáveis.
- **Modelagem de Machine Learning (K-Means)** para identificar clusters de filmes com características semelhantes, considerando duração, classificação indicativa e gêneros.
- **Dashboard analítico em Tableau**, reunindo visualizações e indicadores sobre o catálogo da plataforma.

Também foi elaborado o baseline de um **Plano de Curadoria de Dados e Políticas de Retenção**, estabelecendo diretrizes para o tratamento, padronização e manutenção da qualidade das informações utilizadas. Ao longo do desenvolvimento, esse documento foi **atualizado para incorporar decisões técnicas**, incluindo estratégias de enriquecimento de dados, padronização de campos e critérios de retenção de dados históricos.

---

### 2️⃣ 🔹 Enriquecimento via API

📄 Notebook: *(enriquecimento_api.ipynb)*

📄 Arquivo de saída: *(df_netflix_enriquecido)*

Nesta etapa analisamos os dados presentes no dataset e definimos como estratégia o **enriquecimento com dados externos**.  Para isto, foi utilizada a **API do TMDB (The Movie Database)** por oferecer uma base mais completa e compatível com as colunas necessárias para o projeto.

#### 📝 Como obter e usar a chave da API

1. Acesse:  
https://www.themoviedb.org  

2. Crie uma conta gratuita.

3. Vá em:  
`Settings → API → Create / Generate API Key`

4. Aceite os termos e gere sua **API Key**.

5. No notebook `02_enriquecimento_api.ipynb`, insira sua chave entre as aspas:

```python
API_KEY = ""
```

### 3️⃣ 🔹 Criação de categorias sazonais + Pipeline ETL

📄 Notebook: *(pipeline_automatizado_netflix.ipynb)*

📄 Arquivo de saída: *(dataset_final)*

Nesta etapa foi criada uma **pipeline de ETL em Python utilizando Prefect** para processar o dataset enriquecido da Netflix.

O pipeline executa as seguintes etapas:

**Extração**
- Leitura do dataset `df_netflix_enriquecido.csv`

**Limpeza de dados**
- Remoção de duplicatas (`drop_duplicates`)
- Remoção da coluna `description`
- Padronização de valores `null` e `unknown` para `"Não Informado"`

**Enriquecimento**
- Integração com dados obtidos via **API** (diretor, elenco e país)

**Padronização**
- Conversão de nomes de países para códigos **ISO alpha-2** utilizando `pycountry`
- Padronização da **classificação indicativa**

**Transformação**
- Conversão de tipos de dados (datas, categorias e textos)

**Feature Engineering**
- Criação das colunas:
  - `duracao_em_min`
  - `temporadas`
  - `estacao` (baseada nas estações do ano no Brasil)

**Tradução**
- Nomes das colunas traduzidos para **português**

**Carga**
- Geração do dataset final: `dataset_final.csv`

O pipeline também implementa **logging estruturado com Loguru**, permitindo monitorar cada etapa do processo e gerar registros para auditoria da execução.

  ### 4️⃣ 🔹 Ranking de gêneros no SQL
  
  📄 Notebook para criação do database: *(criacao_db_netflix.ipynb)*
  
  📄 Base de dados: *(database_netflix)*
  
  Scripts disponíveis em:
    4_sql/
    ├── criacao_db_netflix.ipynb
    ├── database_netflix.db
    └── scripts/
        ├── criar_tb_geneos.sql
        ├── criar_tb_pais.sql
        └──...

O banco de dados foi criado a partir do mesmo dataset utilizado nas etapas anteriores.

Nesta etapa utilizamos **SQLite** para:

- Normalizar o campo `listed_in`, separando os **gêneros em linhas individuais**
- Normalizar o campo `country`, separando os **países em linhas individuais**
- Criar **CTEs recursivas** para tratar e expandir os gêneros
- Criar **CTEs recursivas** para tratar e expandir os países
- Criar as tabelas `tb_generos` e `tb_paises`, onde são armazenados os valores normalizados
- Aplicar **JOIN com a tabela principal**

A partir disso foram geradas análises como:

- **Ranking de gêneros por país**, com base na quantidade de títulos
- **Quantidade de shows adicionados ao catálogo por ano em cada país**
- **Quantidade de shows adicionados ao catálogo por ano em cada gênero**

### 5️⃣ 🔹 Análises no Google Sheets

📄 Arquivo: *netflix_sheets*  

Nesta etapa foram realizadas análises exploratórias utilizando **Google Sheets**. 

Uma das perguntas elaboradas durante o projeto foi se havia relação entre **data de adição na plataforma** e **duração dos filmes**. O coeficiente de correlação encontrado foi **0.11627986781**, indicando uma **correlação  baixa**. Isso sugere que **não existe relação relevante entre a duração dos filmes e a data em que foram adicionados à plataforma**.

Também foram criadas visualizações para observar:

- Distribuição de títulos por **ano de lançamento**
- Evolução do **catálogo ao longo do tempo**

### 6️⃣ 🔹 Dashboard analítico
📄 Dashboard: *(dashboard_netflix)*
🔗 Link: -----

Criação de um **dashboard analítico em Tableau** para visualização dos principais insights do dataset, incluindo:

- Distribuição de títulos por **gênero**
- Evolução do **catálogo ao longo do tempo**
- **Duração média** por tipo de conteúdo
- Distribuição por **país**
- **Classificação indicativa**
- Parâmetros para alternar visualização de séries e filmes

### 7️⃣ 🔹 Clusterização e matriz de correlação

📄 Notebook: *(ml_netflix.ipynb)*

Nesta etapa foi realizada uma **análise exploratória e modelagem de clusters** utilizando o dataset tratado na etapa 5 (`dataset_final.csv`).

O objetivo foi **identificar agrupamentos de filmes semelhantes**, considerando características como **duração, classificação indicativa e gêneros**.

Principais atividades:

- **EDA (Exploratory Data Analysis)** para investigar relações entre classificação indicativa e duração
- Cálculo de **correlação de Spearman**
- Preparação dos dados para modelagem:
  - Conversão da classificação indicativa
  - Normalização das variáveis utilizando **StandardScaler**
- Aplicação de **K-Means Clustering**
- Definição do número ideal de clusters com **Elbow Method**
- Nova clusterização incorporando os **10 gêneros mais frequentes**
- Visualização dos clusters com **scatterplots e heatmaps**
- Redução de dimensionalidade utilizando **PCA (Principal Component Analysis)**

Ao final, foi possível identificar **perfis de filmes com base em duração média, classificação indicativa e gêneros predominantes**.

### 📊 Análise complementar: Top 10 Netflix (Tudum)

📄 Notebook: *(analises_complementares.ipynb)*

Além das etapas obrigatórias, foi realizada uma análise complementar utilizando o dataset público do **Top 10 semanal da Netflix (Tudum)**, filtrado para o **Brasil**. Os dados foram separados entre **filmes e séries**, identificando os títulos com maior presença no ranking ao longo dos anos. Em seguida, foram cruzados com o dataset do projeto, permitindo analisar:

- Quais **gêneros aparecem com mais frequência entre os conteúdos mais assistidos**
- Quais **classificações indicativas predominam no Top 10**
  
## 🛠️ Tecnologias Utilizadas

- Python  
- Pandas  
- NumPy  
- Prefect  
- Loguru  
- Requests  
- Time  
- Matplotlib  
- Seaborn  
- Plotly Express  
- Scikit-learn  
- PyCountry  
- SQLite (DBeaver)  
- Google Sheets  
- Tableau  

---

## 📂 Fonte dos Dados

**Dataset principal (Kaggle)**  
[Netflix Movies and TV Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)

**API de enriquecimento de dados**  
[The Movie Database (TMDB)](https://www.themoviedb.org/)

---

## 👩‍💻 Autoria

Projeto desenvolvido pelas integrantes do **Squad Katherine Johnson**:
- **Ana Clara de Souza Cruz** — [GitHub](https://github.com/AnaClaraCruz1) | [LinkedIn](https://www.linkedin.com/in/anaclaracruz-dev/)
- **Anita Flávia Gomes de Souza** — [GitHub](https://github.com/anitaflaviagsouza) | [LinkedIn](https://www.linkedin.com/in/anita-flavia-gomes-de-souza/)
- **Belmira Leite dos Reis Valle** — [GitHub](https://github.com/belmira-valle) | [LinkedIn](https://www.linkedin.com/in/vallebelmira/)
- **Paula Chidiac Schuster** — [GitHub](https://github.com/paula-chidiac) | [LinkedIn](https://www.linkedin.com/in/paula-chidiac-schuster/)
- **Thainara Meneghelli** — [GitHub](https://github.com/ithanara) | [LinkedIn](https://www.linkedin.com/in/thainara-meneghelli/)
  
