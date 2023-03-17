--scott

-- Desc : emp 테이블 구성 보기 
-- 필드명(열이름)   제약조건      데이터 타입
-- EMPNO(사원번호)  NOT NULL     NUMBER(4)
-- ENAME(사원명),  JOB(직책), MRG(직속상관번호), HIREDATE(입사일), SAL(급여), COMM(수당), DEPTNO(부서 번호)
-- NUMBER : 숫자(소수점 자리수 포함)
-- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2) : 전체 자릿수는 8자리이고 소수점 자리를 2 포함한다.
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장 가능
-- DATE : 날짜 데이터

Desc emp;

-- DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
Desc dept;

-- GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
Desc salgrade;

-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두개 이상의 테이블을 사용하여 조회)
-- SELECT 열이름1, 열이름 2.... (조회할 열이 전체라면 *로 처리)
-- FROM 테이블명;

-- 1. EMP 테이블의 전체 열을 조회
select * from emp;
-- 2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
select EMPNO, ENAME, SAL from emp;