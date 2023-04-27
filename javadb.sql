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