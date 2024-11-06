INSERT INTO "user" (id, username, email, password, status) VALUES
    (1, 'johndoe', 'johndoe@example.pt', 'password1', TRUE),
    (2, 'janedoe', 'janedoe@example.pt', 'password2', TRUE),
    (3, 'adminuser', 'admin@example.pt', 'password3', TRUE),
    (4, 'user4', 'userfour@example.pt', 'password4', FALSE),
    (5, 'adamx', 'xxadam@example.pt', 'password5', TRUE),
    (6, 'elene123', 'myemail123@example.pt', 'password6', FALSE),
    (7, 'user7', 'userseven@example.pt', 'password7', TRUE);

INSERT INTO administrator (id, userId) VALUES
    (1, 3),
    (2, 6);

INSERT INTO category (id, name) VALUES
    (1, 'Fiction'),
    (2, 'Science Fiction'),
    (3, 'Romance'),
    (4, 'Fantasy'),
    (5, 'Mystery'),
    (6, 'Thriller'),
    (7, 'Non-Fiction');

INSERT INTO author (id, name) VALUES
    (1, 'Isaac Asimov'),
    (2, 'Arthur C. Clarke'),
    (3, 'Jane Austen'),
    (4, 'George Orwell'),
    (5, 'Agatha Christie'),
    (6, 'J.K. Rowling'),
    (7, 'Stephen King');

INSERT INTO book (id, title, numberOfPages, edition, score, format, status, price, categoryId) VALUES
    (1, 'Foundation', 255, 'First', 9.5, 'HARDCOVER', TRUE, 29.99, 2),
    (2, 'Pride and Prejudice', 432, 'Second', 8.8, 'PAPERBACK', TRUE, 19.99, 3),
    (3, '1984', 328, 'Third', 9.2, 'HARDCOVER', TRUE, 24.99, 1),
    (4, 'The Hobbit', 310, 'First', 9.0, 'EBOOK', TRUE, 14.99, 4),
    (5, 'Murder on the Orient Express', 256, 'Fourth', 8.5, 'PAPERBACK', TRUE, 18.99, 5),
    (6, 'Harry Potter and the Sorcerer''s Stone', 309, 'First', 9.7, 'HARDCOVER', TRUE, 34.99, 4),
    (7, 'The Shining', 447, 'Special', 8.9, 'HARDCOVER', TRUE, 27.99, 6);

INSERT INTO book_author (id_book, id_author) VALUES
    (1, 1),
    (2, 3),
    (3, 4),
    (4, 6),
    (5, 5),
    (6, 6),
    (7, 7);

INSERT INTO "comment" (id, content, userId, bookId) VALUES
    (1, 'Amazing book, highly recommended!', 1, 1),
    (2, 'A timeless classic.', 2, 2),
    (3, 'Thought-provoking and chilling.', 3, 3),
    (4, 'A wonderful journey in fantasy.', 4, 4),
    (5, 'A must-read for mystery lovers.', 5, 5),
    (6, 'Incredible world-building.', 6, 6),
    (7, 'Truly terrifying!', 7, 7);

INSERT INTO country (id, name) VALUES
    (1, 'United States'),
    (2, 'United Kingdom'),
    (3, 'Canada'),
    (4, 'Australia'),
    (5, 'Germany'),
    (6, 'France'),
    (7, 'Japan');

INSERT INTO address (id, street, number, zipcode, city, district, countryId) VALUES
    (1, 'Main St', '123', '12345', 'New York', 'Manhattan', 1),
    (2, 'Baker St', '221B', 'NW16XE', 'London', 'Westminster', 2),
    (3, 'Maple Ave', '45', 'M4B1B3', 'Toronto', 'Ontario', 3),
    (4, 'Queen St', '10', '3000', 'Sydney', 'New South Wales', 4),
    (5, 'Hauptstrasse', '5', '10115', 'Berlin', 'Mitte', 5),
    (6, 'Rue de Rivoli', '34', '75001', 'Paris', 'Paris', 6),
    (7, 'Shibuya St', '2', '150-0002', 'Tokyo', 'Shibuya', 7);

INSERT INTO shoppingCart (id, price, userId) VALUES
    (1, 89.97, 1),
    (2, 39.99, 2),
    (3, 24.99, 3),
    (4, 59.99, 4),
    (5, 18.99, 5),
    (6, 34.99, 6),
    (7, 99.99, 7);

INSERT INTO bookInCart (cartId, bookId, quantity, price) VALUES
    (1, 1, 1, 29.99),
    (1, 2, 1, 19.99),
    (1, 3, 1, 24.99),
    (2, 4, 2, 14.99),
    (3, 5, 1, 18.99),
    (4, 6, 1, 34.99),
    (5, 7, 1, 27.99);

INSERT INTO "order" (id, status, purchaseDate, totalPrice, userId, shoppingCartId) VALUES
    (1, 'PENDING', '2024-01-15', 89.97, 1, 1),
    (2, 'SHIPPED', '2024-01-16', 39.99, 2, 2),
    (3, 'COMPLETED', '2024-01-17', 24.99, 3, 3),
    (4, 'PENDING', '2024-01-18', 59.99, 4, 4),
    (5, 'SHIPPED', '2024-01-19', 18.99, 5, 5),
    (6, 'COMPLETED', '2024-01-20', 34.99, 6, 6),
    (7, 'PENDING', '2024-01-21', 99.99, 7, 7);

INSERT INTO wishlist (userId, bookId) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7);
