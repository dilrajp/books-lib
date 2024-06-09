# Laravel Inertia.js Project

This is a Laravel project integrated with Inertia.js. It provides a basic structure for managing books with categories and authors, including CRUD operations.

## Prerequisites

- PHP >= 8.0
- Composer
- Node.js & npm
- PostgreSQL

## Installation

**Steps to run:**

```sh
   git clone https://github.com/dilrajp/books-lib
   cd books-lib
   composer install
   npm install
   cp .env.example .env

   Open the .env file and configure the following settings:
	DB_CONNECTION=pgsql (or your preferred database)
	DB_HOST=127.0.0.1
	DB_PORT=5432
	DB_DATABASE=your_database_name
	DB_USERNAME=your_database_username
	DB_PASSWORD=your_database_password

    php artisan key:generate
    php artisan migrate
    php artisan db:seed

    npm run dev
    php artisan serve
```

## API Endpoints

Add book

    URL: POST /api/books/add
    Body: { "title": "The New Book", "author_id": 1, "description": "This is a new book.", "isbn": "978-1234567890", "published": true ,"categories": [1, 2] }

Update Book

    URL: PUT /api/books/{id}
    Body: { "title": "The Updated Book", "published": true }

Delete a Book

    URL: DELETE /api/books/{id}
