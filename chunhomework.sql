select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블

# 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력
SELECT * FROM tb_professor;

SELECT distinct PROFESSOR_NAME 교수이름,
       CLASS_NAME 과목이름
from tb_professor
         join tb_class using (DEPARTMENT_NO);

#9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다.
# 이에 해당하는 과목 이름과 교수 이름을 출력
select * from tb_department;

select distinct PROFESSOR_NAME 교수이름,
       class_name 과목이름
from tb_professor
join tb_class using (department_no)
join tb_department using (department_no)
where category = '인문사회';

# ‘음악학과’ 학생들의 평점을 구하려고 한다.
# 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
# (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
select
       STUDENT_NO 학번,
        STUDENT_NAME 학생이름,
        round(sum(point)/count(STUDENT_NO),1) 평점
from tb_student
join tb_department using(department_no)
join tb_grade using (student_no)
where DEPARTMENT_NAME = '음악학과'
group by STUDENT_NO;  #group by절로 묶어야 연산이 가능함

#  학번이 `A313047` 인 학생이 학교에 나오고 있지 않다.
# 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
# 이때 사용할 SQL 문을 작성하시오.
#      단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.
select distinct
       department_name 학과이름,
       STUDENT_NAME 학생이름,
       professor_name 교수이름
from tb_student
join tb_department using(DEPARTMENT_NO)
join tb_professor using(department_no)
    where STUDENT_NO = 'A313047';

# 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시
# select CLASS_NAME
# from tb_class
# where CLASS_NAME ='인간관계론'

    select STUDENT_NAME 학생이름,
            STUDENT_NO 학생번호,
            TERM_NO 수강학기
    from tb_student
    join tb_class using (department_no)
    join tb_grade using (student_no)
    where CLASS_NAME = '인간관계론';

# 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력
select * from tb_department where CATEGORY ='예체능';

select  department_name 학과이름,
        class_name 과목명
 from tb_class_professor
join tb_class using (class_no)
join tb_department using(department_no)
where CATEGORY ='예체능' and PROFESSOR_NO is null;  -- ????????

# 12. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
# 학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우
# "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오.
#     단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다

select tb_class.CLASS_NAME from tb_class order by CLASS_NAME;
#                            where CLASS_NAME ='서반아어학과'????????????
select * from tb_department where DEPARTMENT_NAME ='서반아어학과';
select DEPARTMENT_NO from tb_department where DEPARTMENT_NAME ='서반아어학과';
select COACH_PROFESSOR_NO from tb_student where COACH_PROFESSOR_NO is null

    select STUDENT_NAME 학생이름,
           IFNULL(PROFESSOR_NAME,'미지정') 지도교수  -- 지도교수가 없으면 미지정으로
    from tb_student
        left join tb_professor using(DEPARTMENT_NO)  -- student테이블의 모든행이 포함되고 professor가 없으면 null 반환함
        join tb_department using(department_no)
    where DEPARTMENT_NAME ='서반아어학과'   -- 서반아어학과 학생조회
#           and COACH_PROFESSOR_NO is null
    order by STUDENT_NO;        -- 학번순 정렬

# 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아
# 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성

    SELECT tb_student.STUDENT_NAME 학생이름,
           tb_grade.STUDENT_NO 학번,
           tb_grade.POINT 평점,
           tb_department.DEPARTMENT_NAME 학과이름
    FROM tb_student
    JOIN tb_department USING (DEPARTMENT_NO)
    JOIN tb_grade USING (STUDENT_NO)
    WHERE ABSENCE_YN = 'N' AND POINT >= 4.0;

# 환경조경학과 전공과목들의 과목 별 평점을 파악

select * from tb_department;  -- 학과는 여기있음 '환경조경학과'
SELECT * FROM tb_class;   -- '과목이름'은 여기 있음 class_no
SELECT * FROM tb_grade;   -- 평점은 여기있음
SELECT * FROM tb_professor;  -- '환경조경학과'의 과목번호를 알아서 class_no를 조회하고자함,과목을 알기위해서
SELECT * FROM tb_student;
SELECT * FROM tb_class_professor; -- class_no와 교수번호가 있음, 환경조경학과 교수번호가 과목번호와 연결되어있음

SELECT * FROM tb_department WHERE DEPARTMENT_NAME ='환경조경학과'; -- 학과번호 :034, 카테고리 :자연과학, 환경조경학과의 과목은 뭐가있지?
SELECT * FROM tb_professor WHERE DEPARTMENT_NO = 034; -- 034, 자연과학 -- 교수번호로 연결되있음
SELECT * FROM tb_class WHERE DEPARTMENT_NO = 034;
SELECT * FROM tb_student WHERE DEPARTMENT_NO = 034; -- 034, 자연과학
SELECT * FROM tb_class_professor WHERE PROFESSOR_NO IN( 'P010','P016','P060','P084','P109'); -- 034학과 교수가 가르치는 과목
#departmemt에서 환경조경을 찾고 학과번호를 찾는다
#학과번호(department_no)로 이어진 과목이름은 class에서 과목이름과 함께 찾는다.
#class_no로 이어진 평점을 grade에서 찾는다.

#gr테이블의 class_no = class테이블의 class_no
#clas테이블의 class_no = class_name
#dep테이블의 department_no = cl의 department_no 이어야함.

# 횐경조경학과의 department_no가 과목이름의 departmetm_no 이면서 class_no의 번호가  grade의 class번호여야함

    select DEPARTMENT_NO,
           DEPARTMENT_NAME
    from tb_department
    where DEPARTMENT_NAME = '환경조경학과';

    select DEPARTMENT_NO,
           CLASS_NO
    from tb_class
    where DEPARTMENT_NO in (select DEPARTMENT_NO
                             from tb_department
                             where DEPARTMENT_NAME = '환경조경학과');


    select distinct point 평점,
           CLASS_NO 환경조경학과과목,
           class_name 과목이름
    from tb_grade
    join tb_class using(class_no)
    where CLASS_NO in (select CLASS_NO
                       from tb_class
                       where DEPARTMENT_NO in (select DEPARTMENT_NO
                                               from tb_department
                                               where DEPARTMENT_NAME = '환경조경학과'));


# 춘 기술대학교에 다니고 있는 최경희 학생과
# 같은 과 학생들의 이름과 주소를 출력
# 최경희는 무슨과?
SELECT * FROM tb_student WHERE STUDENT_NAME = '최경희'; -- DEPARTMENT_NO가 같은학생조회, 경희는 038 학과번호임

SELECT STUDENT_NAME 학생이름,
       STUDENT_ADDRESS 학생주소
      FROM tb_student
         WHERE DEPARTMENT_NO in(select DEPARTMENT_NO  -- 최경희와 같은 학과번호를 가진사람을 메인 쿼리 조건에 넣음
         FROM tb_student
             WHERE STUDENT_NAME = '최경희');

# 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시
SELECT * FROM tb_grade;
SELECT * FROM tb_student;
select * from tb_department;

select point 평점,
       STUDENT_NAME 학생이름,
       STUDENT_NO 학번
from tb_student
join tb_grade using (STUDENT_NO)
where DEPARTMENT_NO in(
select DEPARTMENT_NO from tb_department
         where DEPARTMENT_NAME = '국어국문학과')
order by POINT desc;



