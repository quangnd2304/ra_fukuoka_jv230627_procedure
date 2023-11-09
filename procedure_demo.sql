Select * from Student;
Select * from student_class;
create view vw_student_class
	as select st.student_id,st.student_name,st.age,sc.class_id,sc.class_name,st.student_status
		from student st join student_class sc on st.class_id = sc.class_id;
drop view vw_student_class;
insert into student
	values('SV008','Trần Văn Quang',29,1,1,2);
select vsc.student_id,vsc.student_name, vsc.age from vw_student_class vsc;
-- 1. Tạo procedure cho phép lấy tất cả thông tin sinh viên
DELIMITER \\
create procedure get_all_student()
BEGIN
	-- block statement thực hiện chức năng của procedure
    select * from student;
END \\
DELIMITER &&
-- Gọi procedure
call get_all_student();
-- 2. Tạo procedure thực hiện tính tổng số sinh viên
DELIMITER \\
create procedure count_student(
	-- In params
    -- out Params
    OUT cnt int,
    OUT abc varchar(100)
)
BEGIN
	set cnt = (select count(s.student_id) from student s);
	set abc = 'Thầy Quang đẹp zai';
END \\
DELIMITER &&
call count_student(@tongsinhvien,@quang);
select @tongsinhvien;
select @quang;
-- 3. Tạo procedure lấy tổng số sinh viên trong 1 lớp
DELIMITER \\
Create procedure count_student_in_class(
	-- In params
    class_id int,
    -- Out params
    OUT cnt_student int
)
BEGIN
	set cnt_student = (select count(s.student_id) from student s where s.class_id = class_id);
END \\
DELIMITER &&
call count_student_in_class(1,@cnt_student);
select @cnt_student;
-- 4. Tạo procedure cho phép thêm mới 1 sinh viên
DELIMITER \\
Create procedure create_student(
	-- in params
    student_id_in char(5),
    student_name_in varchar(100),
    age_in int,
    sex_in bit,
    status_in bit,
    class_id_in int
    -- out params
)
BEGIN
	insert into student
    values(student_id_in, student_name_in, age_in, sex_in, status_in, class_id_in);
END \\
DELIMITER &&
call create_student('SV009','Nguyễn Yumi',29,0,1,1);
select * from student;
-- 5. Tạo procedure cho phép cập nhật sinh viên
DELIMITER \\
Create procedure update_student(
	-- in params
    student_id_in char(5),
    student_name_in varchar(100),
    age_in int,
    sex_in bit,
    status_in bit,
    class_id_in int
    -- out params
)
BEGIN
	update student
    set student_name = student_name_in,
		age = age_in,
        sex = sex_in,
        student_status = status_in,
        class_id = class_id_in
	where student_id = student_id_in;

END \\
DELIMITER &&
call update_student('SV009','Nguyễn Hiền Yumi',39,0,1,2);
select * from student;
-- 6. Tạo procedure cho phép xóa 1 sinh viên theo mã
DELIMITER \\
Create procedure delete_student(
	student_id_in char(5)
)
BEGIN
	delete from student where student_id = student_id_in;
END \\
DELIMITER &&
call delete_student('SV006');
select * from student;







