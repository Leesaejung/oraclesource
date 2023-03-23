-- select : 데이터 조회
-- 조회 방식 : 셀렉션(행 단위로 조회), 프로젝션(열 단위로 조회), 조인(두개 이상의 테이블을 사용하여 조회)
-- SELECT 열이름1, 열이름 2.... (조회할 열이 전체라면 *로 처리)
-- FROM 테이블명;

-- 1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;


-- 2. EMP 테이블에서 사원번호, 이름, 급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;



-- 3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;



-- 4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;



-- 5. EMP 테이블 안의 부서번호 조회
SELECT
    deptno
FROM
    emp;


-- 6. EMP 테이블 안의 부서번호 조회(중복된 부서 번호는 제거)
SELECT DISTINCT
    deptno
FROM
    emp;

-- 열이 여러개인 경우 (묶어서 중복이냐 아니냐를 판단)
SELECT DISTINCT
    job,
    deptno
FROM
    emp;


-- 7. 연산
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
-- 새로운 칼럼 이름(필드명) 정하기, as는 필수가 아님, 공백 쓰고 싶을 때 " " 사용하기
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;

-- 8. 정렬 : ORDER BY
--           내림차순 => DESC, 오름차순 => ASC

-- 9 
-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;

-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal; --asc 생략 가능 but desc는 생략하면 안됨

-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬

SELECT
    *
FROM
    emp
ORDER BY
    empno;

-- 전체 내용 출력하고, 결과가 부서번호의 오름차순, 급여의 내림차순으로 정렬

SELECT
    *
FROM
    emp
ORDER BY
    deptno,
    sal DESC;

--[실습] emp 테이블의 모든 열을 출력    
-- empno -> employee_no
-- ename -> employee_name
-- mgr -> manager
-- sal -> salary
-- comm -> commision
-- deptno -> department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면 사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  employee_no,
    ename  employee_name,
    job,
    mgr    manager,
    hiredate,
    sal    salary,
    comm   commision,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename;

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

SELECT
    *
FROM
    emp
WHERE
    deptno = 30; -- = : 같다

-- 사원번호가 7782인 사원 조회

SELECT
    *
FROM
    emp
WHERE
    empno = 7782;

-- 부서번호가 30 이고, 사원직책이 SALESMAN인 행 조회

SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';

-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;

-- 부서 번호가 30이거나, 사원 직책이 CLERK 인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';

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
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;

-- ename 이 F 이후의 문자로 시작하는 사원 조회
-- 문자 표현 시 ''만 사용
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

-- job이 MANAGER, SALESMAN,  CLECRK인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

-- sel 이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000; --where sal <> 3000; where sal ^= 3000;

-- job이 MANAGER, SALESMAN,  CLECRK인 사원 조회(in 연산자)
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- job이 MANAGER, SALESMAN,  CLECRK인 사원이 아닌 사람을 조회
SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- 부서번호가 10, 20 사원 조회(in 사용)
SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );

-- 급여가 2000이상 3000이하인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;

-- BETWEEN A AND B
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

-- 급여가 2000이상 3000이하가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;

--like연산자와 와일드 카드(_, %)
--사원 이름이 S로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';
--사원 이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%';

-- _ : 어떤 값이든 상관없이 한개의 문자 데이터를 의미
--% : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미

--사원 이름에 AM이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%';

--사원 이름에 AM이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%';

-- NULL : 데이터 값이 완전 비어 있는 상태, 앞에 is 붙여줘야 함
-- = 을 사용할 수 없음

--comm이 null일 때
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

--mgr이 null 일 때
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

--mgr이 null이 아닐 때
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;

-- 7. 연산
-- 사원들의 1년 연봉 구하기 ( SAL * 12 + COMM )
-- 새로운 칼럼 이름(필드명) 정하기, as는 필수가 아님, 공백 쓰고 싶을 때 " " 사용하기
SELECT
    empno,
    ename,
    sal * 12 + comm AS annsal
FROM
    emp;

-- 집합 연산자 : UNION, UNION ALL, MINUS ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)
-- UNION, UNION ALL : 합집합
-- UNION : 동일한 결과값인 경우 중복 제거, UNION ALL 중복 제거 안함
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

