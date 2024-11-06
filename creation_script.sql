DROP TABLE IF EXISTS bookInCart CASCADE;
DROP TABLE IF EXISTS "comment" CASCADE;
DROP TABLE IF EXISTS administrator CASCADE;
DROP TABLE IF EXISTS "order" CASCADE;
DROP TABLE IF EXISTS shoppingCart CASCADE;
DROP TABLE IF EXISTS wishlist CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS author CASCADE;
DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS book_Author CASCADE;


DROP TYPE IF EXISTS orderstatus CASCADE;
DROP TYPE IF EXISTS formattype CASCADE;


DROP DOMAIN IF EXISTS rating CASCADE;
DROP DOMAIN IF EXISTS price CASCADE;


CREATE TYPE orderstatus AS ENUM('PENDING', 'SHIPPED', 'COMPLETED');
CREATE TYPE formattype AS ENUM('HARDCOVER', 'PAPERBACK', 'EBOOK');


CREATE DOMAIN rating AS DECIMAL(2, 1) 
CHECK (VALUE >= 0 AND VALUE <= 10);

CREATE DOMAIN price AS DECIMAL(4,2);


CREATE TABLE "user" (
    id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    status BOOLEAN NOT NULL
);

CREATE TABLE administrator (
    id INT PRIMARY KEY,
    userId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES "user"(id)
);

CREATE TABLE category (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE author (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE book (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    numberOfPages INT CHECK (numberOfPages > 0) NOT NULL,
    edition VARCHAR(100),
    score rating,
    format formattype NOT NULL,
    status BOOLEAN NOT NULL,
    price  price CHECK (price >= 0) NOT NULL,
    categoryId INT NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES category(id)
);

CREATE TABLE book_Author (
    id_book INT NOT NULL,
    id_author INT NOT NULL,
    PRIMARY KEY (id_book, id_author),
    FOREIGN KEY (id_book) REFERENCES book(id),
    FOREIGN KEY (id_author) REFERENCES author(id)
);

CREATE TABLE "comment" (
    id INT PRIMARY KEY,
    content TEXT NOT NULL,
    userId INT NOT NULL,
    bookId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES "user"(id),
    FOREIGN KEY (bookId) REFERENCES book(id) ON DELETE CASCADE
);

CREATE TABLE country (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    id INT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    number VARCHAR(10) NOT NULL,
    zipcode VARCHAR(20) NOT NULL,
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100) NOT NULL,
    countryId INT NOT NULL,
    FOREIGN KEY (countryId) REFERENCES country(id)
);

CREATE TABLE shoppingCart (
    id INT PRIMARY KEY,
    price price CHECK (price >= 0) NOT NULL,
    userId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES "user"(id)
);

CREATE TABLE bookInCart (
    cartId INT NOT NULL,
    bookId INT NOT NULL,
    quantity INT CHECK (quantity >= 0) NOT NULL,
    price price CHECK (price >= 0) NOT NULL,
    PRIMARY KEY (cartId, bookId),
    FOREIGN KEY (cartId) REFERENCES shoppingCart(id) ON DELETE CASCADE,
    FOREIGN KEY (bookId) REFERENCES book(id)
);

CREATE TABLE "order" (
    id INT PRIMARY KEY,
    status orderstatus NOT NULL,
    purchaseDate DATE DEFAULT CURRENT_DATE NOT NULL,
    totalPrice price CHECK (totalPrice >= 0) NOT NULL,
    userId INT NOT NULL,
    shoppingCartId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES "user"(id),
    FOREIGN KEY (shoppingCartId) REFERENCES shoppingCart(id)
);

CREATE TABLE wishlist (
    userId INT NOT NULL,
    bookId INT NOT NULL,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES "user"(id),
    FOREIGN KEY (bookId) REFERENCES book(id)
);
