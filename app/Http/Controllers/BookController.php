<?php

namespace App\Http\Controllers;

use App\Models\Book;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class BookController extends Controller
{

    protected function getBooksQuery(Request $request)
    {
        $query = Book::with('author', 'categories');

        if ($request->has('category')) {
            $category = $request->input('category');
            $query->whereHas('categories', function ($q) use ($category) {
                $q->where('name', 'like', "%$category%");
            });
        }

        if ($request->has('book_title') || $request->has('isbn') || $request->has('author_name')) {
            $query->where(function ($q) use ($request) {
                if ($request->has('book_title')) {
                    $bookTitle = $request->input('book_title');
                    $q->where('title', 'like', "%$bookTitle%");
                }

                if ($request->has('isbn')) {
                    $isbn = $request->input('isbn');
                    $q->orWhere('isbn', 'like', "%$isbn%");
                }

                if ($request->has('author_name')) {
                    $authorName = $request->input('author_name');
                    $q->orWhereHas('author', function ($q) use ($authorName) {
                        $q->where('name', 'like', "%$authorName%");
                    });
                }
            });
        }

        return $query;
    }


    public function index(Request $request)
    {
        $query = $this->getBooksQuery($request);

        $perPage = $request->input('limit', 100);
        $page = $request->input('page', 1);
        $offset = $request->input('offset', 0);

        $books = $query->skip($offset)->paginate($perPage, ['*'], 'page', $page);

        return Inertia::render('Books/Index', [
            'books' => $books,
        ]);
    }

    public function list(Request $request)
    {
        $query = $this->getBooksQuery($request);

        $perPage = $request->input('limit', 10);
        $page = $request->input('page', 1);
        $offset = $request->input('offset', 0);

        $books = $query->skip($offset)->paginate($perPage, ['*'], 'page', $page);

        return response()->json($books);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'author_id' => 'required|exists:authors,id',
            'description' => 'nullable|string',
            'isbn' => 'required|string|unique:books,isbn',
            'published' => 'required|boolean',
            'categories' => 'array|exists:categories,id'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $validatedData = $validator->validated();

        try {
            $book = Book::create($validatedData);

            if ($request->has('categories')) {
                $book->categories()->attach($request->categories);
            }

            return response()->json($book, 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to create book', 'message' => $e->getMessage()], 500);
        }
    }

    public function show($id)
    {
        $book = Book::with('author', 'categories')->findOrFail($id);
        return response()->json($book);
    }

    public function update(Request $request, $id)
    {
        $book = Book::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'title' => 'sometimes|required|string|max:255',
            'author_id' => 'sometimes|required|exists:authors,id',
            'description' => 'nullable|string',
            'isbn' => 'sometimes|required|string|unique:books,isbn,' . $book->id,
            'published' => 'required|boolean',
            'categories' => 'array|exists:categories,id'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $validatedData = $validator->validated();

        try {
            $book->update($validatedData);
            if ($request->has('categories')) {
                $book->categories()->sync($request->categories);
            }

            return response()->json($book);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to update book', 'message' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $book = Book::findOrFail($id);
            $book->categories()->detach();
            $book->delete();

            return response()->json(null, 204);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete book', 'message' => $e->getMessage()], 500);
        }
    }
}