-- minus(차집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

-- intersect (교집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

-- EMP테이블에서 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';
-- EMP테이블에서 30번 부서에 근무하는 사원 중에서 직책이 SALESMAN인 사원의 사원번호, 이름, 급여 조회(SAL 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;
-- EMP 테이블을 사용하여 20,30번 부서에서 근무하고 있는 사원 중 급여가 2000 초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
-- 집합 연산자를 사용하는 방식과 사용하지 않는 방식 두가지를 사용한다.
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 10
    AND sal > 2000;

-- 사원 이름에 E가 포함되어 있는 30번 부서 사원 중 급여가 1000-2000 사이가 아닌 사원들의 이름
-- 사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 1000 AND 2000;

-- 추가 수당이 존재하지 않으며, 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원 이름이
-- 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';

-- Oracle 함수
-- 오라클에서 기본적으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수

-- 문자열 함수
--1. UPPER, LOWER, INITCAP
-- UPPER : 모두 대문자, LOWER : 모든 소문자, INITCAP : 첫 글자만 대문자
-- LIKE '%ORACLE%' OR '%oracle%' or like '%Oracle%' ==> 검색 시 사용

SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';

SELECT
    *
FROM
    emp
WHERE
    upper(ename) LIKE upper('%ford%');

-- 2. length : 문자열 길이

SELECT
    ename,
    length(ename)
FROM
    emp;

-- 사원 이름의 길이가 5이상인 사원 조회

SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;

-- 한글일 때
-- dual : sys가 소유하는 테이블 (임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1byte, 한글 : 문자1 => 3byte
SELECT
    length('한글')
FROM
    dual;

SELECT
    length('한글'),
    lengthb('한글')
FROM
    dual; --b가 실제 사용하는 byte
SELECT
    length('한글'),
    lengthb('한글'),
    lengthb('ab')
FROM
    dual;

-- 3) SUBSTR (문자열 데이터, 시작 위치, 추출길이) : 추출길이 생략 사능
-- 문자열 일부 추출
SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5)
FROM
    emp;

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5),
    substr(job, - 3)
FROM
    emp;

--Ename 세번째 글자부터 출력
SELECT
    ename,
    substr(ename, 3)
FROM
    emp;

--4 INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
--INSTR(대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택), 시작 위치에서 찾으려는 문자가 몇번인지 지칭(선택))
--HELLO, ORACLE 문자열에서 L 문자열 찾기
SELECT
    instr('HELLO, ORACLE', 'L')       AS instr,
    instr('HELLO, ORACLE', 'L', 5)    AS instr_2,
    instr('HELLO, ORACLE', 'L', 2, 2) AS instr_3
FROM
    dual;

-- 5 replace: 특정 문자를 다른 문자로 변경
-- replace(문자열 데이터, 찾는 문자, 변경 문자)

-- 010-1234-5678 -를 반 문자열로 변경 / -를 없에기

SELECT
    010 - 1234 - 5678                  AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace1,
    replace('010-1234-5678', '-')      AS replace_2
FROM
    dual;

-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT
    '이것이 Oracle 이다'                            AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is') AS replace1
FROM
    dual; --원본 변경 x

-- 6. concat : 두 문자열 데이터 합치기
SELECT
    concat(empno, ename)
FROM
    emp;
-- 세개 이상으로 합치기
SELECT
    concat(empno,
           concat(':', ename))
FROM
    emp;

-- || : 문자열 연결 연산자
SELECT
    empno
    || ':'
    || ename
FROM
    emp;

-- 7. Trim(양쪽), LTRIM(왼쪽), RTRIM(오른쪽) : 공백 포함 특정 문자 제거
-- '   ORACLE' = 'ORACLE'  => false
SELECT
    '    이것이      ',
    TRIM('    이것이      ')
FROM
    dual;

-- 2 숫자 함수
-- 1)round, trunc, ceil, floor, mod

