require('spec_helper')

describe(Book) do

  describe('#title') do
    it "returns the title of the book" do
      test_book = Book.new({:book_id => nil, :title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      expect(test_book.title()).to(eq('19Q4'))
    end
  end

  describe('#book_id') do
    it "returns the id of the book" do
      test_book = Book.new({:book_id => nil, :title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      test_book.save()
      expect(test_book.book_id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an empty array at first' do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it 'compares two books by title and id to see if they are the same' do
      test_book1 = Book.new({:book_id => 1, :title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      test_book2 = Book.new({:book_id => 1, :title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      test_book1.eql?(test_book2)
    end
  end

  describe('#save') do
    it 'saves a book' do
      test_book = Book.new({:book_id => nil, :title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

end
