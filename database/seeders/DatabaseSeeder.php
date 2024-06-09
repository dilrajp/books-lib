<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Author;
use App\Models\Category;
use App\Models\Book;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        \DB::table('book_category')->delete();
        Book::query()->delete();
        Author::query()->delete();
        Category::query()->delete();

        Author::factory()->count(10)->create();
        Category::factory()->count(5)->create();

        $authors = Author::all();
        $categories = Category::all();

        // Book::factory()->count(50)->make()->each(function ($book) use ($authors, $categories) {
        //     $book->author_id = $authors->random()->id;
        //     $book->category_id = $categories->random()->id;
        //     $book->save();
        // });

        Book::factory()->count(50)->create();
    }
}
