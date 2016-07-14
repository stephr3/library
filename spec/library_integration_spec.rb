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
    click_link 'View All Books in Catalog'
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

  it "allows the librarian to view a book" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian/books'
    click_link '19Q4 by Haruki Murakami'
    expect(page).to have_content("Title: 19Q4")
  end

  it "allows the librarian to update a book" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian/books'
    click_link '19Q4 by Haruki Murakami'
    click_link 'Edit'
    fill_in 'year_published', :with => '2011'
    click_button 'Submit'
    expect(page).to have_content("2011")
    expect(page).to have_content("19Q4")
  end

  it "allows the librarian to delete a book" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian/books'
    click_link '19Q4 by Haruki Murakami'
    click_link 'Edit'
    click_button 'Delete Book'
    expect(page).to have_no_content("19Q4")
  end

  it "allows the librarian to search for a book by title" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian'
    click_link 'Search Books by Title'
    fill_in 'title_search', :with => '19Q4'
    click_button 'Search for this Title'
    expect(page).to have_content('19Q4')
  end

  it "allows the librarian to search for a book by author" do
    book = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    visit '/librarian'
    click_link 'Search Books by Author'
    fill_in 'author_search', :with => 'Haruki Murakami'
    click_button 'Search for this Author'
    expect(page).to have_content('19Q4')
  end

  it "allows the librarian to search for multiple books by one author" do
    book1 = Book.new({:book_id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book1.save()
    book2 = Book.new({:book_id => nil, :title => 'Sputnik Sweetheart',:author => 'Haruki Murakami', :year_published => '1999'})
    book2.save()
    visit '/librarian'
    click_link 'Search Books by Author'
    fill_in 'author_search', :with => 'Haruki Murakami'
    click_button 'Search for this Author'
    expect(page).to have_content('Sputnik Sweetheart')
  end

  it "returns some text if a search returns no results" do
    visit '/librarian'
    click_link 'Search Books by Author'
    fill_in 'author_search', :with => 'Haruki Murakami'
    click_button 'Search for this Author'
    expect(page).to have_content('Sorry')
  end

# Patrons-LIBRARIAN

it "allows the librarian to add a patron" do
  visit '/librarian'
  click_link 'View All Patrons'
  click_link 'Add a Patron'
  fill_in('name', :with => 'Mr. Rogers')
  fill_in('phone', :with => '503-250-2173')
  click_button('Add Account')
  expect(page).to have_content("Patrons")
end


it "allows the librarian to view a list of patrons" do
  patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
  patron.save()
  visit '/librarian/patrons'
  expect(page).to have_content("Mr. Rogers")
end

  it "allows the librarian to view a patron" do
    patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
    patron.save()
    visit '/librarian/patrons'
    click_link 'Mr. Rogers'
    expect(page).to have_content("Phone: 503-250-2173")
  end

  it "allows the librarian to update a patron" do
    patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
    patron.save()
    visit '/librarian/patrons'
    click_link 'Mr. Rogers'
    click_link 'Edit'
    fill_in 'phone', :with => '971-358-9742'
    click_button 'Submit'
    expect(page).to have_content("Mr. Rogers")
    expect(page).to have_content("971-358-9742")
  end

  it "allows the librarian to delete a patron" do
    patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
    patron.save()
    visit '/librarian/patrons'
    click_link 'Mr. Rogers'
    click_link 'Edit'
    click_button 'Delete Patron'
    expect(page).to have_no_content("Mr. Rogers")
  end
end

# PATRON PATRON PATH
describe 'patron path', {:type => :feature} do
  it "gets to the patron page" do
    visit '/'
    click_link "I'm a patron!"
    expect(page).to have_content("Create a New Account")
  end

  it "creates a new patron account" do
    visit '/patron'
    click_link "Create a New Account"
    fill_in "name", :with => "Mr. Rogers"
    fill_in "phone", :with => "503-250-2173"
    click_button "Submit"
    expect(page).to have_content("Mr. Rogers")
  end

  it "allows patron to view a list of patrons" do
    patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
    patron.save()
    visit '/patron/patrons'
    expect(page).to have_content("Mr. Rogers")
  end

end
