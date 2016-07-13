require('pry')

class Book
  attr_reader(:book_id, :title, :author_first, :author_last, :year_published)

  define_method(:initialize) do |attributes|
    @book_id = attributes[:book_id]
    @title = attributes[:title]
    @author_first = attributes[:author_first]
    @author_last = attributes[:author_last]
    @year_published = attributes[:year_published]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      book_id = book.fetch("book_id").to_i()
      title = book.fetch("title")
      author_first = book.fetch("author_first")
      author_last = book.fetch("author_last")
      year_published = book.fetch("year_published")
      books.push(Book.new({:book_id => book_id, :title => title, :author_first => author_first, :author_last => author_last, :year_published => year_published}))
    end
    books
  end

  define_method(:==) do |other|
    self.title == other.title && self.book_id == other.book_id
  end


  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author_first, author_last, year_published) VALUES ('#{@title}', '#{@author_first}', '#{@author_last}', #{@year_published}) RETURNING book_id;")
    @book_id = result.first['book_id'].to_i()
  end

 end
