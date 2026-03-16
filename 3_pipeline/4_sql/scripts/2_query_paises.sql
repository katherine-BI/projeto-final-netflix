WITH RECURSIVE split(id, pais, restante) AS (

    SELECT
        id,
        '',
        pais || ','   
    FROM netflix_titles

    UNION ALL
    
    SELECT
        id,
        trim(substr(restante, 0, instr(restante, ','))),
        substr(restante, instr(restante, ',') + 1)
    FROM split
    WHERE restante <> ''
)

INSERT INTO tb_pais (id, pais)
SELECT id, pais
FROM split
WHERE pais <> '';

SELECT * 
FROM tb_pais tp 