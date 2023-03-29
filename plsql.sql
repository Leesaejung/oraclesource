-- PL/SQL : sql 만으로 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어

-- 실행 결과를 화면에 출력
SET SERVEROUTPUT ON;

-- 블록 : DECLARE ~ BEGIN ~ END
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

-- 변수
DECLARE
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);

END;
/

-- 상수선언
DECLARE
    V_TAX CONSTANT NUMBER(4) := 7788;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);

END;
/

-- 변수 + DEFAULT
DECLARE
    V_TAX NUMBER(4) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);

END;
/

-- 변수 + NOT NULL
DECLARE
    V_TAX NUMBER(4) NOT NULL := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);

END;
/

-- 변수 + NOT NULL + DEFAULT
DECLARE
    V_TAX NUMBER(4) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);

END;
/

-- 변수나 상수의 자료형
-- 스칼라 : 오라클이 사용하는 타입(NUMBER, CHAR, DATE.....)
-- 참조형 : 오라클 데이터 베이스에 존재하는 특정 테이블의 열의 자료형이나 하나의 행 구조를 참조하는 자료형
--    1) : 변수 이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
--    2) : 변수 이름 테이블명.%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조 


DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);

END;
/


DECLARE
    -- V_DEPT_ROW 변수가 DEPT 테이블의 한 행의 구조를 참조
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    select deptno, dname, loc INTO V_DEPT_ROW
    from DEPT
    where DEPTNO = 40;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.loc);


END;
/

-- 조건문 : IF, IF ~ THEN ~ END IF

DECLARE
    V_NUMBER NUMBER := 15;
BEGIN
    -- V_NUMBER 홀수, 짝수 구별
    -- MOD() : 나머지 구하는 오라클 함수
    IF MOD(V_NUMBER, 2) = 1 THEN
    DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수');
    END IF;
END;
/

DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    -- V_NUMBER 홀수, 짝수 구별
    -- MOD() : 나머지 구하는 오라클 함수
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 홀수');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER 는 짝수');

    END IF;
END;
/

-- 학점 출력

DECLARE
    V_NUMBER NUMBER := 87;
BEGIN
    IF V_NUMBER >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A 학점');
    ELSIF V_NUMBER >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B 학점');
    ELSIF V_NUMBER >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C 학점');
    ELSIF V_NUMBER >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D 학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F 학점');
    END IF;
END;
/

-- 학점 출력

DECLARE
    V_NUMBER NUMBER := 87;
BEGIN
    CASE TRUNC(V_NUMBER/10)
    When 10 then
        DBMS_OUTPUT.PUT_LINE('A 학점');
    When 9 then
        DBMS_OUTPUT.PUT_LINE('A 학점');
    When 8 then
        DBMS_OUTPUT.PUT_LINE('B 학점');
    When 7 then
        DBMS_OUTPUT.PUT_LINE('C 학점');
    When 6 then
        DBMS_OUTPUT.PUT_LINE('D 학점');
    ELSE DBMS_OUTPUT.PUT_LINE('F 학점');
    END CASE;
END;
/

-- 학점 출력

DECLARE
    V_NUMBER NUMBER := 87;
BEGIN
    CASE
        When V_NUMBER >= 90 THEN
            DBMS_OUTPUT.PUT_LINE('A 학점');
        When V_NUMBER >= 80 THEN
            DBMS_OUTPUT.PUT_LINE('B 학점');
        When V_NUMBER >= 70 THEN
            DBMS_OUTPUT.PUT_LINE('C 학점');
        When V_NUMBER >= 60 THEN
            DBMS_OUTPUT.PUT_LINE('D 학점');
        ELSE
            DBMS_OUTPUT.PUT_LINE('F 학점');
    END CASE;
END;
/

-- 반복문
-- LOOP ~ END LOOP, WHILE LOOP, Cusor FOR LOOP

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('V_NUM : ' || V_NUM);
        V_NUM := V_NUM+1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    WHILE V_NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('V_NUM : ' || V_NUM);
        V_NUM := V_NUM+1;
    END LOOP;
END;
/

-- FOR i IN 시작값..종료값 LOOP
-- END LOOP;

BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/

-- 짝수 출력
BEGIN
    FOR i IN 0..4 LOOP
    continue when mod(i,2) =1;
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/

-- 홀수 출력

BEGIN
    FOR i IN 1..10 LOOP
    continue when mod(i,2) =0;
        DBMS_OUTPUT.PUT_LINE('i : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..10 LOOP
        if I mod 2 =1 THEN
            DBMS_OUTPUT.PUT_LINE('i : ' || i);
        END IF;
    End loop;
END;
/