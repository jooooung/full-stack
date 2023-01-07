-- Supermarket
DROP TABLE CUSTOMER;
DROP TABLE LEVELS;
DROP SEQUENCE CUSTOMER_CID_SQ;

CREATE TABLE LEVELS (
    LEVELNO NUMBER(3) PRIMARY KEY,
    LEVELNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE CUSTOMER (
    CID NUMBER(5) PRIMARY KEY,
    CTEL VARCHAR2(50) NOT NULL,
    CNAME VARCHAR2(20) NOT NULL,
    CPOINT NUMBER(8) DEFAULT 1000,
    CAMOUNT NUMBER(9) DEFAULT 0,
    LEVELUP NUMBER(9),
    LEVELNO NUMBER(3) DEFAULT 1,
    FOREIGN KEY (LEVELNO) REFERENCES LEVELS(LEVELNO),
    CHECK(CPOINT>=0),
    CHECK(CAMOUNT>=0)
);

CREATE SEQUENCE CUSTOMER_CID_SQ MAXVALUE 99999 NOCACHE NOCYCLE;

INSERT INTO LEVELS VALUES (1, 'NORMAL');
INSERT INTO LEVELS VALUES (2, 'SILVER');
INSERT INTO LEVELS VALUES (3, 'GOLD');
INSERT INTO LEVELS VALUES (4, 'VIP');
INSERT INTO LEVELS VALUES (5, 'VVIP');

-- 더미데이터
INSERT INTO CUSTOMER (CID, CTEL, CNAME, CAMOUNT)
    VALUES (CUSTOMER_CID_SQ.NEXTVAL, '010-3333-3333', '흥부', 100000);
INSERT INTO CUSTOMER (CID, CTEL, CNAME, CAMOUNT)
    VALUES (CUSTOMER_CID_SQ.NEXTVAL, '010-3333-9999', '놀부', 10000000);
    
SELECT * FROM LEVELS;
SELECT * FROM CUSTOMER;
COMMIT;

-- 1. 회원가입
INSERT INTO CUSTOMER (CID, CTEL, CNAME) 
    VALUES (CUSTOMER_CID_SQ.NEXTVAL, '010-1234-1234', '김수호');
    
-- 2. 폰4자리(FULL) 검색
SELECT * FROM CUSTOMER WHERE CTEL LIKE '%1234'
    ORDER BY CAMOUNT DESC;
    
-- 3. 물품구입
UPDATE CUSTOMER SET CAMOUNT = CAMOUNT+20000, CPOINT = CPOINT + (20000*0.05)
    WHERE CID = 1;