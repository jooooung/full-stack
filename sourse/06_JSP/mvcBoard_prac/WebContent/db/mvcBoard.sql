-- TABLE & SEQUENCE DROP
DROP TABLE MVC_BOARD2;
DROP SEQUENCE MVC_BOARD_SEQ2;
-- TABLE & SEQUENCE CREATE 
CREATE SEQUENCE MVC_BOARD_SEQ2
    MAXVALUE 999999
    NOCACHE
    NOCYCLE;
CREATE TABLE MVC_BOARD2(
    bID NUMBER(6),
    bNAME VARCHAR2(50) NOT NULL,
    bTITLE VARCHAR2(100) NOT NULL,
    bCONTENT VARCHAR2(1000),
    bDATE DATE DEFAULT SYSDATE NOT NULL,    -- 작성일
    bHIT NUMBER(6) DEFAULT 0 NOT NULL,      -- 조회수
    bGROUP NUMBER(6) NOT NULL,   -- 글그룹(원글=BID, 답글=원글의 BGROUP)
    bSTEP NUMBER(3) NOT NULL,    -- 그룹내 출력순서
    bINDENT NUMBER(3) NOT NULL,  -- 들여쓰기
    bIP VARCHAR2(20) NOT NULL, 
    PRIMARY KEY(bID)
);
-- DUMMY DATA
    -- 원글
INSERT INTO MVC_BOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ2.NEXTVAL, '홍', '제목', NULL, MVC_BOARD_SEQ2.CURRVAL, 0, 0, '192.1.1.1');
INSERT INTO MVC_BOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ2.NEXTVAL, '김', '제목2', NULL, MVC_BOARD_SEQ2.CURRVAL, 0, 0, '192.1.1.2');
    -- 2번글 답글
INSERT INTO MVC_BOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ2.NEXTVAL, '이', '답2-1', '답', 2, 1, 2, '192.1.1.3');
-- DAO에 들어갈 QUERY
    -- 1. 글목록(페이징)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* FROM
            (SELECT * FROM MVC_BOARD2 ORDER BY BGROUP DESC, BINDENT) A)
    WHERE RN BETWEEN 1 AND 5;
    -- 2. 글개수
SELECT COUNT(*) FROM MVC_BOARD2;
    -- 3. 글쓰기(원글)
INSERT INTO MVC_BOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ2.NEXTVAL, '박', '제목', NULL, MVC_BOARD_SEQ2.CURRVAL, 0, 0, '192.1.1.5');    
    -- 4. bID로 조회수 올리기
UPDATE MVC_BOARD2 SET BHIT = BHIT + 1 WHERE BID=1;    
    -- 5. 글 상세보기, 글수정VIEW, 답변글VIEW(bID로 DTO가져오기)
SELECT * FROM MVC_BOARD2 WHERE BID=2;    
    -- 6. 글 수정하기
UPDATE MVC_BOARD2 
    SET BNAME='홍수정',
        BTITLE='제목수정',
        BCONTENT='본문수정',
        BIP='192.1.2.3'
    WHERE BID=1;
    -- 7. 글삭제
DELETE FROM MVC_BOARD2 WHERE BID=4;
    -- 8. 답변글 저장전 작업(답변이 있다면 그 답변의 STEP을 +1)
UPDATE MVC_BOARD2 SET BSTEP=BSTEP+1
    WHERE BGROUP=2 AND BSTEP > 0;
    -- 9. 답변글 쓰기 (3번 답글)
INSERT INTO MVC_BOARD2 (BID, BNAME, BTITLE, BCONTENT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ2.NEXTVAL, '지', '답3-1', '답', 3, 1, 1, '192.1.1.7');