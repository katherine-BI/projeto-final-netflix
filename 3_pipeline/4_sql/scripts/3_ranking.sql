SELECT
    tg.genero,
    tp.pais,
    COUNT(tp.id) AS qtd_shows
FROM tb_generos tg

JOIN tb_pais tp
    ON tg.id = tp.id
    
GROUP BY tp.pais, tg.genero
ORDER BY tp.pais, qtd_shows DESC;