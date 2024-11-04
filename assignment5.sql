
-- Create Student Table
CREATE TABLE IF NOT EXISTS Student (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    Total_marks DECIMAL(5, 2)
);

-- Insert Sample Data
INSERT INTO Student (Roll_no, Name, Total_marks) VALUES (1, 'Alice', 995);
INSERT INTO Student (Roll_no, Name, Total_marks) VALUES (2, 'Bob', 920);
INSERT INTO Student (Roll_no, Name, Total_marks) VALUES (3, 'Charlie', 850);
INSERT INTO Student (Roll_no, Name, Total_marks) VALUES (4, 'Diana', 800);

-- Change Delimiter
DELIMITER //

-- Stored Procedure for Student Categorization
CREATE PROCEDURE proc_Grade (
    IN p_name VARCHAR(50),
    IN p_total_marks DECIMAL(5, 2),
    OUT p_class VARCHAR(20)
)
BEGIN
    IF p_total_marks >= 990 THEN
        SET p_class = 'Distinction';
    ELSEIF p_total_marks BETWEEN 900 AND 989 THEN
        SET p_class = 'First Class';
    ELSEIF p_total_marks BETWEEN 825 AND 899 THEN
        SET p_class = 'Higher Second Class';
    ELSE
        SET p_class = 'Second Class';
    END IF;
END //

-- Reset Delimiter
DELIMITER ;

-- Test the Procedure
CALL proc_Grade('Alice', 995, @student_class);
SELECT @student_class AS 'Class';
