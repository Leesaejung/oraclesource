-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두개 이상의 테이블을 사용하여 조회)
-- SELECT 열이름1, 열이름 2.... (조회할 열이 전체라면 *로 처리)
-- FROM 테이블명;

-- 1. EMP 테이블의 전체 열을 조회
select * from emp;


-- 2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
select EMPNO, ENAME, SAL from emp;



-- 3. DEPT 테이블 전체 조회
select * from DEPT;



-- 4. DEPT 테이블 안에 부서번호, 지역만 조회
select DEPTNO, LOC from DEPT;



-- 5. EMP 테이블 안의 부서번호 조회
select deptno from emp;


-- 6. EMP 테이블 안의 부서번호 조회(중복된 부서 번호는 제거)
select DISTINCT deptno from emp;

-- 열이 여러개인 경우 (묶어서 중복이냐 아니냐를 판단)
select DISTINCT job,deptno from emp;


-- 7. 연산
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
-- 새로운 칼럼 이름(필드명) 정하기, as는 필수가 아님, 공백 쓰고 싶을 때 " " 사용하기
select empno, ename, sal * 12 + comm as ANNSAL from emp;
select empno, ename 사원명, job "직 책", sal * 12 + comm ANNSAL from emp;

-- 8. 정렬 : ORDER BY
--           내림차순 => DESC, 오름차순 => ASC

-- 9 
-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬

select ename, sal from emp order by sal desc;

-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬

select ename, sal from emp order by sal; --asc 생략 가능 but desc는 생략하면 안됨

-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬

select * from emp ORDER by empno;

-- 전체 내용 출력하고, 결과가 부서번호의 오름차순, 급여의 내림차순으로 정렬

select * from emp ORDER by deptno, sal desc;

--[실습] emp 테이블의 모든 열을 출력    
-- empno -> employee_no
-- ename -> employee_name
-- mgr -> manager
-- sal -> salary
-- comm -> commision
-- deptno -> department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면 사원 이름을 기준으로 오름차순 정렬

-- 연산자 우선순위
-- 산술연산자 *. / 
-- 산술연산자 +. - 
-- 비교연산자
-- is null, is not null, like, in....
-- BETWEEN A AND B
-- NOT
-- AND
-- OR
-- 우선순위를 줘야 한다면 소괄호 사용 추천

select empno employee_no, ename employee_name, job, mgr manager, hiredate, sal salary, comm commision, deptno department_no from emp ORDER by deptno desc, ename;

-- where : 특정 조건을 기준으로 원하는 행을 조회
-- 부서번호가 30인 데이터만을 조회

select * from emp where deptno=30; -- = : 같다

-- 사원번호가 7782인 사원 조회

select * from emp where empno = 7782;

-- 부서번호가 30 이고, 사원직책이 SALESMAN인 행 조회

select * from emp where deptno = 30 and job='SALESMAN';

-- 사원번호가 7499이고, 부서번호가 30인 행 조회
select * from emp where empno = 7499 and deptno = 30;

-- 부서 번호가 30이거나, 사원 직책이 CLERK 인 행 조회
select * from emp where deptno = 30 or job = 'CLERK';

-- 산술연산자 : +,-,*,/, mod(나머지)
-- 비교연산자 : ?, >=, <, <=
-- 등가비교연산자 : =. !=, <>, ^= : A와 B값이 다를 경우 true, 같은 경우 false
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자
-- LIKE 연산자와 와일드카드 (_, %)
-- is NULL
-- 집합 연산자 : UNION, UNION ALL, MINUS ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)

--EMP 테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
select * from emp where sal*12 = 36000;

-- ename 이 F 이후의 문자로 시작하는 사원 조회
-- 문자 표현 시 ''만 사용
select * from emp where ename >= 'F';

-- job이 MANAGER, SALESMAN,  CLECRK인 사원 조회
select * from emp where job = 'MANAGER' or job = 'SALESMAN' or job='CLERK';

-- sel 이 3000이 아닌 사원 조회
select * from  emp where sal != 3000; --where sal <> 3000; where sal ^= 3000;

-- job이 MANAGER, SALESMAN,  CLECRK인 사원 조회(in 연산자)
select * from emp where job in('MANAGER','SALESMAN','CLERK');

-- job이 MANAGER, SALESMAN,  CLECRK인 사원이 아닌 사람을 조회
select * from emp where job not in('MANAGER' ,'SALESMAN' ,'CLERK');

-- 부서번호가 10, 20 사원 조회(in 사용)
select * from emp where deptno in(10,20);

-- 급여가 2000이상 3000이하인 사원 조회
select * from emp where sal >=2000 and sal <=3000;

-- BETWEEN A AND B
select * from emp where sal BETWEEN 2000 AND 3000;

-- 급여가 2000이상 3000이하가 아닌 사원 조회
select * from emp where sal not BETWEEN 2000 AND 3000;

--like연산자와 와일드 카드(_, %)
--사원 이름이 S로 시작하는 사원 정보 조회
select * from emp where ename like 'S%';
--사원 이름의 두번째 글자가 L인 사원만 조회
select * from emp where ename like '_L%';

-- _ : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
--% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

--사원 이름에 AM이 포함된 사원만 조회
select * from emp where ename like '%AM%';

--사원 이름에 AM이 포함되지 않은 사원만 조회
select * from emp where ename not like '%AM%';

-- NULL : 데이터 값이 완전 비어 있는 상태, 앞에 is 붙여줘야 함
-- = 을 사용할 수 없음

--comm이 null일 때
select * from emp where COMM is NULL;

