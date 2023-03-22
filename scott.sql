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
select empno employee_no, ename employee_name, job, mgr manager, hiredate, sal salary, comm commision, deptno department_no from emp ORDER by deptno desc, ename;

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

-- 2 숫자 함수
-- 1)round, trunc, ceil, floor, mod

--round : 반올림
--round(숫자, 반올림 위치(선택))
select 
    round(1234.5678) as round,      --소수점 첫째 자리에서 반올림
    round(1234.5678,0) as round0,    --소수점 첫째 자리에서 반올림
    round(1234.5678,1) as round1,   --소수점 둘째 자리에서 반올림
    round(1234.5678,2) as round2,   --소수점 셋째 자리에서 반올림
    round(1234.5678,-1) as round_minus1, --자연수 첫째 자리에서 반올림
    round(1234.5678,-2) as round_minus2  --자연수 둘째 자리에서 반올림
from
    dual;
    
-- trunc : 특정 위치에서 버리는 함수
-- trunc(숫자, 버림 위치(선택))
select 
    trunc(1234.5678) as trunc,      --소수점 첫째 자리에서 버림
    trunc(1234.5678,0) as trunc0,   --소수점 첫째 자리에서 버림
    trunc(1234.5678,1) as trunc1,   --소수점 둘째 자리에서 버림
    trunc(1234.5678,2) as trunc2,   --소수점 셋째 자리에서 버림
    trunc(1234.5678,-1) as trunc_minus1, --자연수 첫째 자리에서 버림
    trunc(1234.5678,-2) as trunc_minus2  --자연수 둘째 자리에서 버림
from
    dual;
    
--ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수
select ceil(3.14), floor(3.14), ceil(-3.14), floor(-3.14) from dual;

--mod(숫자, 나눌 수) : 나머지 값
select mod(15,6), mod(10,2), mod(11,2) from dual;


-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이

-- 날짜 데이터 + 날짜 데이터 : 연산불가

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재 날짜와 시간을 가져옴
select sysdate, sysdate-1 as yesterday, sysdate+1 as tomorrow from dual;

-- aa_months(날짜, 더할 개월수) : 몇개월 이후 날짜 구하기
select sysdate, add_months(sysdate,3) from dual;

-- 입사 50주년이 되는 날짜 구하기
select empno, ename, hiredate, add_months(hiredate, 600) from emp;

-- months_between(첫번째날짜, 두번째 날짜) : 두 날짜 데이터 간의 날짜 차이를 개월 수로 계산하여 출력
-- 입사 45년 미만인 사원 데이터 조회
-- empno, ename, hiredate
select empno, ename, hiredate from emp where months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜 출력
select sysdate, add_months(sysdate,6) from dual;

select empno, ename, hiredate, sysdate, 
    months_between(hiredate, sysdate) as months1,
    months_between(sysdate, hiredate) as months2,
    trunc(months_between(sysdate, hiredate)) as months3
from
    emp;
    
-- next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
select sysdate, next_day(sysdate,'금요일'), last_day(sysdate) from dual;

-- 날짜의 반올림, 버림 : round, trunc
-- CC : 네 자리 연도 끝 두자리를 기준으로 사용
--      2023(2050이하여서 2001년으로 계산)

select 
    sysdate, 
    round(sysdate,'CC') as format_cc, 
    round(sysdate,'YYYY') as format_yyyy, 
    round(sysdate,'DDD') as format_ddd, -- 12시를 기준으로 반올림
    round(sysdate,'HH') as format_hh -- 시간 기준 반올림
from 
    dual;

-- 형변환 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

select empno, ename, empno+'500' from emp where ename = 'FORD';

-- ORA-01722: 수치가 부적합합니다
-- 01722. 00000 -  "invalid number"
-- select empno, ename, 'abcd'+empno from emp where ename = 'FORD';

