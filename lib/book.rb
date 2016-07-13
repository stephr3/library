require('pry')

class Book
  attr_reader(:title, :author_first, :author_last, :year_published)

  define_method(:initialize) do |attributes|
    @title = attributes[:title]
    @author_first = attributes[:author_first]
    @author_last = attributes[:author_last]
    @year_published = attributes[:year_published]
  end
end