--mgr이 null 일 때
select * from emp where mgr is null;

--mgr이 null이 아닐 때
select * from emp where mgr is not null;

-- 7. 연산
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
-- 새로운 칼럼 이름(필드명) 정하기, as는 필수가 아님, 공백 쓰고 싶을 때 " " 사용하기
select empno, ename, sal * 12 + comm as ANNSAL from emp;

-- 집합 연산자 : UNION, UNION ALL, MINUS ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)
-- UNION, UNION ALL : 합집합
-- UNION : 동일한 결과값인 경우 중복 제거, UNION ALL 중복 제거 안함
select empno, ename, sal, deptno from emp where deptno = 10 
UNION 
select empno, ename, sal, deptno from emp where deptno = 10;

select empno, ename, sal, deptno from emp where deptno = 10 
UNION ALL
select empno, ename, sal, deptno from emp where deptno = 10;

-- minus(차집합)
select empno, ename, sal, deptno from emp 
MINUS
select empno, ename, sal, deptno from emp where deptno = 10;

-- intersect (교집합)
select empno, ename, sal, deptno from emp 
INTERSECT
select empno, ename, sal, deptno from emp where deptno = 10;

-- EMP테이블에서 사원 이름이 S로 끝나는 사원 데이터 조회
select * from emp where ename like '%S';
-- EMP테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의 사원번호, 이름, 급여 조회(SAL 내림차순)
select empno, ename, sal from emp where deptno = 30 and job = 'SALESMAN' ORDER by sal desc;
-- EMP 테이블을 사용하여 20,30번 부서에서 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
-- 집합 연산자를 사용하는 방식과 사용하지 않는 방식 두가지를 사용한다.
select empno, ename, sal, deptno from emp where deptno in (20,30) and sal > 2000;

select empno, ename, sal, deptno from emp where deptno = 20 and sal > 2000
UNION
select empno, ename, sal, deptno from emp where deptno = 30 and sal > 2000;

select empno, ename, sal, deptno from emp where deptno in (20,30) and sal > 2000
MINUS
select empno, ename, sal, deptno from emp where deptno =10 and sal > 2000;

-- 사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000-2000 사이가 아닌 사원들의 이름
-- 사원번호, 급여, 부서번호를 조회하기
select empno, sal, deptno from emp where ename like '%E%' and deptno = 30 and sal NOT between 1000 and 2000;

-- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원 이름이
-- 두번째 글자가 L이 아닌 사원의 정보 조회
select * from emp where comm is null AND mgr is not null and job in('MANAGER', 'CLERK') and ename not like '_L%';

-- Oracle 함수
-- 오라클에서 기본적으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

-- 문자열 함수
--1. UPPER, LOWER, INITCAP
-- UPPER : 모두 대문자, LOWER : 모든 소문자, INITCAP : 첫 글자만 대문자
-- LIKE '%ORACLE%' OR '%oracle%' or like '%Oracle%' ==> 검색 시 사용

select ename, upper(ename), lower(ename), initcap(ename) from emp;

select * from emp where UPPER(ENAME) = 'FORD';

select * from emp where UPPER(ENAME) like UPPER('%ford%');

-- 2. length : 문자열 길이

select ename, length(ename) from emp;

-- 사원 이름의 길이가 5이상인 사원 조회

select ename, length(ename) from emp where length(ename) >= 5;

-- 한글일 때
-- dual : sys가 소유하는 테이블 (임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1byte, 한글 : 문자1 => 3byte
select length('한글') from dual;
select length('한글'),lengthb('한글')  from dual; --b가 실제 사용하는 byte
select length('한글'),lengthb('한글'),lengthb('ab') from dual;

-- 3) SUBSTR (문자열 데이터, 시작 위치, 추출길이) : 추출길이 생략 사능
-- 문자열 일부 추출
select job, substr(job,1,2),substr(job,3,2),substr(job,5) from emp;

select job, substr(job,1,2),substr(job,3,2),substr(job,5),substr(job,-3) from emp;

--Ename 세번째 글자부터 출력
select ename, substr(ename,3) from emp;

--4 INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
--INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작 위치에서 찾으려는 문자가 몇번인지 지칭(선택))
--HELLO, ORACLE 문자열에서 L 문자열 찾기
select instr('HELLO, ORACLE', 'L') as INSTR, instr('HELLO, ORACLE', 'L',5) as INSTR_2, instr('HELLO, ORACLE', 'L',2,2) as INSTR_3 from dual;

-- 5 replace: 특정 문자를 다른 문자로 변경
-- replace(문자열 데이터, 찾는 문자, 변경 문자)

-- 010-1234-5678 -를 반 문자열로 변경 / -를 없에기

select 010-1234-5678 as 변경전, replace('010-1234-5678','-',' ') as REPLACE1, replace('010-1234-5678','-') as replace_2 from dual;

-- '이것이 Oracle 이다', '이것이' => This is 변경
select '이것이 Oracle 이다' as 변경전, replace('이것이 Oracle 이다','이것이','This is') as REPLACE1 from dual; --원본 변경 x

-- 6. concat : 두 문자열 데이터 합치기
select concat(empno, ENAME) from emp;
-- 세개 이상으로 합치기
select concat(empno, concat(':', ENAME)) from emp;

-- || : 문자열 연결 연산자
select empno || ':' || ENAME from emp;

-- 7. Trim(양쪽), LTRIM(왼쪽), RTRIM(오른쪽) : 공백 포함 특정 문자 제거
-- '   ORACLE' = 'ORACLE'  => false
select '    이것이      ', TRIM('    이것이      ') from dual;

