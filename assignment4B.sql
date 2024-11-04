CREATE TABLE Areas (
    Radius DECIMAL(5, 2),
    Area DECIMAL(10, 2)
);


DELIMITER //

CREATE PROCEDURE CalculateAreas()
BEGIN
    DECLARE r INT;

    SET r = 5;

    WHILE r <= 9 DO
        DECLARE v_area DECIMAL(10, 2);

        -- Calculate the area of the circle
        SET v_area = 3.14159 * r * r;

        -- Insert the radius and area into the Areas table
        INSERT INTO Areas (Radius, Area) VALUES (r, v_area);

        SET r = r + 1; -- Increment the radius
    END WHILE;

    COMMIT; -- Commit the transaction
END; //

DELIMITER ;


CALL CalculateAreas();

SELECT * FROM Areas;
