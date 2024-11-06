-- full-search indices
ALTER TABLE book
ADD COLUMN tsvectors TSVECTOR;

CREATE FUNCTION book_search_update() RETURNS TRIGGER AS $$
BEGIN

    IF TG_OP = 'INSERT' THEN
        NEW.tsvectors = (
            setweight(to_tsvector('english', NEW.title), 'A') ||
            setweight(to_tsvector('english', COALESCE(NEW.edition, '')), 'B')
        );
    END IF;

    IF TG_OP = 'UPDATE' THEN
        IF (NEW.title <> OLD.title OR NEW.edition <> OLD.edition) THEN
            NEW.tsvectors = (
                setweight(to_tsvector('english', NEW.title), 'A') ||
                setweight(to_tsvector('english', COALESCE(NEW.edition, '')), 'B')
            );
        END IF;
    END IF;

    RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER book_search_update
BEFORE INSERT OR UPDATE ON book
FOR EACH ROW
EXECUTE PROCEDURE book_search_update();

CREATE INDEX search_book_idx ON book USING GIN (tsvectors);


