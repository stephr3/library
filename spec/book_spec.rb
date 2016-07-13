require('spec_helper')

describe(Book) do

  describe('#title') do
    it "returns the title of the book" do
      test_book = Book.new({:title => '19Q4', :author_first => 'Haruki', :author_last => 'Murakami', :year_published => '2009'})
      expect(test_book.title()).to(eq('19Q4'))
    end
  end

  describe('.all') do
    it 'is an empty array at first' do
      expect(Book.all()).to(eq([]))
    end
  end

end