--round : 반올림
--round(숫자, 반올림 위치(선택))
SELECT
    round(1234.5678)      AS round,      --소수점 첫째 자리에서 반올림
    round(1234.5678, 0)   AS round0,    --소수점 첫째 자리에서 반올림
    round(1234.5678, 1)   AS round1,   --소수점 둘째 자리에서 반올림
    round(1234.5678, 2)   AS round2,   --소수점 셋째 자리에서 반올림
    round(1234.5678, - 1) AS round_minus1, --자연수 첫째 자리에서 반올림
    round(1234.5678, - 2) AS round_minus2  --자연수 둘째 자리에서 반올림
FROM
    dual;
    
-- trunc : 특정 위치에서 버리는 함수
-- trunc(숫자, 버림 위치(선택))
SELECT
    trunc(1234.5678)      AS trunc,      --소수점 첫째 자리에서 버림
    trunc(1234.5678, 0)   AS trunc0,   --소수점 첫째 자리에서 버림
    trunc(1234.5678, 1)   AS trunc1,   --소수점 둘째 자리에서 버림
    trunc(1234.5678, 2)   AS trunc2,   --소수점 셋째 자리에서 버림
    trunc(1234.5678, - 1) AS trunc_minus1, --자연수 첫째 자리에서 버림
    trunc(1234.5678, - 2) AS trunc_minus2  --자연수 둘째 자리에서 버림
FROM
    dual;
    
--ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수
SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;

--mod(숫자, 나눌 수) : 나머지 값
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;


-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이

-- 날짜 데이터 + 날짜 데이터 : 연산불가

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재 날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;

-- aa_months(날짜, 더할 개월수) : 몇개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

-- 입사 50주년이 되는 날짜 구하기
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;

-- months_between(첫번째날짜, 두번째 날짜) : 두 날짜 데이터 간의 날짜 차이를 개월 수로 계산하여 출력
-- 입사 45년 미만인 사원 데이터 조회
-- empno, ename, hiredate
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
-- next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

-- 날짜의 반올림, 버림 : round, trunc
-- CC : 네 자리 연도 끝 두자리를 기준으로 사용
--      2023(2050이하여서 2001년으로 계산)

SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd, -- 12시를 기준으로 반올림
    round(sysdate, 'HH')   AS format_hh -- 시간 기준 반올림
FROM
    dual;

-- 형변환 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

-- ORA-01722: 수치가 부적합합니다
-- 01722. 00000 -  "invalid number"
-- select empno, ename, 'abcd'+empno from emp where ename = 'FORD';

-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환 
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력 형태로 날짜 출력하기 to_char 주로 사용됨
-- MON, MONTH : 월 이름
-- DDD : 365일 중에서 며칠
SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간,
    to_char(sysdate, 'YYYY/MM/DD')            AS 현재날짜,
    to_char(sysdate, 'YYYY')                  AS 현재년도,
    to_char(sysdate, 'MM')                    AS 현재월,
    to_char(sysdate, 'Mon')                   AS 현재월1,
    to_char(sysdate, 'DD')                    AS 현재일자,
    to_char(sysdate, 'DDD')                   AS 현재일자1,
    to_char(sysdate, 'HH12:MI:SS AM')         AS 현재날짜시간1
FROM
    dual;

-- sal 필드에  , 나 통화표시를 하고 싶다면?
-- L (local) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp; --설치된 지역의 원 표시

-- to_number(문자열 데이터, 인식될 숫자형태)

SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;
-- 자동 형변환 안되는 상황, ,가 들어가면 연산이 안되기 때문에 포멧을 정해줘서 형변환 시켜줘야 함
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;

