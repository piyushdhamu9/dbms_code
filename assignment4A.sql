
CREATE TABLE Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(100),
    DateOfIssue DATE,
    NameOfBook VARCHAR(100),
    Status CHAR(1) -- 'I' for Issued, 'R' for Returned
);

CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10, 2),
    FOREIGN KEY (Roll_no) REFERENCES Borrower(Roll_no)
);


INSERT INTO Borrower (Roll_no, Name, DateOfIssue, NameOfBook, Status) VALUES 
    (1, 'Alice Smith', '2024-10-01', 'Book A', 'I'),
    (2, 'Bob Johnson', '2024-09-15', 'Book B', 'I'),
    (3, 'Catherine Brown', '2024-09-25', 'Book C', 'I'),
    (4, 'David Wilson', '2024-10-05', 'Book D', 'I'),
    (5, 'Eva Green', '2024-09-01', 'Book E', 'I');


DELIMITER //

CREATE PROCEDURE CalculateFine(IN p_roll_no INT, IN p_name_of_book VARCHAR(100))
BEGIN
    DECLARE v_issue_date DATE;
    DECLARE v_current_date DATE DEFAULT CURDATE();
    DECLARE v_days_difference INT;
    DECLARE v_fine_amt DECIMAL(10, 2);

    -- Retrieve the DateOfIssue for the given roll number and book
    SELECT DateOfIssue INTO v_issue_date
    FROM Borrower
    WHERE Roll_no = p_roll_no AND NameOfBook = p_name_of_book AND Status = 'I';

    -- Calculate the number of days since the issue date
    SET v_days_difference = DATEDIFF(v_current_date, v_issue_date);

    -- Determine the fine amount based on the number of days
    IF v_days_difference BETWEEN 15 AND 30 THEN
        SET v_fine_amt = v_days_difference * 5;
    ELSEIF v_days_difference > 30 THEN
        SET v_fine_amt = (30 * 5) + ((v_days_difference - 30) * 50);
    ELSE
        SET v_fine_amt = 0;
    END IF;

    -- Update the status to 'R' (Returned)
    UPDATE Borrower
    SET Status = 'R'
    WHERE Roll_no = p_roll_no AND NameOfBook = p_name_of_book;

    -- Insert fine details into the Fine table if there is a fine
    IF v_fine_amt > 0 THEN
        INSERT INTO Fine (Roll_no, Date, Amt)
        VALUES (p_roll_no, v_current_date, v_fine_amt);
    END IF;

    -- Output the fine amount
    SELECT CONCAT('The fine amount is: ', v_fine_amt) AS FineAmount;
END //

DELIMITER ;


CALL CalculateFine(1, 'Book A');
