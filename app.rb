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
  @book = Book.find_by_book_id(params.fetch("book_id").to_i())
  title = params.fetch('title')
  if title.==('')
    title = @book.title()
  end
  author = params.fetch('author')
  if author.==('')
    author = @book.author()
  end
  year_published = params.fetch('year_published')
  if year_published.==('')
    year_published = @book.year_published()
  end
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

# PATRON-LIBRARIAN

get('/librarian/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

get('/librarian/patrons/new') do
  erb(:patron_form)
end

post('/librarian/patrons') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  patron = Patron.new({:name => name, :phone => phone})
  patron.save()
  @patrons = Patron.all()
  erb(:patrons)
end

get('/librarian/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  erb(:patron)
end

get('/librarian/patrons/:patron_id/edit') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  erb(:update_patron_form)
end

patch('/librarian/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch("patron_id").to_i())
  name = params.fetch('name')
  if name.==('')
    name = @patron.name()
  end
  phone = params.fetch('phone')
  if phone.==('')
    phone = @patron.phone()
  end
  @patron.update({:name => name, :phone => phone})
  erb(:patron)
end

delete('/librarian/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:patrons)
end

#PATRON PATH

get ('/patron') do
  erb(:patron_home)
end

get ('/patron/new') do
  erb(:create_account)
end

get('/patron/patrons') do
  @patrons = Patron.all()
  erb(:patrons_home)
end

post('/patron/patrons') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  patron = Patron.new({:name => name, :phone => phone})
  patron.save()
  @patrons = Patron.all()
  erb(:patrons_home)
end

get('/patron/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  erb(:patron_account)
end

get('/patron/patrons/:patron_id/edit') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  erb(:patron_update_account)
end

patch('/patron/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch("patron_id").to_i())
  name = params.fetch('name')
  if name.==('')
    name = @patron.name()
  end
  phone = params.fetch('phone')
  if phone.==('')
    phone = @patron.phone()
  end
  @patron.update({:name => name, :phone => phone})
  erb(:patron_account)
end

delete('/patron/patrons/:patron_id') do
  @patron = Patron.find_by_patron_id(params.fetch('patron_id').to_i())
  @patron.delete()
  @patrons = Patron.all()
  erb(:patrons_home)
end

get('/patron/books') do
  @books = Book.all()
  erb(:books)
end

get('/patron/author_search') do
  erb(:author_search)
end

get('/patron/title_search') do
  erb(:title_search)
end
