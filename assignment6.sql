
-- Create tables
CREATE TABLE old_roll (
    roll INT,
    name VARCHAR(10)
);

CREATE TABLE new_roll (
    roll INT,
    name VARCHAR(10)
);

-- Insert sample data into old_roll
INSERT INTO old_roll VALUES (4, 'd');
INSERT INTO old_roll VALUES (3, 'bcd');
INSERT INTO old_roll VALUES (1, 'bc');
INSERT INTO old_roll VALUES (5, 'bch');

-- Insert sample data into new_roll
INSERT INTO new_roll VALUES (2, 'b');
INSERT INTO new_roll VALUES (5, 'bch');
INSERT INTO new_roll VALUES (1, 'bc');

delimiter $
create procedure roll_list()
begin
    declare oldrollnumber int;
    declare oldname varchar(10);
    declare newrollnumber int;
    declare newname varchar(10);
    declare done int default false;

    -- Declare cursors for the old and new tables
    declare c1 cursor for select roll, name from old_roll;
    declare c2 cursor for select roll, name from new_roll;

    -- Continue handler for when there are no more rows to fetch
    declare continue handler for not found set done = true;

    -- Open c1 and c2 cursors
    open c1;
    open c2;

    -- Loop through the records in old_roll using c1
    loop1: loop
        fetch c1 into oldrollnumber, oldname;
        if done then
            leave loop1;
        end if;

        -- Reset the `done` variable and start reading from the beginning of c2
        set done = false;

        loop2: loop
            fetch c2 into newrollnumber, newname;

            if oldrollnumber = newrollnumber then
                leave loop2;
            end if;

            if done then
                insert into new_roll values(oldrollnumber, oldname);
                set done = false;
                leave loop2;
            end if;

            
        end loop loop2;
    end loop loop1;

    -- Close both cursors
    close c1;
    close c2;
end $
delimiter ;

call call_list();

select * from new_roll;