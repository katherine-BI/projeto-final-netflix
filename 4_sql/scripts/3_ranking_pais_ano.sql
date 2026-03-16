SELECT
    CAST(REPLACE(nt.ano_lancamento, ',', '') AS INTEGER) AS ano,
    np.pais,
    COUNT(np.id) AS qtd_shows
FROM netflix_titles nt

JOIN tb_pais np 
    ON nt.id = np.id
    
GROUP BY np.pais, ano
ORDER BY qtd_shows DESC;