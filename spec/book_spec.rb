require('spec_helper')

describe(Book) do

  describe('#title') do
    it "returns the title of the book" do
      test_book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      expect(test_book.title()).to(eq('19Q4'))
    end
  end

  describe('#book_id') do
    it "returns the id of the book" do
      test_book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
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
      test_book1 = Book.new({:book_id => 1, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:book_id => 1, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book1.eql?(test_book2)
    end
  end

  describe('#save') do
    it 'saves a book' do
      test_book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.find_by_title') do
    it 'locates books with a given title' do
      test_book1 = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:book_id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_title(test_book1.title())).to(eq([test_book1]))
    end
  end

  describe('.find_by_author') do
    it 'locates books with a given author' do
      test_book1 = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:book_id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_author(test_book1.author())).to(eq([test_book1]))
    end
  end

  describe('.find_by_book_id') do
    it 'locates a book with a given book_id' do
      test_book1 = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:book_id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_book_id(test_book1.book_id())).to(eq(test_book1))
    end
  end

  describe('#update_author') do
    it 'lets the user update the author' do
      test_book1 = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book1.save()
      test_book1.update_author({:author => 'Jo Bob'})
      expect(test_book1.author()).to(eq('Jo Bob'))
    end
  end
end