-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환 
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력 형태로 날짜 출력하기 to_char 주로 사용됨
-- MON, MONTH : 월 이름
-- DDD : 365일 중에서 며칠
select 
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') as 현재날짜시간,
    to_char(sysdate, 'YYYY/MM/DD') as 현재날짜,
    to_char(sysdate, 'YYYY') as 현재년도,
    to_char(sysdate, 'MM') as 현재월,
    to_char(sysdate, 'Mon') as 현재월1,
    to_char(sysdate, 'DD') as 현재일자,
    to_char(sysdate, 'DDD') as 현재일자1,
    to_char(sysdate, 'HH12:MI:SS AM') as 현재날짜시간1
from 
    dual;

-- sal 필드에  , 나 통화표시를 하고 싶다면?
-- L (local) 지역 화폐 단위 기호 붙여줌
select sal, to_char(sal, '$999,999') as sal_$, to_char(sal, 'L999,999') as sal_L from emp; --설치된 지역의 원 표시

-- to_number(문자열 데이터, 인식될 숫자형태)

select 1300 - '1500', '1300'+1500 from dual;
-- 자동 형변환 안되는 상황, ,가 들어가면 연산이 안되기 때문에 포멧을 정해줘서 형변환 시켜줘야 함
select to_number('1,300', '999,999') - to_number('1,500', '999,999') from dual;

-- to_date(문자열 데이터, '인식될 날짜 형태')
select 
    to_date('2018-07-14', 'YYYY-MM-DD') as TODATE1,
    to_date('20230320', 'YYYY-MM-DD') as TODATE2
from
    dual;
    

-- ORA-01722: 수치가 부적합합니다
--select '2023-03-21' - '2023-02-01' from dual;
select to_date('2023-03-21') - to_date('2023-02-01') from dual;

-- 널처리 함수
-- NULL +300 -> NULL
-- NVL(데이터, 널일 경우 반환할 데이터)
select empno, ename, sal, comm, sal+comm, nvl(comm, 0), sal+nvl(comm,0) from emp;

-- NVL2(데이터, 널이 아닐 경우 반환할 데이터, 널일 경우 반환할 데이터)
select 
    empno, 
    ename, 
    comm, 
    nvl2(comm, 'O', 'X'), 
    nvl2(comm, sal * 12 + comm, sal *12) as annsal 
from 
    emp;
    
-- DECODE함수 / CASE 문

-- DECODE(검사 대상이 될 데이터, 조건1, 조건1이 일치할 때 실행할 구문, 조건2, 조건2이 일치할 때 실행할 구문)

-- emp 테이블에서 직책이 MANAGER인 사람은 급여의 10% 인상
-- SALESMAN인 사람은 5%, ANALYST인 사람은 그대로, 나머지는 3% 인상된 급여 출력
select empno, ename, job, sal,
        decode(job, 'MANAGER', sal*1.1,
                    'SALESMAN', sal*1.05,
                    'ANALYST', sal, sal * 1.03) as upsal
from
    emp;
    
-- case()
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.1
        when 'SALESMAN' then sal*1.05
        when 'ANALYST' then sal
        else sal * 1.03
    end as upsal
from
    emp;
    
select empno, ename, job, sal,
    case 
        when comm is null then '해당사항 없음'
        when comm = 0 then '수당 없음'
        when comm > 0 then '수당 : '|| comm
    end as comm_text
from
    emp;

select * from emp; 

-- [실습1] 다음과 같은 결과가 나오도록 SQL문을 작성하시오.
-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 
-- 하루 근무 시간을 8시간으로 보았을 때 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다. 
-- 단, 하루 급여는 소수점 셋째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림하시오.
select empno, ename, sal, trunc(sal/21.5,2) as DAY_PAY, round(sal/21.5/8,1) as TIME_PAY from emp;

-- [실습2] EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 
-- 사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오. 
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하시오.
select empno, ename, hiredate, next_day(add_months(hiredate,3),'월요일') as R_JOB,
        NVL(to_char(comm), 'N/A') as COMM
from emp;

