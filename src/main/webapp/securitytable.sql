create table tbl_member(
    userid varchar2(50) not null primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    enabled char(1) default '1'
);
create table tbl_auth(
userid varchar2(50) not null,
auth varchar2(50) not null,
constraint fk_member_auth foreign key(userid) REFERENCES tbl_member(userid)
);

select * from tbl_member where userid = 'admin90'
select* from tbl_auth where userid='admin90'