-- to_date(문자열 데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20230320', 'YYYY-MM-DD')   AS todate2
FROM
    dual;
    

-- ORA-01722: 수치가 부적합합니다
--select '2023-03-21' - '2023-02-01' from dual;
SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;

-- 널처리 함수
-- NULL +300 -> NULL
-- NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

-- NVL2(데이터, 널이 아닐 경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
-- DECODE함수 / CASE 문

-- DECODE(검사 대상이 될 데이터, 조건1, 조건1이 일치할 때 실행할 구문, 조건2, 조건2이 일치할 때 실행할 구문)

-- emp 테이블에서 직책이 MANAGER인 사람은 급여의 10% 인상
-- SALESMAN인 사람은 5%, ANALYST인 사람은 그대로, 나머지는 3% 인상된 급여 출력
SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;
    
-- case()
SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당 없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;

SELECT
    *
FROM
    emp; 

-- [실습1] 다음과 같은 결과가 나오도록 SQL문을 작성하시오.
-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 
-- 하루 근무 시간을 8시간으로 보았을 때 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다. 
-- 단, 하루 급여는 소수점 셋째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림하시오.
SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)     AS day_pay,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;

-- [실습2] EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 
-- 사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오. 
-- 단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하시오.
SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;

-- [실습3] EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오.
-- 직속상관의 사원 번호가 존재하지 않을 경우 : 0000
-- 직속상관의 사원 번호 앞 두자리가 75일 경우 : 5555
-- 직속상관의 사원 번호 앞 두자리가 76일 경우 : 6666
-- 직속상관의 사원 번호 앞 두자리가 77일 경우 : 7777
-- 직속상관의 사원 번호 앞 두자리가 78일 경우 : 8888
-- 그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원번호 그대로 출력

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(mgr, 1, 2) = '75' THEN
            '5555'
        WHEN substr(mgr, 1, 2) = '76' THEN
            '6666'
        WHEN substr(mgr, 1, 2) = '77' THEN
            '7777'
        WHEN substr(mgr, 1, 2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;

SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),
                  1,
                  2),
           NULL,
           '0000',
           '75',
           '5555',
           '76',
           '6666',
           '77',
           '7777',
           '78',
           '8888',
           substr(to_char(mgr),
                  1)) AS chg_mgr
FROM
    emp;


-- 다중행 함수

--select ename, sum(sal) from emp;  오류 발생

SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

-- 다중행 함수 : sum, count, max, min, avg
-- sum() : NULL을 제외하고 합계 출력
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(sal)
FROM
    emp;

SELECT
    COUNT(comm)
FROM
    emp;

-- 행의 갯수
SELECT
    COUNT(*)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    MAX(sal)
FROM
    emp;

SELECT
    MAX(hiredate)
FROM
    emp;  --최신 날짜
SELECT
    MAX(hiredate)
FROM
    emp
WHERE
    deptno = 20;  -- 부서번호가 20인 사원의 입사일 중 제일 최신 날짜

SELECT
    MIN(hiredate)
FROM
    emp;  --오래된 날짜
SELECT
    MIN(hiredate)
FROM
    emp
WHERE
    deptno = 20;  -- 부서번호가 20인 사원의 입사일 중 제일 오래된 날짜

SELECT
    AVG(sal)
FROM
    emp;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

-- group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 10;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    deptno,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno;

-- 부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;

--select ename, deptno, avg(sal) from emp GROUP by deptno;  group by에 있는 것만 쓸 수 있으니 ename는 안됨

-- group by + having : group by 절에 조건을 줄 때
-- having : 그룹화된 대상을 출력 제한 걸 때
-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000 이상인 그룹만 출력)
-- deptno, job, 평균
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

-- ORA-00934: 그룹 함수는 허가되지 않습니다
-- select deptno, job, avg(sal) from emp where avg(sal) >= 2000 group by deptno, job, order by deptno, job;

--1. from 구문 실행 -> 2. where 실행 -> 3. group by -> 4. having -> 5. select -> 6. order by
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

--[실습1] EMP 테이블을 이용하여 부서번호(DEPTNO), 평균급여(AVG_SAL), 최고급여(MAX_SAL), 최저급여(MIN_SAL), 사원수(CNT)를 출력한다. 
--단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 SQL 문을 작성하시오.
SELECT
    deptno,
    trunc(AVG(sal)) avg_sal,
    MAX(sal)        max_sal,
    MIN(sal)        min_sal,
    COUNT(*)
FROM
    emp
GROUP BY
    deptno
ORDER BY
    deptno DESC;

--[실습2] 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력하는 SQL문을 작성하시오.
SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;

-- [실습3] 사원들의 입사연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력하는 SQL문 작성하시오.
SELECT
    to_char(hiredate, 'YYYY') hire_year,
    deptno,
    COUNT(deptno)             cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'YYYY'),
    deptno;

