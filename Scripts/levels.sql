CREATE function shift_levels()
        RETURNS TRIGGER AS $body$

        BEGIN
                UPDATE levels level
                SET index = index +1
                , "flipFlag" = NOT "flipFlag"       -- alternating bit protocol ;-)
                WHERE NEW.index < OLD.index
                AND OLD."flipFlag" = NEW."flipFlag" -- redundant condition
                AND level.index >= NEW.index
                AND level.index < OLD.index
                AND level.id <> NEW.id             -- exclude the initiating row
                ;
                UPDATE levels level
                SET index = index -1
                , "flipFlag" = NOT "flipFlag"
                WHERE NEW.index > OLD.index
                AND OLD."flipFlag" = NEW."flipFlag"
                AND level.index <= NEW.index
                AND level.index > OLD.index
                AND level.id <> NEW.id
                ;
                RETURN NEW;
        END;

        $body$
        language plpgsql;

CREATE TRIGGER shift_levels
        AFTER UPDATE OF index ON levels
        FOR EACH ROW
        WHEN (OLD."flipFlag" = NEW."flipFlag" AND OLD.index <> NEW.index)
        EXECUTE PROCEDURE shift_levels()
        ;
