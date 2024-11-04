
CREATE TABLE Library (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_year INT
);

CREATE TABLE Library_Audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    library_id INT,
    old_title VARCHAR(255),
    old_author VARCHAR(255),
    old_publication_year INT,
    change_type ENUM('UPDATE', 'DELETE'),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Library (title, author, publication_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949);



DELIMITER //

CREATE TRIGGER before_update_library
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (library_id, old_title, old_author, old_publication_year, change_type)
    VALUES (OLD.id, OLD.title, OLD.author, OLD.publication_year, 'UPDATE');
END; //

DELIMITER ;



DELIMITER //

CREATE TRIGGER before_delete_library
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (library_id, old_title, old_author, old_publication_year, change_type)
    VALUES (OLD.id, OLD.title, OLD.author, OLD.publication_year, 'DELETE');
END; //

DELIMITER ;


UPDATE Library
SET title = 'The Great Gatsby (Revised)', publication_year = 2021
WHERE id = 1;  -- Assuming this is the ID of 'The Great Gatsby'


DELETE FROM Library
WHERE id = 2;  -- Assuming this is the ID of 'To Kill a Mockingbird'


SELECT * FROM Library_Audit;
