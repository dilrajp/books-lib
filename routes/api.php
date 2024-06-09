<?php

use App\Http\Controllers\BookController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/books/list', [BookController::class, 'list'])->name('api.books.list');
Route::post('/books/add', [BookController::class, 'store'])->name('api.books.store');
Route::get('/books/{id}', [BookController::class, 'show'])->name('api.books.show');
Route::put('/books/update/{id}', [BookController::class, 'update'])->name('api.books.update');
Route::delete('/books/remove/{id}', [BookController::class, 'destroy'])->name('api.books.destroy');
