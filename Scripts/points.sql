CREATE function shift_points()
        RETURNS TRIGGER AS $body$

        BEGIN
                UPDATE points point
                SET index = index +1
                , "flipFlag" = NOT "flipFlag"       -- alternating bit protocol ;-)
                WHERE NEW.index < OLD.index
                AND OLD."flipFlag" = NEW."flipFlag" -- redundant condition
                AND point.index >= NEW.index
                AND point.index < OLD.index
                AND point.id <> NEW.id             -- exclude the initiating row
                ;
                UPDATE points point
                SET index = index -1
                , "flipFlag" = NOT "flipFlag"
                WHERE NEW.index > OLD.index
                AND OLD."flipFlag" = NEW."flipFlag"
                AND point.index <= NEW.index
                AND point.index > OLD.index
                AND point.id <> NEW.id
                ;
                RETURN NEW;
        END;

        $body$
        language plpgsql;

CREATE TRIGGER shift_points
        AFTER UPDATE OF index ON points
        FOR EACH ROW
        WHEN (OLD."flipFlag" = NEW."flipFlag" AND OLD.index <> NEW.index)
        EXECUTE PROCEDURE shift_points()
        ;
