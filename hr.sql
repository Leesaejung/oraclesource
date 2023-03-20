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
-- commision_pct null이 아닌 사원들 중에ㅔ서 commision = salary * commision_pct 를 구하여
-- employee_id, first_name, job_id 출력
select employee_id, first_name, job_id, salary * commission_pct as commision from employees where commission_pct is not null; 