<?php

namespace Database\Factories;

use App\Models\Book;
use App\Models\Author;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class BookFactory extends Factory
{
    protected $model = Book::class;

    public function definition()
    {
        return [
            'title' => $this->faker->sentence,
            'description' => $this->faker->paragraph,
            'isbn' => $this->faker->unique()->isbn13,
            'published' => $this->faker->boolean,
            'author_id' => Author::inRandomOrder()->first()->id,
        ];
    }

    public function configure()
    {
        return $this->afterCreating(function (Book $book) {
            $categories = Category::inRandomOrder()->take(rand(1, 3))->pluck('id');
            $book->categories()->attach($categories);
        });
    }
}
