-- Create Person table
CREATE TABLE Person
(
    PersonId INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(128) NOT NULL,
    MiddelInitial NVARCHAR(10),
    LastName NVARCHAR(128) NOT NULL,
    DateOfBirth DATE NOT NULL
)

-- Create Student table
CREATE TABLE Student
(
    StudentId INT IDENTITY PRIMARY KEY,
    PersonId INT REFERENCES Person (PersonId),
    Email NVARCHAR(256)
)

-- Create Course table
CREATE TABLE Course
(
    CourseId INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Teacher NVARCHAR(256) NOT NULL
)

-- Create Credit table
CREATE TABLE Credit
(
    StudentId INT REFERENCES Student (StudentId),
    CourseId INT REFERENCES Course (CourseId),
    Grade DECIMAL(5,2) CHECK (Grade <= 100.00),
    Attempt TINYINT,
    CONSTRAINT [UQ_studentgrades] UNIQUE CLUSTERED
    (
        StudentId, CourseId, Grade, Attempt
    )
)