CREATE function shift_blocks()
        RETURNS TRIGGER AS $body$

        BEGIN
                UPDATE blocks block
                SET index = index +1
                , "flipFlag" = NOT "flipFlag"       -- alternating bit protocol ;-)
                WHERE NEW.index < OLD.index
                AND OLD."flipFlag" = NEW."flipFlag" -- redundant condition
                AND block.index >= NEW.index
                AND block.index < OLD.index
                AND block.id <> NEW.id             -- exclude the initiating row
                ;
                UPDATE blocks block
                SET index = index -1
                , "flipFlag" = NOT "flipFlag"
                WHERE NEW.index > OLD.index
                AND OLD."flipFlag" = NEW."flipFlag"
                AND block.index <= NEW.index
                AND block.index > OLD.index
                AND block.id <> NEW.id
                ;
                RETURN NEW;
        END;

        $body$
        language plpgsql;

CREATE TRIGGER shift_blocks
        AFTER UPDATE OF index ON blocks
        FOR EACH ROW
        WHEN (OLD."flipFlag" = NEW."flipFlag" AND OLD.index <> NEW.index)
        EXECUTE PROCEDURE shift_blocks()
        ;