-- [실습3] EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오.
-- 직속상관의 사원 번호가 존재하지 않을 경우 : 0000
-- 직속상관의 사원 번호 앞 두자리가 75일 경우 : 5555
-- 직속상관의 사원 번호 앞 두자리가 76일 경우 : 6666
-- 직속상관의 사원 번호 앞 두자리가 77일 경우 : 7777
-- 직속상관의 사원 번호 앞 두자리가 78일 경우 : 8888
-- 그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원번호 그대로 출력

select empno, ename, mgr,
    case
            when mgr is null then '0000'
            when substr(mgr,1,2) = '75' then '5555'
            when substr(mgr,1,2) = '76' then '6666'
            when substr(mgr,1,2) = '77' then '7777'
            when substr(mgr,1,2) = '78' then '8888'
        else to_char(mgr)
    end as CHG_MGR      
from emp;

select empno, ename, mgr,
        decode(substr(to_char(mgr),1,2),
        null, '0000',
        '75', '5555',
        '76', '6666',
        '77', '7777',
        '78', '8888',
        substr(to_char(mgr),1)
        )as chg_mgr
from
    emp;


-- 다중행 함수

--select ename, sum(sal) from emp;  오류 발생

select sum(sal) from emp;

select sum(DISTINCT sal), sum(all sal), sum(sal) from emp;

-- 다중행 함수 : sum, count, max, min, avg
-- sum() : NULL을 제외하고 합계 출력
select sum(comm) from emp;

select count(sal) from emp;
select count(comm) from emp;

-- 행의 갯수
select count(*) from emp;
select count(*) from emp where deptno = 30;


select max(sal) from emp;
select max(hiredate) from emp;  --최신 날짜
select max(hiredate) from emp where deptno=20;  -- 부서번호가 20인 사원의 입사일 중 제일 최신 날짜

select min(hiredate) from emp;  --오래된 날짜
select min(hiredate) from emp where deptno=20;  -- 부서번호가 20인 사원의 입사일 중 제일 오래된 날짜

select avg(sal) from emp;
select avg(sal) from emp where deptno = 30;

-- group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기
select avg(sal) from emp where deptno = 10;
select avg(sal) from emp where deptno = 20;
select avg(sal) from emp where deptno = 30;

select deptno, avg(sal) from emp GROUP by deptno;

-- 부서별 추가수당 평균 구하기
select deptno, avg(comm) from emp group by deptno;

--select ename, deptno, avg(sal) from emp GROUP by deptno;  group by에 있는 것만 쓸 수 있으니 ename는 안됨

-- group by + having : group by 절에 조건을 줄 때
-- having : 그룹화된 대상을 출력 제한 걸 때
-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000 이상인 그룹만 출력)
-- deptno, job, 평균
select deptno, job, avg(sal) from emp group by deptno, job having avg(sal) >= 2000 order by deptno, job;

-- ORA-00934: 그룹 함수는 허가되지 않습니다
-- select deptno, job, avg(sal) from emp where avg(sal) >= 2000 group by deptno, job, order by deptno, job;

--1. from 구문 실행 -> 2. where 실행 -> 3. group by -> 4. having -> 5. select -> 6. order by
select deptno, job, avg(sal) from emp where sal <= 3000 group by deptno, job having avg(sal) >= 2000 order by deptno, job;

--[실습1] EMP 테이블을 이용하여 부서번호(DEPTNO), 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT)를 출력한다. 
--단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 SQL 문을 작성하시오.
select deptno, trunc(avg(sal)) AVG_SAL, max(sal) MAX_SAL, min(sal) MIN_SAL, count(*) from emp group by deptno order by deptno desc;

--[실습2] 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 SQL문을 작성하시오.
select job, count(*) from emp group by job having count(job) >=3;

-- [실습3] 사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력하는 SQL문 작성하시오.
select to_char(hiredate, 'YYYY') HIRE_YEAR, deptno, count(deptno) CNT from emp group by to_char(hiredate, 'YYYY'), deptno;

-- 조인 : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부 조인(Inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--   ① 등가조인 : 두개의 열이 일치할 때
--   ② 비등가조인 : 범위에 해당할 때 값 추출
--
-- 2) 외부 조인(Outer join)
--   ① left outer join
--   ② right outer join
--   ③ full outer join

