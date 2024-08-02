SELECT 
    SYSTEM_USER AS CurrentLogin, 
    SUSER_SNAME() AS [CurrentLoginName]

--****************** Abdelrahman User () : Admin
--****************** Fares User (fares => 12345) : Training Manager
--> Table
--  Instructors
--  Instructor_Course
--  Course
--  Students
--  Intakes
--  Branches
--  Tracks
--  Intakes_Trackes
--  Departments
--****************** Eman User (eman => 12345) : Instuctor
--> Table
--  Exam_Question
--  Exam_Student
--  Exams
--  Questions
--  Multiple_Choose
--  TF
--  Text_Question
--****************** Karim User (karim => 12345) : Student
--> Table
--  Student_Exam_Answer


--- Tables Query
select * from Departments
select * from Exam_Question
select * from Exam_Student
select * from Exams
select * from Branches
select * from Courses
select * from Students
select * from Intakes
select * from Intakes_Trackes
select * from Tracks
select * from TF
select * from Text_Question
select * from Multiple_Choose
select * from Questions
select * from Student_Exam_Answer
select * from Instructor_Course
select * from Instructors
--- ****************************************************
--- SP Query
--1
exec SP_Add_Exam '7/21/2024', '10:00 AM', '11:00 AM', 'open book', 'Exam', 3
--2
exec SP_Update_Training_Manager 4, 17
--3
EXEC SP_Store_StudentAnswerAndDegree @StudentID = 5, -- 5,6,14,18
                                    @ExamID = 8,
									@QuestionID = 42, -- 42,44,147
									@Answer = 'F', -- T T B
									@ManualDegree=0;
EXEC SP_Store_StudentAnswerAndDegree @StudentID = 5,
                                    @ExamID = 8,
									@QuestionID = 43,
									@Answer = 'F',
									@ManualDegree=0;
EXEC SP_Store_StudentAnswerAndDegree @StudentID = 5,
                                    @ExamID = 8,
									@QuestionID = 96,
									@Answer = 'JavaScript is a programming language that is commonly used to create interactive effects within web browsers.',
									@ManualDegree=0;
			

--4
exec SP_Add_Instructor 
@Instructor_Name = 'Ahmed Ayman',
@Instructor_Email = 'youn23@email.com',
@Instructor_Password = '012549522',
@Instructor_Phone = '01547896512'

exec SP_Edit_Instructor
@Instructor_ID = 9,
@column_Name = 'Instructor_Name',
@New_Value = 'fares Ahmed'

EXEC SP_Delete_Instructor 
    @Instructor_ID = 20;

--5
exec sp_Add_Course @course_name='c sharp',@description='develop desktop applications',@max_degree=100,@min_degree=55,@trackId=1
select * from Courses
execute sp_Update_Course @course_id = 55 ,
						 @course_name = 'c++',
						 @description = 'itro to programming language',
						 @max_degree = 120,
						 @min_degree = 70,
						 @track_id = 4

exec SP_DeleteCourse @CourseID=55

--6
execute sp_Add_InstructorForCourse  50000, 700000
execute sp_Add_InstructorForCourse  15, 3

select * from Instructor_Course

--7
exec AddQuestion @QuestionType = 'TF', 
                 @CourseID = 8,
				 @InstructorID = 1,
                 @QuestionName = 'is c# ?', 
                 @CorrectAnswer = 'F'

exec EditQuestion
                  @InstructorID = 1,
                  @courseID = 8,
                  @QuestionID = 157, 
                  @QuestionType = 'TF', 
                  @QuestionName = 'is css programming language ?',
                  @CorrectAnswer='F'

EXEC DeleteQuestion
@InstructorID = 1,
@CourseID = 8,
@QuestionID = 157;

--8
EXEC SP_Add_Branch 'Smart Village', 'Cairo';
exec SP_Edit_Branch @BranchID=8 ,@NewBranchName='Smart Village', @NewCity= 'qena'
EXEC SP_Add_Intake @IntakeName = 'New Capital Branch - intake 3', @StartDate = '2024-05-01', @EndDate = '2025-09-10', @BranchID = 12;
exec EditIntake @IntakeID = 12, @NewIntakeName = 'New Capital Branch - intake 3', @NewStartDate = '2024-05-01', @NewEndDate = '2024-09-10', @NewBranchID = 11;
exec AddTrack @TrackName = 'Computer Science', @DepartmentID = 1;
exec EditTrack @TrackID = 36, @NewTrackName = 'RPA', @NewDepartmentID = 13;
EXEC SP_Insert_Into_Track_Intake  @TrackID = 1,  @IntakeID = 1;

--9
open symmetric key symmetrickey_student_instructor decryption  
by certificate certificate_student_instructor
EXEC SP_Add_Student 'Ali','Faculty of Education','karim@zagmail.com','hello','01124147718',12,3,12
close symmetric key symmetrickey_student_instructor


--10
EXEC SP_Create_TrainingManager 
    @AdminID = 1, -- Assuming 1 is the ID of an existing admin
    @InstructorName = 'Karim2',
    @InstructorEmail = 'Karim2@email.com',
    @InstructorPassword = 'Karim2@1234',
    @InstructorPhone = '01117657201';


--11
exec SP_Select_Question_Random 1,8 ,8

exec  SP_Select_Question_Instructor
@Instructor_ID = 1,
@Course_ID = 8,
@Exam_ID = 8,
@Questions_List = '42,43,96' -- 42,44,147, 144, 43,96,145


--12
exec SP_Update_Question_Degree 10,1,5

--13
exec SP_Get_Instructor_For_Exam 1 -- 1,5

--14
EXEC SP_Select_Students_For_Exam
    @InstructorID = 1, 
    @ExamID = 8, 
    @StudentIDs = '5,6,14,18';  


--- ****************************************************
--- View Query
exec [dbo].[SP_V_Exam_Question_Details] 1
exec [dbo].[SP_V_Exam_Questions_With_All_Details] 1
exec [dbo].[SP_V_Student_Degree_In_Exam] 8
select * from [dbo].[V__Exams]
select * from [dbo].[V_instructors]
select * from [dbo].[V_BranchesDataWithCounStudents]
select * from [dbo].[V_courses]
select * from [dbo].[V_Courses_In_Track_With_Instructors]
select * from [dbo].[V_Departments]
select * from [dbo].[V_instructorForEachCourse]
select * from [dbo].[V_InstructorsInBranch]
select * from [dbo].[V_InstructorWithoutManager]
select * from [dbo].[V_IntakesWithBranchName]
select * from [dbo].[V_Questions_Details]
select * from [dbo].[V_Show_Training_Manager_Instructor_Count]
select * from [dbo].[V_ShowStudentBanchIntakeTrackIntake]
select * from [dbo].[V_Student_Exam_Answer]
select * from [dbo].[V_Students_Exam_Attendance]
select * from [dbo].[V_Students_Exam]
select * from [dbo].[V_IntakesWithBranchName]
EXEC SP_Get_Students_By_Instructor_ID 2;
select * from [dbo].[V_StudentsData]
select * from [dbo].[V_TF_Questions_Details]
select * from [dbo].[V_Tracks_Department]
--- ****************************************************