require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get('/librarian') do
  erb(:librarian)
end

get('/librarian/books') do
  @books = Book.all()
  erb(:books)
end

get('/librarian/books/new') do
  erb(:book_form)
end

post('/librarian/books') do
  title = params.fetch('title')
  author = params.fetch('author')
  year_published = params.fetch('year_published')
  book = Book.new({:title => title, :author => author, :year_published => year_published})
  book.save()
  @books = Book.all()
  erb(:books)
end

get('/librarian/books/:book_id') do
  @book = Book.find_by_book_id(params.fetch('book_id').to_i())
  erb(:book)
end

get('/librarian/books/:book_id/edit') do
  @book = Book.find_by_book_id(params.fetch('book_id').to_i())
  erb(:update_book_form)
end

patch('/librarian/books/:book_id') do
  title = params.fetch('title')
  author = params.fetch('author')
  year_published = params.fetch('year_published')
  @book = Book.find_by_book_id(params.fetch("book_id").to_i())
  @book.update({:title => title, :author => author, :year_published => year_published})
  erb(:book)
end

delete('/librarian/books/:book_id') do
  @book = Book.find_by_book_id(params.fetch('book_id').to_i())
  @book.delete()
  @books = Book.all()
  erb(:books)
end

get('/librarian/title_search') do
  erb(:title_search)
end

get('/librarian/author_search') do
  erb(:author_search)
end

post('/librarian/title_search') do
  title = params.fetch('title_search')
  @books = Book.find_by_title(title)
  erb(:search_results)
end

post('/librarian/author_search') do
  author = params.fetch('author_search')
  @books = Book.find_by_author(author)
  erb(:search_results)
end
