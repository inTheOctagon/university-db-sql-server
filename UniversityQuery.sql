--CREATE DATABASE University
--GO
USE University
GO
CREATE TABLE Terms(
					TermID int,
					TermName nvarchar(4000),
					CONSTRAINT PK_Terms PRIMARY KEY(TermID)
				  )
GO
CREATE TABLE Years(
					[Year] int,
					NumberOfPublishedArticles int,
					CONSTRAINT PK_Years PRIMARY KEY(Year)
				  )
GO
CREATE TABLE Faculties(
						FacultyID int,
						FacultyName nvarchar(4000) NOT NULL,
						CONSTRAINT PK_Faculties PRIMARY KEY(FacultyID)
                      )
GO
CREATE TABLE Departments(
						DepartmentID int,
						DepartmentName nvarchar(4000) NOT NULL,
						FacultyID int,
						CONSTRAINT PK_Departments PRIMARY KEY (DepartmentID),
						CONSTRAINT FK_D_FacultyID FOREIGN KEY(FacultyID) REFERENCES Faculties(FacultyID) 
						ON DELETE SET NULL ON UPDATE CASCADE
                        )

GO
CREATE TABLE Academics(
						AcademicID int,
						GivenNames nvarchar(4000) NOT NULL,
						FamilyNames nvarchar(4000) NOT NULL,
						DepartmentID int,
						Titles nvarchar(4000) NOT NULL,
						CONSTRAINT PK_Academics PRIMARY KEY(AcademicID),
						CONSTRAINT FK_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID) 
						ON DELETE SET NULL ON UPDATE CASCADE
					  )
GO
CREATE TABLE Students(  
						StudentID int,
						GivenNames nvarchar(4000) NOT NULL,
						FamilyNames nvarchar(4000) NOT NULL,
						[Address] nvarchar(4000) NOT NULL,
						PhoneNumber int NOT NULL,
						DateOfBirth date NOT NULL,
						PlaceOfBirth nvarchar(4000) NOT NULL,
						CONSTRAINT PK_Students PRIMARY KEY(StudentID),
					 )
GO
CREATE TABLE RegistrationDetails(
						StudentID int,
						DepartmentID int,
						CUMGPA decimal(2,1),
						RegistrationDate date NOT NULL,
						GratuationStatus bit NOT NULL,
						GraduationDate date,
						CONSTRAINT FK_RD_StudentID FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
						ON DELETE SET NULL ON UPDATE CASCADE,
						CONSTRAINT FK_RD_DepartmentID FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID) 
						ON DELETE SET NULL ON UPDATE CASCADE
						)
GO
CREATE TABLE Courses(
						CourseID int,
						CourseName nvarchar(4000),
						CONSTRAINT PK_Courses PRIMARY KEY(CourseID)
					)
GO
CREATE TABLE StudentCourses(
									CourseID int,
									StudentID int,
									TermID int,
									CourseYear int,
									Midterm1Percent int CHECK(Midterm1Percent>=0 AND 100>=Midterm1Percent),
									Midterm2Percent int CHECK(Midterm2Percent>=0 AND 100>=Midterm2Percent),
									Midterm3Percent int CHECK(Midterm3Percent>=0 AND 100>=Midterm3Percent),
									FinalPercent int CHECK(FinalPercent>=0 AND 100>=FinalPercent),
									ResitPercent int CHECK(ResitPercent>=0 AND 100>=ResitPercent),
									AveragePercent int CHECK(AveragePercent>=0 AND 100>=AveragePercent),
									LetterGrade nvarchar(2),
									CONSTRAINT PK_StudentAcademicCourses PRIMARY KEY(CourseID, StudentID, TermID, CourseYear),
									CONSTRAINT FK_SC_CourseID FOREIGN KEY(CourseID) REFERENCES Courses(CourseID)
									ON UPDATE CASCADE,
									CONSTRAINT FK_SC_StudentID FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
									ON UPDATE CASCADE,
									CONSTRAINT FK_SC_TermID FOREIGN KEY(TermID) REFERENCES Terms(TermID)
									ON UPDATE CASCADE,
									CONSTRAINT FK_SC_CourseYear FOREIGN KEY(CourseYear) REFERENCES Years([Year])
									ON UPDATE CASCADE
					)
GO
CREATE TABLE LecturerCourses(
								CourseID int,
								TermID int,
								CourseYear int,
								AcademicID int,
								CONSTRAINT PK_LecturerCourses PRIMARY KEY(CourseID, TermID, CourseYear),
								CONSTRAINT FK_LC_CourseID FOREIGN KEY(CourseID) REFERENCES Courses(CourseID)
								ON UPDATE CASCADE,
								CONSTRAINT FK_LC_AcademicID FOREIGN KEY(AcademicID) REFERENCES Academics(AcademicID)
								ON UPDATE CASCADE,
								CONSTRAINT FK_LC_TermID FOREIGN KEY(TermID) REFERENCES Terms(TermID)
								ON UPDATE CASCADE,
								CONSTRAINT FK_LC_CourseYear FOREIGN KEY(CourseYear) REFERENCES Years([Year])
								ON UPDATE CASCADE
                            )
GO
CREATE TABLE StudentTermGPA(
							StudentID int,
							TermID int,
							TermYear int,
							GPA decimal(2,1)
							CONSTRAINT PK_STGPA PRIMARY KEY(StudentID, TermID, TermYear),
							CONSTRAINT FK_STGPA_StudentID FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
							ON UPDATE CASCADE,
							CONSTRAINT FK_STGPA_TermID FOREIGN KEY(TermID) REFERENCES Terms(TermID)
							ON UPDATE CASCADE,
							CONSTRAINT FK_STGPA_CourseYear FOREIGN KEY(TermYear) REFERENCES Years([Year])
							ON UPDATE CASCADE
)

GO
CREATE TABLE Articles(
						ArticleID int,
						ArticleName nvarchar(4000) NOT NULL,
						PublicationDate date,
						CONSTRAINT PK_Articles PRIMARY KEY(ArticleID)
                     )
GO
CREATE TABLE AuthorArticles(
						ArticleID int,
						AcademicID int,
						CONSTRAINT PK_AuthorArticles PRIMARY KEY(ArticleID, AcademicID),
						CONSTRAINT FK_AA_AcademicID FOREIGN KEY(AcademicID) REFERENCES Academics(AcademicID)
						ON UPDATE CASCADE,
						CONSTRAINT FK_AA_ArticleID FOREIGN KEY(ArticleID) REFERENCES Articles(ArticleID)
						ON UPDATE CASCADE
						   )
GO


		-- Articles tablosu ekle: PublicationYear, ArticleName, AcademicID, DepartmentID
--DROP TABLE Academics
--DROP TABLE Courses
--DROP TABLE Departments
--DROP TABLE Faculties
--DROP TABLE Students
--DROP TABLE Terms
--DROP TABLE Years
--DROP TABLE RegistrationDetails
--DROP TABLE Articles
--DROP TABLE AuthorArticles
--DROP TABLE StudentTermGPA
--DROP TABLE StudentCourses
--DROP TABLE LecturerCourses