-- dept는 4행, emp : 12행 -> 4*12 = 48행
-- 크로스 조인(나올 수 있는 모든 조합 추출)
select * from emp, dept order by empno;

-- ORA-00918: 열의 정의가 애매합니다
-- inner join
-- 찾아야 하는 값의 앞에 어느 테이블인지 명확하게 별칭해주기 e.empno, e.ename, d.deptno, d.dname, d.loc  //  emp e, dept d
select e.empno, e.ename, d.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno;

--조건 추가
select e.empno, e.ename, d.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno and sal >= 3000;

-- SQL-99 표준
-- join ~ on
select e.empno, e.ename, d.deptno, d.dname, d.loc from emp e join dept d on e.deptno = d.deptno;
--조건 추가 -1
select e.empno, e.ename, d.deptno, d.dname, d.loc from emp e join dept d on e.deptno = d.deptno and sal >= 3000;


-- 급여가 2500이하이고, 사원번호가 9999 이하인 사원정보 조회
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno and sal <= 2500 and e.empno <= 9999;

-- emp와 salgrade 조인
-- emp 테이블의 sal이 salgrade 테이블의 losal과 hisal 범위에 들어가는 형태 조인
select * from emp e, salgrade s where e.sal BETWEEN s.losal and s.hisal;

-- self join : 자기 자신 테이블과 조인
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno from emp e1, emp e2 where e1.mgr = e2.empno;

-- outer join

-- 1) left outer join
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1, emp e2 where e1.mgr = e2.empno(+);

-- 1) right outer join
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1, emp e2 where e1.mgr(+) = e2.empno;

--ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다
--select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1, emp e2 where e1.mgr(+) = e2.empno(+);

-- SQL-99 표준
-- join ~ on

select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1 left outer join emp e2 on e1.mgr = e2.empno;
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1 right outer join emp e2 on e1.mgr = e2.empno;
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename from emp e1 full outer join emp e2 on e1.mgr = e2.empno;

-- 연결 해야 할 테이블이 3개 일때
select * from table1 t1, table2 t2, table3 t3 
where t1.empno=t2.empno and t2.deptno = t3.deptno;

select * from table1 t1 join table2 t2 on t1.empno = t2.empno join table3 t3 on t2.deptno = t3.deptno;

--[실습1] 급여가 2000초과인 사원들의 부서 정보, 사원 정보를 아래와 같이 출력하는 SQL 문을 작성하시오.
select d.deptno, d.dname, e.empno, e.ename, e.sal from dept d , emp e where d.deptno=e.deptno and e.sal > 2000;
-- SQL-99 방식
select d.deptno, d.dname, e.empno, e.ename, e.sal from dept d join emp e on d.deptno=e.deptno where e.sal > 2000;

--[실습2] 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하는 SQL문을 작성하시오.
select d.deptno, d.dname, trunc(avg(e.sal)) as avg_sal, max(e.sal) as max_sal, min(e.sal) as min_sal, count(*) as cnt
from dept d, emp e where d.deptno =  e.deptno group by d.deptno, d.dname; 
-- SQL-99 방식
select d.deptno, d.dname, trunc(avg(e.sal)) as avg_sal, max(e.sal) as max_sal, min(e.sal) as min_sal, count(*) as cnt
from dept d join emp e on d.deptno =  e.deptno group by d.deptno, d.dname;

--[실습3] 모든 부서정보와 사원 정보를 아래와 같이 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문을 작성하시오.
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where d.deptno = e.deptno(+);
-- SQL-99 방식
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left outer join emp e
on d.deptno = e.deptno(+);

-- 서브 쿼리
-- sql 문을 실행하는데 필요한 데이터를 추가로 조회하기 위해 sql 문 내부에서 사용하는 select 문
--
--select 조회할 열
--from 테이블명
--where 조건식(select 조회할 열 from 테이블 where 조건식)

-- 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행 반환
-- =, >, <, >=, <=, <>, ^=

