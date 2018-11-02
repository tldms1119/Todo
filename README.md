# Todo
To do list
간단한 To do List
사용 언어 : Java
MyBatis DB 연동
apache tomcat 8.5 서버

DB 쿼리문
create table todo(
    todo_id number primary key,
    title varchar2(256),
    content clob,
    priority number,
    deadline date, 
    checked number(1) default(0),
    reg_date date default(sysdate),
    update_date date default(sysdate)
);

create sequence todo_seq;
