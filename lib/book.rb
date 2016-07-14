require('pry')

class Book
  attr_reader(:id, :title, :author, :year_published)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @title = attributes[:title]
    @author = attributes[:author]
    @year_published = attributes[:year_published]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      id = book.fetch("id").to_i()
      title = book.fetch("title")
      author = book.fetch("author")
      year_published = book.fetch("year_published")
      books.push(Book.new({:id => id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_method(:==) do |other|
    self.title.==(other.title).&(self.id.==(other.id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author, year_published) VALUES ('#{@title}', '#{@author}', #{@year_published}) RETURNING id;")
    @id = result.first['id'].to_i()
  end

  define_singleton_method(:find_by_title) do |title|
    returned_books = DB.exec("SELECT * FROM books WHERE title = '#{title}';")
    books = []
    returned_books.each do |book|
      id = book['id'].to_i
      title = book['title']
      author = book['author']
      year_published = book['year_published']
      books.push(Book.new({:id => id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_singleton_method(:find_by_author) do |author|
    returned_books = DB.exec("SELECT * FROM books WHERE author = '#{author}';")
    books = []
    returned_books.each do |book|
      id = book['id'].to_i
      title = book['title']
      author = book['author']
      year_published = book['year_published']
      books.push(Book.new({:id => id, :title => title, :author => author, :year_published => year_published}))
    end
    books
  end

  define_singleton_method(:find_by_id) do |id|
    returned_book = DB.exec("SELECT * FROM books WHERE id =#{id};").first()
    id = returned_book['id'].to_i
    title = returned_book['title']
    author = returned_book['author']
    year_published = returned_book['year_published']
    Book.new({:id => id, :title => title, :author => author, :year_published => year_published})
  end

  define_method(:update) do |attributes|
    @author = attributes.fetch(:author, @author)
    @title = attributes.fetch(:title, @title)
    @year_published = attributes.fetch(:year_published, @year_published)
    @id = self.id()
    DB.exec("UPDATE books SET author = '#{@author}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET year_published = #{@year_published} WHERE id = #{@id};")

    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{patron_id}, #{self.id()});")
    end
  end

  define_method(:patrons) do
    book_patrons = []
    results = DB.exec("SELECT patron_id FROM checkouts WHERE book_id = #{self.id()};")
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      phone = patron.first().fetch("phone")
      book_patrons.push(Patron.new({:name => name, :phone => phone, :id => patron_id}))
    end
    book_patrons
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE movie_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end
 end
