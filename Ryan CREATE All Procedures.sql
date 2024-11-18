DELIMITER $$ 
-- Insertion procedure for Report table
CREATE PROCEDURE insert_report (
    IN in_id INT,
    IN in_fid INT,
    IN in_year YEAR
) BEGIN
INSERT INTO
    report (id, fid, year)
VALUES
    (in_id, in_fid, in_year);
END $$ 

-- Insertion procedure for Manages_Report table
CREATE PROCEDURE insert_manages_report (
    IN in_fid INT, 
    IN in_rid INT
) BEGIN
INSERT INTO
    manages_report (fid, rid)
VALUES
    (in_fid, in_rid);
END $$

-- Insertion procedure for Project table
CREATE PROCEDURE insert_project (
    IN in_name CHAR(255),
    IN in_funding_id INT,
    IN in_num_student_researchers INT,
    IN in_faculty_commitment CHAR(50),
    IN in_start_date DATE,
    IN in_end_date DATE
) BEGIN
INSERT INTO
    project (
        name,
        funding_id,
        num_student_researchers,
        faculty_commitment,
        start_date,
        end_date
    )
VALUES
    (
        in_name,
        in_funding_id,
        in_num_student_researchers,
        in_faculty_commitment,
        in_start_date,
        in_end_date
    );
END $$ 

-- Insertion procedure for Manages_Project table
CREATE PROCEDURE insert_manages_project (
    IN in_fid INT, 
    IN in_p_name CHAR(255)
) BEGIN
INSERT INTO
    manages_project (fid, p_name)
VALUES
    (in_fid, in_p_name);
END $$

-- Insertion procedure for Funding table
CREATE PROCEDURE insert_funding (
    IN in_trans_id INT,
    IN in_source CHAR(255),
    IN in_amount DECIMAL(10, 2)
) BEGIN
INSERT INTO
    funding (trans_id, source, amount)
VALUES
    (in_trans_id, in_source, in_amount);
END $$ 


------------------------------------------
-- Funtional Requirements
------------------------------------------
-- R1 (Alex) Course Report for given faculty member, year
CREATE PROCEDURE course_report (
    IN in_FID INT,
    IN in_Year INT -- Casting YEAR as INT
) BEGIN
SELECT
    *
FROM
    all_course_reports_view
WHERE
    Year = in_Year
    AND FID = in_FID;
END $$ 

-- R5B (Ryan) Projects for given faculty member
CREATE PROCEDURE manages_project_report (
    IN in_FID INT
) BEGIN
SELECT
    FID,
    p.Name as Name,
    Num_Student_Researchers,
    Faculty_Commitment,
    Start_Date,
    End_Date
FROM
    manages_project m
    JOIN project p ON m.p_name = p.name
WHERE
    in_FID = FID;
END $$ 

-- R5C (Ryan) Funding: For given faculty members projects
CREATE PROCEDURE funding_report (
    IN in_FID INT
) BEGIN
SELECT
    FID,
    p.Name,
    Source,
    Amount,
    Num_Student_Researchers,
    Faculty_Commitment,
    Start_Date,
    End_Date
FROM
    funding f
    JOIN (
        SELECT
            FID,
            p.Name AS Name,
            Num_Student_Researchers,
            Faculty_Commitment,
            Start_Date,
            End_Date
        FROM
            manages_project m
            JOIN project p ON m.p_name = p.name
    ) AS p ON f.p_name = p.name
WHERE
    FID = in_FID;
END $$ 

 -- R5D (Ryan) Surveys for given faculty member
CREATE PROCEDURE survey_report (
    IN in_FID INT
)
BEGIN
    SELECT 
        *
    FROM survey s
    JOIN TypeOfSurvey t;
END $$

-- R5E (Ryan) Time-tracking of ? for given faculty member
CREATE PROCEDURE time_tracking (
    IN in_FID
)

-- R5F (Ryan) Annual Report of Courses, Projects, Surveys for given faculty member of each year
CREATE PROCEDURE annual_report (
    IN in_FID INT
) BEGIN
    -- Fetch Course Details
    SELECT
        *
    FROM
        all_course_reports_view
    WHERE FID = in_FID;

    -- Fetch Project Details
    SELECT 
        FID,
        p.Name AS Project_Name,
        p.Num_Student_Researchers,
        p.Faculty_Commitment,
        p.Start_Date,
        p.End_Date
    FROM project p
    JOIN manages_project mp ON p.Name = mp.P_Name
    WHERE mp.FID = in_FID;

    -- Fetch Survey Details FIXME
    SELECT 
        FID,
        f.P_Name AS FIX_THIS_QUERY,
        f.Source AS GET_SURVEYS_TABLE,
        f.Amount AS WORKING
    FROM survey s
    LEFT JOIN TypeOfSurvey t 
    ON s.type = m.type
    WHERE s.FID = in_FID;
END $$

-- OEF Reset Statement
DELIMITER;