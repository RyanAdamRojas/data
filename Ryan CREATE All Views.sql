CREATE VIEW All_Course_Reports_View AS
SELECT
    f.FID,
    FFirstName AS First_Name,
    FLastName AS Last_Name,
    FEmailAddress AS Email,
    cr.RID,
    cr.Year,
    cr.Course_Name,
    cr.CRN,
    cr.Num_Students,
    cr.Reviews,
    cr.CCQIP
FROM
    facultymember f
    JOIN (
        SELECT
            r.fid AS FID,
            r.id AS RID,
            r.Year,
            course.CName AS Course_Name,
            course.CRN,
            course.CNumberOfStudents AS Num_Students,
            coursereviews.CCourseReviews AS Reviews,
            coursereviews.CCQIP
        FROM
            report r
            JOIN course ON r.fid = course.FID
            JOIN coursereviews ON course.cid = coursereviews.cid
    ) AS cr ON f.fid = cr.fid;

-- VIEW Small_Projects
CREATE VIEW Small_Projects_View AS
SELECT
    *
FROM
    project
WHERE
    Num_Student_Researchers <= 3;