-- 조인 : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인(inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--    ① 등가조인 : 두 개의 열이 일치할 때 값 추출
--    ② 비등가조인 : 범위에 해당할 때 값 추출

-- 2) 외부조인(outer join)
--    ① left outer join
--    ② right outer join
--    ③ full outer join

-- dept : 4 행, emp : 12 행 ==> 4*12 = 48행
-- 크로스 조인(나올 수 있는 모든 조합 추출)
SELECT
    *
FROM
    emp,
    dept
ORDER BY
    empno;


-- ORA-00918: 열의 정의가 애매합니다( column ambiguously defined )

-- inner join
SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno;

-- SQL-99 표준
-- join ~ on

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno;

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND sal >= 3000;

-- SQL-99 표준
-- join ~ on

SELECT
    e.empno,
    e.ename,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    sal >= 3000;


-- emp, dept inner join, 급여가 2500 이하이고, 사원번호가 9999 이하인 사원 정보 조회
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.sal <= 2500
    AND e.empno <= 9999;


-- SQL-99 표준
-- join ~ on
SELECT
    e.empno,
    e.ename,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.sal <= 2500
    AND e.empno <= 9999;



-- emp와 salgrade 조인
-- emp 테이블의 sal 이 salgrade 테이블의 losal 과 hisal 범위에 들어가는 형태로 조인(BETWEEN)

SELECT
    *
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal;


-- SQL-99 표준
-- join ~ on

SELECT
    *
FROM
         emp e
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;



-- self join : 자기 자신 테이블과 조인
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno;


-- outer join

-- 1) left outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr = e2.empno (+);
    

-- SQL-99 표준
-- join ~ on    

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;    
    

-- 2) right outer join
SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1,
    emp e2
WHERE
    e1.mgr (+) = e2.empno;
    
    
-- SQL-99 표준
-- join ~ on    

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    RIGHT OUTER JOIN emp e2 ON e1.mgr = e2.empno; 

-- outer-join된 테이블은 1개만 지정할 수 있습니다
-- 01468. 00000 -  "a predicate may reference only one outer-joi
--SELECT e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
--FROM emp e1, emp e2
--WHERE e1.mgr(+) = e2.empno(+);

-- SQL-99 표준
-- join ~ on    

SELECT
    e1.empno,
    e1.ename,
    e1.mgr,
    e2.empno AS mgr_empno,
    e2.ename AS mgr_ename
FROM
    emp e1
    FULL OUTER JOIN emp e2 ON e1.mgr = e2.empno; 


-- 연결해야 할 테이블이 세개일때

--SELECT *
--FROM table1 t1, table2 t2, table3 t3
--WHERE t1.empno = t2.empno AND t2.deptno = t3.deptno;
--
--
--SELECT *
--FROM table1 t1 join table2 t2 on t1.empno = t2.empno join table3 t3 on t2.deptno = t3.deptno;

--[실습1] 급여가 2000초과인 사원들의 부서 정보, 사원 정보를 아래와 같이 출력하는 SQL 문을 작성하시오.
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
    dept d,
    emp  e
WHERE
        d.deptno = e.deptno
    AND e.sal > 2000;
-- SQL-99 방식
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.sal
FROM
         dept d
    JOIN emp e ON d.deptno = e.deptno
WHERE
    e.sal > 2000;

--[실습2] 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력하는 SQL문을 작성하시오.
SELECT
    d.deptno,
    d.dname,
    trunc(AVG(e.sal)) AS avg_sal,
    MAX(e.sal)        AS max_sal,
    MIN(e.sal)        AS min_sal,
    COUNT(*)          AS cnt
FROM
    dept d,
    emp  e
WHERE
    d.deptno = e.deptno
GROUP BY
    d.deptno,
    d.dname; 
-- SQL-99 방식
SELECT
    d.deptno,
    d.dname,
    trunc(AVG(e.sal)) AS avg_sal,
    MAX(e.sal)        AS max_sal,
    MIN(e.sal)        AS min_sal,
    COUNT(*)          AS cnt
FROM
         dept d
    JOIN emp e ON d.deptno = e.deptno
GROUP BY
    d.deptno,
    d.dname;

