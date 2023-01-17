-- ���̺� �� ������ ����
DROP TABLE PERSON;
DROP TABLE JOB;
DROP SEQUENCE pNO_SEQ;
-- ���̺� �� ������ ����
CREATE TABLE JOB (  -- JOB
    jNO NUMBER(2) PRIMARY KEY,
    jNAME VARCHAR2(50)
);
CREATE TABLE PERSON (   -- PERSON
    pNO NUMBER(5) PRIMARY KEY,
    pNAME VARCHAR2(50) NOT NULL,
    jNO NUMBER(2) REFERENCES JOB(jNO),
    KOR NUMBER(3)CHECK(KOR>=0),
    ENG NUMBER(3)CHECK(ENG>=0),
    MAT NUMBER(3)CHECK(MAT>=0)  
);
DROP SEQUENCE pNO_SEQ;
CREATE SEQUENCE pNO_SEQ MAXVALUE 99999 NOCACHE;  -- pNO_SEQ

-- ���̵����� insert
INSERT INTO JOB VALUES (10, '���');
INSERT INTO JOB VALUES (20, '����');  -- JOB
INSERT INTO PERSON VALUES (pNO_SEQ.NEXTVAL, '���켺', 10, 90, 80, 81); 
INSERT INTO PERSON VALUES (pNO_SEQ.NEXTVAL, '�ڼ���', 10, 80, 90, 80);
INSERT INTO PERSON VALUES (pNO_SEQ.NEXTVAL, '�����', 20, 20, 90, 90);
INSERT INTO PERSON VALUES (pNO_SEQ.NEXTVAL, '������', 20, 95, 95, 95);
INSERT INTO PERSON VALUES (pNO_SEQ.NEXTVAL, '������', 10, 100, 100, 100);
SELECT * FROM JOB;
SELECT * FROM PERSON;
-- ��ɺ� query �ۼ� (1, 2, 3)
-- 1. person �Է�
INSERT INTO PERSON 
    VALUES (pNO_SEQ.NEXTVAL, '������', (SELECT JNO FROM JOB WHERE JNAME='���'), 100, 100, 100);
--delete from person where pno=6;
-- 2. ������ ��ȸ
SELECT ROWNUM RN, A.* 
    FROM (SELECT pNAME||'('||pNO||'��)' pNO, jNAME, KOR, ENG, MAT, (KOR+ENG+MAT) SUM 
            FROM PERSON P, JOB J WHERE P.jNO=J.jNO AND jNAME='���'
             ORDER BY SUM DESC) A
   ;
-- 3. ��ü ��ȸ
SELECT ROWNUM RN, A.* 
    FROM (SELECT pNAME||'('||pNO||'��)' pNO, jNAME, KOR, ENG, MAT, (KOR+ENG+MAT) SUM 
            FROM PERSON P, JOB J WHERE P.jNO=J.jNO 
            ORDER BY SUM DESC) A;
SELECT JNAME FROM JOB;
commit;