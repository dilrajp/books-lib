import React, { useState, useMemo } from "react";

const Index = ({ books }) => {
  const [selectedAuthor, setSelectedAuthor] = useState("");
  const [selectedISBN, setSelectedISBN] = useState("");
  const [selectedTitle, setSelectedTitle] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [booksPerPage] = useState(12);

  const filteredBooks = useMemo(() => {
    return books.data.filter((book) => {
      return (
        book.author.name.toLowerCase().includes(selectedAuthor.toLowerCase()) &&
        book.isbn.includes(selectedISBN) &&
        book.title.toLowerCase().includes(selectedTitle.toLowerCase())
      );
    });
  }, [selectedAuthor, selectedISBN, selectedTitle, books.data]);

  const indexOfLastBook = currentPage * booksPerPage;
  const indexOfFirstBook = indexOfLastBook - booksPerPage;
  const currentBooks = filteredBooks.slice(indexOfFirstBook, indexOfLastBook);
  const totalPages = Math.ceil(filteredBooks.length / booksPerPage);

  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  return (
    <div className="bg-[#0A2647] text-white min-h-screen">
      <header className="py-8 px-4 md:px-8 bg-[#0A2647] shadow-md">
        <h1 className="text-3xl font-bold">Book List</h1>
      </header>
      <main className="py-8 px-4 md:px-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div>
            <label htmlFor="author" className="block mb-2 text-sm font-medium">
              Author
            </label>
            <input
              type="text"
              id="author"
              value={selectedAuthor}
              onChange={(e) => setSelectedAuthor(e.target.value)}
              className="bg-[#0F3460] border-none rounded-md py-2 px-4 text-white focus:outline-none focus:ring-2 focus:ring-[#1B98E0]"
              placeholder="Search by author"
            />
          </div>
          <div>
            <label htmlFor="isbn" className="block mb-2 text-sm font-medium">
              ISBN
            </label>
            <input
              type="text"
              id="isbn"
              value={selectedISBN}
              onChange={(e) => setSelectedISBN(e.target.value)}
              className="bg-[#0F3460] border-none rounded-md py-2 px-4 text-white focus:outline-none focus:ring-2 focus:ring-[#1B98E0]"
              placeholder="Search by ISBN"
            />
          </div>
          <div>
            <label htmlFor="title" className="block mb-2 text-sm font-medium">
              Title
            </label>
            <input
              type="text"
              id="title"
              value={selectedTitle}
              onChange={(e) => setSelectedTitle(e.target.value)}
              className="bg-[#0F3460] border-none rounded-md py-2 px-4 text-white focus:outline-none focus:ring-2 focus:ring-[#1B98E0]"
              placeholder="Search by title"
            />
          </div>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {currentBooks.map((book) => (
            <div
              key={book.id}
              className="bg-[#0F3460] rounded-lg overflow-hidden shadow-lg"
            >
              <div className="p-4">
                <h3 className="text-xl font-bold mb-2">{book.title}</h3>
                <p className="text-sm text-gray-400 mb-2">{book.author.name}</p>
                <p className="text-sm text-gray-400">{book.isbn}</p>
              </div>
            </div>
          ))}
        </div>
        <div className="flex justify-center mt-8">
          <nav aria-label="Page navigation example">
            <ul className="inline-flex -space-x-px text-sm">
              <li>
                <button
                  onClick={() => handlePageChange(currentPage - 1)}
                  className="flex items-center justify-center px-3 h-8 ms-0 leading-tight text-gray-500 bg-white border border-e-0 border-gray-300 rounded-s-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                  disabled={currentPage === 1}
                >
                  Previous
                </button>
              </li>
              {[...Array(totalPages).keys()].map((number) => (
                <li key={number + 1}>
                  <button
                    onClick={() => handlePageChange(number + 1)}
                    className={`flex items-center justify-center px-3 h-8 leading-tight ${
                      number + 1 === currentPage
                        ? "text-blue-600 bg-blue-50 border-gray-300 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white"
                        : "text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                    }`}
                  >
                    {number + 1}
                  </button>
                </li>
              ))}
              <li>
                <button
                  onClick={() => handlePageChange(currentPage + 1)}
                  className="flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 rounded-e-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                  disabled={currentPage === totalPages}
                >
                  Next
                </button>
              </li>
            </ul>
          </nav>
        </div>
      </main>
    </div>
  );
};

export default Index;
