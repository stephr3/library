require('spec_helper.rb')
require('capybara/rspec')
require('./app')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'librarian path', {:type => :feature} do
  it "gets to the librarian page" do
    visit '/'
    click_link "I'm a librarian!"
    expect(page).to have_content("Librarian's Nifty Nook")
  end

  it "allows the librarian to add a book" do
    visit '/librarian'
    click_link 'View Books'
    click_link 'Add a Book'
    fill_in('title', :with => '19Q4')
    fill_in('author', :with => 'Haruki Murakami')
    fill_in('year_published', :with => '2009')
    click_button('Add Book')
    expect(page).to have_content("Library Catalog")
  end

  it "allows the librarian to view a list of books in the catalog" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian/books'
    expect(page).to have_content("19Q4 by Haruki Murakami")
  end
end
