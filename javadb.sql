-- javadb

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4자리)), birthYear(년도-숫자(4)), addr(주소-문자(한글, 숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약 조건명은 pk_userTBL)
CREATE TABLE userTBL(
no number(4)CONSTRAINT pk_userTBL PRIMARY KEY,
username nchar(10) not null,
birthYear number(4) not null,
addr VARCHAR2(50) not null,
mobile NVARCHAR2(20));

drop table userTBL;

-- select(서브쿼리, 조인) + DML(insert, delete, update)
-- 전체 조회
select * from usertbl;
-- 개별 조회(특정 번호, 특정 이름...)
-- 여러행이 나오는 형태인가? 하나의 행이 나오는 형태인가?
select * from userTBL where no=1;
select * from userTBL where username='홍길동';

-- like : _ or %
select * from userTBL where username like '_길동%';

--insert into 테이블명(필드명1, 필드명2...)
--values();

-- update 테이블명 set 업데이트할 필드명=값,... where 조건;

-- delete from 테이블명 where 조건

-- 시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE user_seq; 

-- insert 
-- no : user_seq 값 넣기
-- scott 3180행
insert into userTBL(no, username, birthYear, addr, mobile) values(user_seq.NEXTVAL, '홍길동', '2010','서울시 종로구 123','010-1234-5678' );

commit;

-- 모든 컬럼은 not null
-- paytype : pay_no(숫자 - 1, pk), info(문자-card, cash)
-- paytype_seq 생성
create table paytype(
pay_no number(1) PRIMARY KEY,
info VARCHAR2(10) not null
);

CREATE SEQUENCE paytype_seq; 

insert into paytype values(paytype_seq.NEXTVAL, 'card');
insert into paytype values(paytype_seq.NEXTVAL, 'cash');

select * from paytype;  -- 1 : card, 2 : cash


-- shop
-- suser : user_id(number(4), pk), name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조해서 사용 부모-자식 관계 테이블)
create TABLE suser(
user_id number(4) PRIMARY key,
name varchar2(20) not null,
pay_no number(1) not null REFERENCES paytype(pay_no)
);

-- product
-- product_id(숫자-8, pk), pname(문자), price(숫자), content(문자)

create TABLE product(
product_id number(8) PRIMARY KEY,
pname varchar2(30) not null,
price number(8) not null,
content VARCHAR2(50) not null
);

ALTER TABLE product MODIFY
    content VARCHAR2(50) not null;

CREATE SEQUENCE product_seq; 

