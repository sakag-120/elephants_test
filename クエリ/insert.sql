
INSERT INTO
    tbl_���޳ׯ���ڰ�KIT
	(�i�ڔԍ�,�i�ږ���,���l,�ˑ��^�C�v,ID)
SELECT
    '----------',
    'Piyo',
	'OP',
	'PB7',
	coalesce(MAX(ID)+1,1) 
FROM
    tbl_���޳ׯ���ڰ�KIT
WHERE
    NOT EXISTS(
        SELECT
            'X'
		FROM
            tbl_���޳ׯ���ڰ�KIT
        WHERE
            �ˑ��^�C�v = 'PB7'
    );

