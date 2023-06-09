-- employee 테이블 전체 내용 조회
select * from employees;

-- employee 테이블 first_name, last_name, job_id만 조회
select first_name, last_name, job_id from employees;

-- 사원번호가 176인 사람의 LAST_NAME 조회

select last_name from employees where employee_id = 176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회

select last_name, salary from employees where salary >= 12000;

-- 연봉이 5000에서 12000 범위가 아닌 사람들의 LAST_NAME, SALARY 조회
select last_name, salary from employees where salary < 500 or salary > 12000 ORDER by last_name desc;

--20, 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 조회를 오름차순으로 조회
SELECT last_name, department_id from employees where department_id in(20,50) ORDER by last_name, department_id;

--커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
select last_name, salary, commision_pct from employees where commission_pct >0 order by salary desc , commision_pct desc;

--연봉이 2500,3500,7000이 아니며 직업이 SA_REP 나 ST_CLERK 인 사원 조회
select * from employees where salary not in(2500,3500,7500) and job_id in('SA_REP', 'ST_CLERK');

-- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 last_name, 사번, 고용일자 조회, 고용일자 내림차순 정렬
-- 날짜 표현 시 홀따옴표 안에 표현 - OR / 사용 가능
select last_name, employee_id, hire_date from employees where hire_date >= '2008-02-20' and hire_date <= '2008-05-01' order by hire_date desc;

select last_name, employee_id, hire_date from employees where hire_date BETWEEN '2008-02-20' AND '2008-05-01';

-- 2004년도에 고용된 사원들의 last_name, hire_date 조회
-- 고용일자 오름차순 정렬
select last_name, hire_date from employees where hire_date <= '2004-12-31' order by hire_date;

-- 부서가 20,50이고 연봉이 5000에서 12000 범위인 사람들의 last_name, hire_date 추출하기
select last_name, employee_id, hire_date from employees where department_id in(20,50) and salary BETWEEN 5000 and 12000 ORDER by salary;

-- 2004년도 입사자 : like
select last_name, hire_date from employees where hire_date like '%04%' ORDER by hire_date;

--last1-name에 u가 포함된 사원들의 사번, last_name 조회
select last_name from employees where last_name like '%u%';
--last1-name에 네번째 글자가 a인 사원들의 last_name 조회
select last_name from employees where last_name like '___a%';
--last1-name에 a 혹은 e 글자가 포함된 사원들의 last_name 조회
--last_name 오름차순
select last_name from employees where last_name like '%a%' or last_name like '%e%' order by last_name;
--last1-name에 a 와 e 글자가 포함된 사원들의 last_name 조회
--last_name 오름차순
select last_name from employees where last_name like '%a%e%' or last_name like '%e%a%' order by last_name;

-- 매니저가 없는 사람들의 last_name, job_id 조회
select last_name, job_id from employees where manager_id is null or manager_id = '';
-- job_id가 ST_CLERK인 사원 조회(단 부서 번호가 NULL인 사원은 제외한다)
-- 중복을 제거한 후 부서 번호만 조회
select DISTINCT department_id from employees where job_id  = 'ST_CLERK' and department_id is not null;
-- commision_pct null이 아닌 사원들 중에서 commision = salary * commision_pct 를 구하여
-- employee_id, first_name, job_id 출력
select employee_id, first_name, job_id, salary * commission_pct as commision from employees where commission_pct is not null; 

-- first_name이 Curtis인 사람의 first_name, last_name, email,phone_number, job_id를 조회한다.
-- 단, job_id의 결과는 소문자로 출력되도록 한다.
select first_name, last_name, email,phone_number, lower(job_id) from employees where first_name like 'Curtis';

-- 부서번호가 60,70,80,90인 사원들의 employee_id, first_name, hire_date, job_id 조회
-- 단, job_id가 IT_PROG인 사원의 경우 프로그래머로 변경한 후 출력
select employee_id, first_name, hire_date, replace(job_id,'IT_PROG','프로그래머') from employees where department_id in(60,70,80,90);

-- JOB_ID가 AD_PRES,PU_CLERK인 사원들의 employee_id, first_name, last_name, department_id, job_id를 조회한다
-- 단, 사원명은 first_name과 last_name을 연결하여 출력하시오
select employee_id, first_name || ' ' || last_name, department_id, job_id from employees where job_id in('AD_PRES','PU_CLERK');