--[실습3] 모든 부서정보와 사원 정보를 아래와 같이 부서번호, 사원이름 순으로 정렬하여 출력하는 SQL문을 작성하시오.
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d,
    emp  e
WHERE
    d.deptno = e.deptno (+);
-- SQL-99 방식
SELECT
    d.deptno,
    d.dname,
    e.empno,
    e.ename,
    e.job,
    e.sal
FROM
    dept d
    LEFT OUTER JOIN emp  e ON d.deptno = e.deptno (+);

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

SELECT
    sal
FROM
    emp
WHERE
    ename = 'JONES'; --2975 ↓
SELECT
    *
FROM
    emp
WHERE
    sal > 2975;

SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            sal
        FROM
            emp
        WHERE
            ename = 'JONES'
    );

-- 사원 이름이 ALLEN인 사원의 추가수당 보다 많은 추가수당을 받는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm > (
        SELECT
            comm
        FROM
            emp
        WHERE
            ename = 'ALLEN'
    );

-- 사원 이름이 WARD인 사원의 입사일 보다 빨리 입사한 사원 조회
SELECT
    *
FROM
    emp
WHERE
    hiredate < (
        SELECT
            hiredate
        FROM
            emp
        WHERE
            ename = 'WARD'
    );

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서 정보 조회
-- 사원 번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal > (
        SELECT
            AVG(sal)
        FROM
            emp
    );

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서 정보 조회
-- 사원 번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
    e.empno,
    e.ename,
    e.job,
    e.sal,
    d.deptno,
    d.dname,
    d.loc
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
        e.deptno = 20
    AND e.sal <= (
        SELECT
            AVG(sal)
        FROM
            emp
    );

-- 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행 반환
-- in, any(some), all, exists 연산자 허용(단일행 서브쿼리에 쓰는 연산자 사용 불가)

--각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회

-- 각 부서별 최고 급여
SELECT
    deptno,
    MAX(sal)
FROM
    emp
GROUP BY
    deptno;
--ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--select * from emp where sal = (select max(sal) from emp group by deptno);

-- IN : 메인쿼리 결과가 서브쿼리 결과 2중 하나라도 일치하면 true
SELECT
    *
FROM
    emp
WHERE
    sal IN (
        SELECT
            MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

--30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 조회
-- ANY(SOME) : 메인쿼리 결과가 서브쿼리 결과가 하나 이상이면 TRUE
SELECT
    *
FROM
    emp
WHERE
    sal < ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

SELECT
    *
FROM
    emp
WHERE
    sal < SOME (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- 위 결과는 단일행 쿼리로 작성이 가능한 상황임
SELECT
    *
FROM
    emp
WHERE
    sal < (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );

--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 조회

-- ① 단일행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > (
        SELECT
            MIN(sal)
        FROM
            emp
        WHERE
            deptno = 30
    );
-- ② 다중행 서브쿼리
SELECT
    *
FROM
    emp
WHERE
    sal > ANY (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );

-- all : 서브쿼리 결과가 조건식에 맞아 떨어져야지만 메인쿼리 조건식이 true
SELECT
    *
FROM
    emp
WHERE
    sal < ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            deptno = 30
    );
--EXISIT 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 true
SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 10
    );

SELECT
    *
FROM
    emp
WHERE
    EXISTS (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = 50
    );

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
SELECT
    *
FROM
    emp
WHERE
    ( deptno, sal ) IN (
        SELECT
            deptno, MAX(sal)
        FROM
            emp
        GROUP BY
            deptno
    );

-- from 절에 사용하는 서브쿼리(인라인 뷰)
-- from 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때
SELECT
    e10.empno,
    e10.ename,
    e10.deptno,
    d.dname,
    d.loc
FROM
    (
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 10
    ) e10,
    (
        SELECT
            *
        FROM
            dept
    ) d
WHERE
    e10.deptno = d.deptno;

-- select 절에 사용하는 서브쿼리(스칼라 서브쿼리)
-- select 절에 사용하는 서브쿼리는 반드시 하나의 결과만 반환해야함
SELECT
    empno,
    ename,
    job,
    sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS salgrade,
    deptno,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = dept.deptno
    ) AS dname
FROM
    emp e;