-- 존스의 급여보다 높은 급여를 받는 사원 조회
-- jones 급여 알아내기 / 알아낸 jones 급여를 가지고 조건식

select sal from emp where ename = 'JONES'; --2975 ↓
select * from emp where sal > 2975;

select * from emp where sal > (select sal from emp where ename = 'JONES');

-- 사원 이름이 ALLEN인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회
select * from emp where comm > (select comm from emp where ename = 'ALLEN');

-- 사원 이름이 WARD인 사원의 입사일 보다 빨리 입사한 사원 조회
select * from emp where hiredate < (select hiredate from emp where ename = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서 정보 조회
-- 사원 번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno
where e.deptno = 20 and e.sal > (select avg(sal) from emp);

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서 정보 조회
-- 사원 번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno
where e.deptno = 20 and e.sal <= (select avg(sal) from emp);

-- 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
-- in, any(some), all, exists 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

--각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회

-- 각 부서별 최고 급여
select deptno, max(sal) from emp group by deptno;
--ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--select * from emp where sal = (select max(sal) from emp group by deptno);

-- IN : 메인쿼리 결과가 서브쿼리 결과 2중 하나라도 일치하면 true
select * from emp where sal in (select max(sal) from emp group by deptno);

--30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회
-- ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나 이상이면 TRUE
select * from emp where sal < any (select sal from emp where deptno = 30);
select * from emp where sal < some (select sal from emp where deptno = 30);

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임
select * from emp where sal < (select max(sal) from emp where deptno = 30);

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회

-- ① 단일행 서브쿼리
select * from emp where sal > (select min(sal) from emp where deptno = 30);
-- ② 다중행 서브쿼리
select * from emp where sal > any (select sal from emp where deptno = 30);

-- all : 서브쿼리 결과가 조건식에 맞아 떨어져야지만 메인쿼리 조건식이 true
select * from emp where sal < all (select sal from emp where deptno = 30);
--EXISIT 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 true
select * from emp where EXISTS (select dname from dept where deptno = 10);
select * from emp where EXISTS (select dname from dept where deptno = 50);

-- [실습1] 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
SELECT
    e.job,
    e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND job = (
        SELECT
            job
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    ); 
    
--[실습2] 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문을 작성하시오
--(단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하기)
SELECT
    e.empno,
    e.ename,
    d.dname,
    e.hiredate,
    d.loc,
    e.sal,
    s.grade
FROM
    emp      e,
    dept     d,
    salgrade s
WHERE
        e.deptno = d.deptno
    AND e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    )
ORDER BY
    e.sal DESC,
    e.empno ASC;
    
-- 다중열 서브쿼리 : 서브쿼리의 select 절에 비교할 데이터를 여러 개 지정
select * from emp where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);

-- from 절에 사용하는 서브쿼리(인라인 뷰)
-- from 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
select e10.empno, e10.ename, e10. deptno, d.dname, d.loc
from (select * from emp where deptno = 10) e10,
     (select * from dept) d
where e10.deptno = d.deptno;

-- select 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- select 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야함
select empno, ename, job, sal, 
        (select grade from salgrade where e.sal between losal and hisal) as salgrade,
        deptno, 
        (select dname from dept where e.deptno = dept.deptno) As dname
from emp e;

-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10 and e.job not in(select job from emp where deptno = 30);

-- [실습2] 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력하는 SQL문을 작성하시오
-- (단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원번호를 기준으로 오름차순 정렬하여 출력하시오.)
-- 단일행 서브쿼리
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal and e.sal > (select max(sal) from emp where job = 'SALESMAN') order by e.empno;

select e.empno, e.ename, e.sal, (select grade from salgrade where e.sal between losal and hisal) as grade
from emp e
where e.sal > (select max(sal) from emp where job = 'SALESMAN') order by e.empno;

-- 다중행 함수 사용 시
select e.empno, e.ename, e.sal, (select grade from salgrade where e.sal between losal and hisal) as grade
from emp e
where e.sal > all(select sal from emp where job = 'SALESMAN') order by e.empno;