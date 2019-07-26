
INSERT INTO
    tbl_ｼﾞﾄﾞｳﾗｯｶﾌﾟﾚｰﾄKIT
	(品目番号,品目名称,備考,架装タイプ,ID)
SELECT
    '----------',
    'Piyo',
	'OP',
	'PB7',
	coalesce(MAX(ID)+1,1) 
FROM
    tbl_ｼﾞﾄﾞｳﾗｯｶﾌﾟﾚｰﾄKIT
WHERE
    NOT EXISTS(
        SELECT
            'X'
		FROM
            tbl_ｼﾞﾄﾞｳﾗｯｶﾌﾟﾚｰﾄKIT
        WHERE
            架装タイプ = 'PB7'
    );