-- sorder
-- order_id(숫자-8, pk), user_id(suser 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
-- order_seq 생성
create TABLE sorder(
order_id number(8) PRIMARY KEY,
user_id number(4) not null REFERENCES suser(user_id),
product_id number(8) not null REFERENCES product(product_id)
);

alter table sorder add order_date DATE;  -- 구매날짜

CREATE SEQUENCE order_seq; 

-- user_id, name, pay_no, info
select u.user_id, u.name, u.pay_no, p.info 
from suser u, paytype p 
where u.pay_no = p.pay_no and u.user_id=1000;

select * from sorder;

-- 주문 목록 조회
-- user_id, name, card/cash, product_id, pname, price, content

-- 기준 sorder
-- suser 테이블 : name, 
-- paytype 테이블 : card/cash
-- product 테이블 : product_id, pname, price, content

SELECT s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
FROM sorder s, suser u, paytype t, product p
WHERE s.user_id = u.user_id and u.pay_no = t.pay_no AND s.product_id = p.product_id;

-- 홍길동 주문 목록
SELECT s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
FROM sorder s, suser u, paytype t, product p
WHERE s.user_id = u.user_id and u.pay_no = t.pay_no AND s.product_id = p.product_id and s.user_id = 1000;

-- 도서 테이블
-- code,title, writer, price
-- code : 1001(pk)
-- title : '자바의 신' 
-- writer : '홍길동'
-- price : 25000

-- bookTBL 생성

create table bookTBL(
    code number(4) primary key,
    title nvarchar2(50) not null,
    writer nvarchar2(20) not null,
    price number(8,2) not null
);

insert into booktbl(code, title, writer, price) values(1001, '이것이 자바다', '신용균', 25000);
insert into booktbl(code, title, writer, price) values(1002, '자바의 신', '강신용', 25000);
insert into booktbl(code, title, writer, price) values(1003, '오라클로 배우는 데이터베이스', '이지훈', 28000);
insert into booktbl(code, title, writer, price) values(1004, '자바 100제', '김용만', 29000);
insert into booktbl(code, title, writer, price) values(1005, '자바 프로그래밍 입문', '박은종', 30000);

commit;

alter table booktbl add description nvarchar2(100);

-- member 테이블
-- userid (영어,숫자,특수문자) 최대 12 허용 pk
-- password (영어,숫자,특수문자) 최대 15 허용
-- name (한글)
-- gender (한글 -남/여)
-- email (적절한 크기)

create table memberTbl(
    userid varchar2(12) primary key,
    password varchar2(20) not null,
    name nvarchar2(10) not null,
    gender nvarchar2(2) not null,
    email varchar2(50) not null
);

insert into membertbl values('hong123', 'hong123@', '홍길동', '남', 'hong123@gmail.com');

commit;

select * from membertbl;

-- 게시판
-- 글번호(bno, 숫자, 시퀀스 삽입, pk(pk_board)), 작성자(name, 한글), 비밀번호(password, 숫자, 영문자), 제목(title, 한글), 내용(content, 한글),
-- 파일첨부(attach 파일명), 답변글 작성 시 참조되는 글 번호(re_ref, 숫자), 답변글 레벨(re_lev, 숫자), 답변 글 순서(re_seq, 숫자)
-- 조회수(cnt, 숫자, default 0 지정), 작성날짜(regdate, default로 sysdate 지정)

create table board(
    bno NUMBER(8) constraint pk_board primary key,
    name nvarchar2(10) not null,
    password varchar2(10) not null,
    title nvarchar2(50) not null,
    content nvarchar2(1000) not null,
    attach nvarchar2(100),
    re_ref number(8) not null,
    re_lev number(8) not null,
    re_seq number(8) not null,
    cnt number(8) default 0,
    regdate date default sysdate
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

select * from board;

-- 서브쿼리
insert into board(bno, name, password,title,content,re_ref,re_lev,re_seq)
(select board_seq.nextval,name,password,title,content,board_seq.currval,re_lev,re_seq from board);

commit;

-- 댓글
-- re_ref , re_lev , re_seq
-- 원본글 작성 re_ref : bno 값과 동일
--              re_lev : 0, re_seq : 0

select bno, title, re_ref , re_lev , re_seq from board where bno=129;

-- re_ref : 그룹 번호, re_seq : 그룹 내에서 댓글의 순서,
-- re_lev : 그룹 내에서 댓글의 깊이(원본글의 댓글인지 댓글의 댓글인지?)

-- 댓글도 새글임 => insert 작업
--                  bno : board_seq.nextval
--                  re_ref : 원본 글의 re_ref 값과 동일
--                  re_seq : 원본 글의 re_seq + 1
--                  re_lev : 원본 글의 re_lev + 1

-- 첫번째 댓글
insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글','게시글 댓글',null,129,1,1);

-- 가장 최신글과 댓글 가져오기(+ re_seq asc : 댓글의 최신)
select bno, title, re_ref , re_lev , re_seq from board where re_ref=129 order by re_seq;

-- 두번째 댓글
-- re_seq 가 값이 작을수록 최신글임

-- 기존 댓글이 있는가? 기존 댓글의 re_seq 변경을 한 후 insert 작업 해야 함
-- update 구문에서 where 절은 re_ref 는 원본 글의 re_ref값, re_seq 비교 구문은 원본글의 re_seq 값과 비교, re_seq의 부모값은 0이니 0 쓰기

update board set re_seq = re_seq + 1 where re_ref = 129 and re_seq > 0;

insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','Re : 게시글2','게시글 댓글2',null,129,1,1);

delete from board where bno = 142;

-- 댓글의 댓글 작성
-- update / insert

update board set re_seq = re_seq + 1 where re_ref = 129 and re_seq > 2;

insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq) 
values(board_seq.nextval,'김댓글','12345','ReRe : 게시글','댓글의 댓글',null,129,2,3);

commit;

-- 페이지 나누기
-- rownum : 조회된 결과에 번호를 매겨줌
--          order by 구문에 index가 들어가지 않는다면 제대로 된 결과를 보장하지 않음
--          pk가 index로 사용됨
select rownum, bno, title from board order by bno desc;

select rownum, bno, title, re_ref , re_lev , re_seq from board order by re_ref desc, re_seq asc;

-- 위의 문장 해결방안
-- order by 구문을 먼저 실행한 후 rownum 붙여야함

select rownum, bno, title, re_ref , re_lev , re_seq
from(select bno, title, re_ref , re_lev , re_seq from board order by re_ref desc, re_seq asc)
where rownum <=30;

-- 한 페이지에 30개의 목록을 보여준다 할 때
-- 1 2 3 4 5 ......
-- 1 page 요청 (1 ~ 30)
-- 2 page 요청 (31 ~ 60)
-- 3 page 요청 (61 ~ 90)

select *
from(select rownum rnum, bno, title, re_ref , re_lev , re_seq
    from(select bno, title, re_ref , re_lev , re_seq 
        from board order by re_ref desc, re_seq asc)
    where rownum <=90)
where rnum > 60;

select *
from(select rownum rnum, bno, title, re_ref , re_lev , re_seq
    from(select bno, title, re_ref , re_lev , re_seq 
        from board order by re_ref desc, re_seq asc)
    where rownum <=?)
where rnum > ?;

-- 1 page : rnum > 0, rownum <= 30
-- 2 page : rnum > 30, rownum <= 60
-- 3 page : rnum > 60, rownum <= 90

-- 1,2,3
-- rownum 값 : 페이지번호 * 한 페이지에 보여줄 목록 개수
-- rnum 값 : (페이지번호-1) * 한 페이지에 보여줄 목록 개수

-- spring_board
-- bno 숫자 (10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date default 로 현재 시스템날짜
-- updatedate date default로 현재 시스템 날짜

-- 시퀀스 seq_board

create table spring_board(
    bno NUMBER(10) constraint pk_spring_board primary key,
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

CREATE SEQUENCE seq_board;