WITH RECURSIVE split(id, genero, restante) AS (
    SELECT
        id,
        '',
        genero || ','
    FROM netflix_titles

    UNION ALL

    SELECT
        id,
        trim(substr(restante, 1, instr(restante, ','))),
        substr(restante, instr(restante, ',') + 1)
    FROM split
    WHERE restante <> ''
)

INSERT INTO tb_generos (id, genero)
SELECT id, genero
FROM split
WHERE genero <> '';

SELECT * FROM tb_generos tg 
ORDER BY CAST(SUBSTR(id, 2) AS INTEGER)