-- [실습4] 부서 80의 각 사원에 대해 적용 가능한 세율을 표시하시오.
select last_name, salary,
        decode(trunc(salary/2000,0),
        0,
        0.00,
        1,
        0.09,
        2,
        0.20,
        3,
        0.30,
        4,
        0.40,
        5,
        0.42,
        6,
        0.44,
        0.45)as TAX_RATE
from employees where department_id = 80;

-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
select max(salary) - min(salary) sal_gap from employees;
-- 매니저로 근무하는 사원들의 총 숫자 출력(매니저 중복 제거)
select count(distinct manager_id) from employees;

select * from employees;
-- join
-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기(self join - employees)
-- hire_date, last_date, manager_id 조회
SELECT
    emp.last_name,
    emp.employee_id,
    emp.hire_date
FROM
    employees emp,
    employees mgr
WHERE
        emp.manager_id = mgr.employee_id
    AND emp.hire_date < mgr.hire_date;


-- 도시 이름이 T로 시작하는 지역에서 사는 사원들의 사번, last_name, 부서번호, 도시 조회
-- employees, departments, locations inner join
SELECT
    e.employee_id,
    d.last_name,
    d.department_id,
    l.city
FROM
    employees   e,
    departments d,
    locations   l
WHERE
        e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND city LIKE 'T%';


-- 위치 id가 1700인 사원들의 사번, last_name, 부서번호, 급여조회
-- employess departments inner join
SELECT
    e.employee_id,
    e.last_name,
    d.department_id,
    e.salary
FROM
    employees   e,
    departments d
WHERE
        e.department_id = d.department_id
    AND d.location_id = 1700;

-- 부서명, 위치id, 각 부서별 사원 총 수, 각 부서별 평균 연봉 조회
-- 평균 연봉은 소수점 2자리까지만
-- employess ,departments inner join
SELECT
    d.department_name,
    d.location_id,
    COUNT(employee_id),
    round(AVG(e.salary),2) avg_salary
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id
GROUP BY
    department_name,
    location_id;
-- Executive 부서에 근무하는 사원들의 부서번호, last_name, job_id 조회
-- employess, departments inner join
SELECT
    d.department_id,
    e.job_id,
    e.last_name
FROM
    employees e,
    departments d
WHERE
        e.department_id = d.department_id
    AND d.department_name = 'Executive';
--각 사원별 소속부서에 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는 모든 사원들의 부서번호,
-- 이름(first_name과 last_name 연결하기), salary, hire_date 조회
-- employess self join
SELECT 
    DISTINCT e.department_id,
    e.first_name || ' ' || e.last_name as name,
    e.salary,
    e.hire_date
FROM
    employees e,
    employees e2
WHERE
        e.department_id = e2.department_id
    AND e.hire_date < e2.hire_date
    AND e.salary < e2.salary;
    
-- 서브쿼리
-- Last_name에 U가 포함된 사원과 동일부서에 근무하는 사원들의 사번, last_name 조회
SELECT employee_id, last_name
FROM employees
WHERE department_id IN ( SELECT distinct department_id FROM employees WHERE last_name LIKE '%u%')
ORDER BY employee_id ASC;

-- job_id가 SA_MAN인 사원들의 최대 연봉보다 높게 받는 사원들의 last_name, job_id, salary 조회
SELECT last_name, job_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SA_MAN');

-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 last_name, department_id, salary 조회
SELECT last_name,
    department_id,
    salary
FROM employees
WHERE (department_id, salary )
in (select department_id,salary from employees where commission_pct>0);
    
-- 회사 전체 평균 연봉보다 더 받는 사원들중 last_name에 u가 있는 사원들이 근무하는 부서에서
-- 근무하는 사원들의 employee_id, last_name, salary 조회
SELECT employee_id, last_name,salary
FROM (
    select DISTINCT department_id 
    FROM employees 
    WHERE salary > (SELECT round(AVG(salary),0) FROM employees) AND last_name LIKE '%u%') dept, employees e
WHERE e.department_id = dept.department_id
order by employee_id;
    
-- last_name 이 Davies인 사람보다 나중에 고용된 사원들의 last_name, hire_date 조회
SELECT last_name,hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Davies') order by hire_date;

-- last_name이 king인 사원을 매니저로 두고 있는 모든 사원들의 last_name, salary 조회
SELECT last_name, salary
FROM employees
WHERE manager_id in (select employee_id from employees where last_name='King');