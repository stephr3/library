require('pry')

class Book
  attr_reader(:book_id, :title, :author, :year_published)

  define_method(:initialize) do |attributes|
    @book_id = attributes[:book_id]
    @title = attributes[:title]
    @author = attributes[:author]
    @year_published = attributes[:year_published]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      book_id = book.fetch("book_id").to_i()
      title = book.fetch("title")
      author = book.fetch("author")
      year_published = book.fetch("year_published")
      books.push(Book.new({:book_id => book_id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_method(:==) do |other|
    self.title.==(other.title).&(self.book_id.==(other.book_id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author, year_published) VALUES ('#{@title}', '#{@author}', #{@year_published}) RETURNING book_id;")
    @book_id = result.first['book_id'].to_i()
  end

  define_singleton_method(:find_by_title) do |title|
    returned_books = DB.exec("SELECT * FROM books WHERE title = '#{title}';")
    books = []
    returned_books.each do |book|
      book_id = book['book_id'].to_i
      title = book['title']
      author = book['author']
      year_published = book['year_published']
      books.push(Book.new({:book_id => book_id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_singleton_method(:find_by_author) do |author|
    returned_books = DB.exec("SELECT * FROM books WHERE author = '#{author}';")
    books = []
    returned_books.each do |book|
      book_id = book['book_id'].to_i
      title = book['title']
      author = book['author']
      year_published = book['year_published']
      books.push(Book.new({:book_id => book_id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_singleton_method(:find_by_book_id) do |book_id|
    returned_book = DB.exec("SELECT * FROM books WHERE book_id =#{book_id};").first()
    book_id = returned_book['book_id'].to_i
    title = returned_book['title']
    author = returned_book['author']
    year_published = returned_book['year_published']
    Book.new({:book_id => book_id, :title => title, :author => author, :year_published => year_published})
  end

  define_method(:update) do |attributes|
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @year_published = attributes.fetch(:year_published)
    @book_id = self.book_id()
    DB.exec("UPDATE books SET author = '#{@author}' WHERE book_id = #{@book_id};")
    DB.exec("UPDATE books SET title = '#{@title}' WHERE book_id = #{@book_id};")
    DB.exec("UPDATE books SET year_published = #{@year_published} WHERE book_id = #{@book_id};")
  end
 end