-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하시오.
SELECT
    e.empno,
    e.ename,
    e.job,
    e.deptno,
    d.dname,
    d.loc
FROM
    emp  e,
    dept d
WHERE
        e.deptno = d.deptno
    AND e.deptno = 10
    AND e.job NOT IN (
        SELECT
            job
        FROM
            emp
        WHERE
            deptno = 30
    );

-- [실습2] 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여등급 정보를 출력하는 SQL문을 작성하시오
-- (단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원번호를 기준으로 오름차순 정렬하여 출력하시오.)
-- 단일행 서브쿼리
SELECT
    e.empno,
    e.ename,
    e.sal,
    s.grade
FROM
    emp      e,
    salgrade s
WHERE
    e.sal BETWEEN s.losal AND s.hisal
    AND e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > (
        SELECT
            MAX(sal)
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

-- 다중행 함수 사용 시
SELECT
    e.empno,
    e.ename,
    e.sal,
    (
        SELECT
            grade
        FROM
            salgrade
        WHERE
            e.sal BETWEEN losal AND hisal
    ) AS grade
FROM
    emp e
WHERE
    e.sal > ALL (
        SELECT
            sal
        FROM
            emp
        WHERE
            job = 'SALESMAN'
    )
ORDER BY
    e.empno;

-- DML(data manipulation language) : 데이터 추가(insert), 수정(update), 삭제(delete)하는 데이터 조작어
-- commit : DML 작업을 데이터베이스에 최종 반영 시켜주세요
-- rollback : DML 작업을 취소
-- select + DML ==> 자주 사용하는 sql

-- 연습용 테이블 생성
-- 기존 테이블 복사
CREATE TABLE dept_temp AS SELECT * FROM dept;

DROP TABLE dept_temp;

-- 열이름은 선택사항
-- insert in to 테이블 이름(열이름1, 열이름2.....)
-- values(데이터, 데이터2...........)

-- dept_temp 새로운 부서 추가하기
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    50,
    'database',
    'seoul'
);

SELECT * FROM dept_temp;

-- 열 이름 제거했을 때
INSERT INTO dept_temp VALUES (
    60,
    'network',
    'busan'
);

-- insert시 오류
-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--insert into dept_temp values(600,'network','busan');

-- ORA-01722: 수치가 부적합합니다
--INSERT INTO dept_temp VALUES ('No', 'network','busan');

--SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
--insert into dept_temp(deptno, dname, loc) values(70,'database');

--null 삽입
insert into dept_temp(deptno, dname, loc) values(80,'WEB',NULL);

insert into dept_temp(deptno, dname, loc) values(90,'mobile','');

-- null 삽입할 컬럼명 지정하지 않음
-- 삽입 시 전체 컬럼을 삽입하지 않는다면 필드명 필수
insert into dept_temp(deptno, loc) values(91,'inchon');

-- emp_temp 생성(rmp 테이블 복사 - 데이터는 복사 하지 않을 때)
CREATE TABLE emp_temp AS SELECT * FROM emp where 1 <> 1;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(1111,'성춘향','MANAGER',9999,'2002-01-05',4000,null,20);

update emp_temp set job ='';

-- 날짜 입력 시 년/월/일 -> 일/월/년 삽입
-- ORA-01830: 날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(2222,'이순신','MANAGER','07/01/2001',5000,1000,10);
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(2222,'이순신','MANAGER',NULL,to_date('07/01/2001','DD/MM/YYYY'),5000,1000,10);
--update emp_temp set job = 'MANAGER' where ename='성춘향'; 
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(3333,'심봉사','MANAGER',9999,sysdate,4000,null,30);

select * from emp_temp;

-- 서브쿼리로 INSERT 구현
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp에 추가
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno 
from emp e, salgrade s where e.sal between s.losal and s.hisal and s.grade = 1;

commit;

--Update 테이블명 set 변경할 열 이름 = 데이터, 변경할 열 이름 = 데이터........ where 변경을 위한 대상 행을 선별하기 위한 조건
--update emp_temp set job = 'MANAGER' where ename='성춘향';
select * from dept_temp;

