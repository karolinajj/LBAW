CREATE OR REPLACE FUNCTION update_price_based_on_quantity() RETURNS TRIGGER AS
$BODY$
BEGIN
    SELECT price INTO NEW.price 
    FROM book 
    WHERE id = NEW.bookId;

    NEW.price := NEW.quantity * COALESCE((SELECT price FROM book WHERE id = NEW.bookId), 0);
    
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_cart_price
BEFORE INSERT OR UPDATE ON bookInCart
FOR EACH ROW
EXECUTE PROCEDURE update_price_based_on_quantity();

-- 
CREATE OR REPLACE FUNCTION update_shopping_cart_price() RETURNS TRIGGER AS
$BODY$
BEGIN
    SELECT SUM(price) INTO NEW.price
    FROM bookInCart
    WHERE cartId = NEW.id;

    IF NEW.price IS NULL THEN
        NEW.price := 0;
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_shopping_cart_total_price
AFTER INSERT OR UPDATE OR DELETE ON bookInCart
FOR EACH ROW
EXECUTE PROCEDURE update_shopping_cart_price();

-- 
CREATE OR REPLACE FUNCTION update_order_total_price() RETURNS TRIGGER AS
$BODY$
BEGIN
    SELECT price INTO NEW.totalPrice
    FROM shoppingCart
    WHERE id = NEW.shoppingCartId;

    IF NEW.totalPrice IS NULL THEN
        NEW.totalPrice := 0;
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_order_total_price_trigger
AFTER INSERT OR UPDATE ON "order"
FOR EACH ROW
EXECUTE PROCEDURE update_order_total_price();

-- 
CREATE OR REPLACE FUNCTION remove_book_from_carts() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.status = FALSE THEN
        DELETE FROM bookInCart
        WHERE bookId = OLD.id;

        DELETE FROM shoppingCart
        WHERE id NOT IN (
            SELECT DISTINCT cartId
            FROM bookInCart
        );
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_book_from_carts_trigger
AFTER UPDATE ON book
FOR EACH ROW
EXECUTE PROCEDURE remove_book_from_carts();

-- 
CREATE OR REPLACE FUNCTION validate_comment_purchase() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM "order" o
        WHERE o.userId = NEW.userId
          AND o.shoppingCartId IN (
              SELECT sc.id
              FROM shoppingCart sc
              JOIN bookInCart bic ON sc.id = bic.cartId
              WHERE bic.bookId = NEW.bookId
          )
    ) THEN
        RAISE EXCEPTION 'User % cannot comment on book % because they have not purchased it.', NEW.userId, NEW.bookId;
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER validate_comment_purchase_trigger
BEFORE INSERT ON "comment"
FOR EACH ROW
EXECUTE PROCEDURE validate_comment_purchase();

-- 
CREATE OR REPLACE FUNCTION remove_books_from_cart() RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM bookInCart
    WHERE cartId = NEW.shoppingCartId;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_books_from_cart_trigger
AFTER INSERT ON "order"
FOR EACH ROW
EXECUTE PROCEDURE remove_books_from_cart();

-- 
CREATE OR REPLACE FUNCTION remove_book_from_wishlist() RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM wishlist
    WHERE userId = NEW.userId AND bookId IN (
        SELECT bookId 
        FROM bookInCart 
        WHERE cartId = NEW.shoppingCartId
    );

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;



