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
