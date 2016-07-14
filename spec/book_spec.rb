require('spec_helper')

describe(Book) do

  describe('#title') do
    it "returns the title of the book" do
      test_book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      expect(test_book.title()).to(eq('19Q4'))
    end
  end

  describe('#id') do
    it "returns the id of the book" do
      test_book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book.save()
      expect(test_book.id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an empty array at first' do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it 'compares two books by title and id to see if they are the same' do
      test_book1 = Book.new({:id => 1, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:id => 1, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book1.eql?(test_book2)
    end
  end

  describe('#save') do
    it 'saves a book' do
      test_book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('.find_by_title') do
    it 'locates books with a given title' do
      test_book1 = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_title(test_book1.title())).to(eq([test_book1]))
    end
  end

  describe('.find_by_author') do
    it 'locates books with a given author' do
      test_book1 = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_author(test_book1.author())).to(eq([test_book1]))
    end
  end

  describe('.find_by_id') do
    it 'locates a book with a given id' do
      test_book1 = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      expect(Book.find_by_id(test_book1.id())).to(eq(test_book1))
    end
  end

  describe('#update') do
    it 'lets the user update some of the attributes of the book' do
      test_book1 = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book1.save()
      test_book1.update({:author => 'Jo Bob'})
      expect(test_book1.author()).to(eq('Jo Bob'))
      expect(test_book1.title()).to(eq('19Q4'))
    end

    it("lets you add patrons to a book") do
        book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
        book.save()
        patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
        patron.save()
        book.update({:patron_ids => [patron.id()]})
        expect(book.patrons()).to(eq([patron]))
      end
  end

  describe("#patrons") do
    it("returns all of the patrons for a book") do
      book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      book.save()
      patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      patron.save()
      book.update({:patron_ids => [patron.id()]})
      expect(book.patrons()).to(eq([patron]))
    end
  end

  describe('#delete') do
    it 'lets the user delete a book' do
      test_book1 = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      test_book2 = Book.new({:id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
      test_book1.save()
      test_book2.save()
      test_book1.delete()
      expect(Book.all()).to(eq([test_book2]))
    end
  end
end
