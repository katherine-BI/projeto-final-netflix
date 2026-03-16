SELECT
    CAST(REPLACE(nt.ano_lancamento, ',', '') AS INTEGER) AS ano,
    tg.genero,
    COUNT(tg.id) AS qtd_shows
FROM netflix_titles nt

JOIN tb_generos tg 
    ON nt.id = tg.id
    
GROUP BY tg.genero, ano
ORDER BY ano DESC, qtd_shows DESC;