-- dept_temp의 loc 열의 모든 값을 seoul로 변경
update dept_temp set loc = 'SEOUL';
-- 복구 할 때
rollback;

-- 데이터 일부분 수정 : where 사용
-- dept_temp 부서 번호가 40번인 loc 열의= 값을 seoul로 변경
update dept_temp set loc = 'SEOUL' where deptno = 40;

-- dept_temp 부서 번호가 80번인 danme = 'SALES'  loc = 'CHICAGO' 으로 변경
update dept_temp set dname = 'SALES',loc = 'CHICAGO' where deptno = 80;

-- emp_temp 사원들중에서 급여가 2500이하인 사원만 추가 수당을 50으로 수정
update emp_temp set comm = '50' where sal <= 2500;

select * from emp_temp;

-- 서브쿼리를 사용하여 데이터 수정
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트
update dept_temp set (dname, loc) = (select dname, loc from dept where deptno = 40) where deptno = 40;

-- delete : 테이블에 있는 데이터 삭제
--delete 테이블명 from (선택) where 삭제 데이터를 선별하기위한 조건식

create table emp_temp2 as select * from emp;

--job이 MANAGER인 사원 삭제
delete from emp_temp2 where job='MANAGER';

select * from emp_temp2;

--job이 SALESMAN인 사원 삭제 (from은 선택임)
delete emp_temp2 where job='SALESMAN';

--전체 데이터 삭제
delete emp_temp2;

-- 서브쿼리를 사용하여 삭제
-- 급여 등급이 3등급이고, 30번 부서의 사원 삭제
delete from emp_temp2 where empno in
(select e.empno from emp_temp2 e, salgrade s where e.sal between s.losal and s.hisal and s.grade = 3 and e.deptno = 30);

commit;

--[실습1] 실습을 위하여 기존 테이블을 이용하여 테이블을 생성한다.
--① EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
--② DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
--③ SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성

CREATE TABLE EXAM_EMP AS SELECT * FROM emp;
CREATE TABLE EXAM_DEPT AS SELECT * FROM dept;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM salgrade;


--[실습2] 다음의 정보를 EXAM_EMP 테이블에 입력하시오.
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7201,'TEST_USER1','MANAGER','7788','2016-01-02',4500,null,50);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7202,'TEST_USER2','CLERK','7201','2016-02-21',1800,null,50);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7203,'TEST_USER3','ANALYST','7201','2016-04-11',3400,null,60);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7204,'TEST_USER4','SALESMAN','7201','2016-05-31',2700,300,60);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7205,'TEST_USER5','CLERK','7201','2016-07-20',2600,null,70);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7206,'TEST_USER6','CLERK','7201','2016-09-08',2600,null,70);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7207,'TEST_USER7','LECTURER','7201','2016-10-28',2300,null,80);
insert into EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno) values(7208,'TEST_USER8','STUDENT','7201','2018-03-09',1200,null,80);

select * from EXAM_EMP;

--[실습3] EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
update EXAM_EMP set deptno=70 where sal > (select avg(sal) from EXAM_EMP where deptno = 50);

--[실습4] EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
update EXAM_EMP set sal = sal * 1.1, deptno = 80 where hiredate > (select min(hiredate) from EXAM_EMP where deptno = 60);

--[실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
delete from EXAM_EMP where empno in
(select e.empno from EXAM_EMP e, salgrade s where e.sal between s.losal and s.hisal and s.grade = 5);

commit;

-- 트랜젝션(transaction) : 최소 수행 단위
-- 트랜젝션 제어하는 구문 TCL(Transaction Control Language) : commit, rollback
 create table dept_tcl as select * from dept;
 
 insert into dept_tcl VALUES(50,'DATABASE','SEOUL');
 
 update dept_tcl set loc = 'BUSAN' where deptno = 40;
 
 delete from dept_tcl where dname = 'RESEARCH';
 
 select * from dept_tcl; 

-- 트랜젝션 취소
ROLLBACK;

-- 트랜젝션 최종 반영
commit;

-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
-- LOCK : 잠금(수정 중인 데이터 접근 막기)
delete from dept_tcl where deptno=50;
 
update dept_tcl set loc = 'SEOUL' where deptno = 30;
 
 commit;