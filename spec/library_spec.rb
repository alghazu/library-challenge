require './lib/library.rb'

describe Library do

expected_date = Date.today.next_day(30).strftime('%Y-%m-%d')
list_of_books = YAML.load_file('./lib/data.yml')

it 'displays the list of books' do
    expect(subject.books).to eq list_of_books
end

it 'gives success message if a book is available' do
  expected_output = 'Alfons och soldatpappan checked out successfully, please return on ' + expected_date
  expect(subject.checkout(1, 'Michael')).to eq expected_output
end

it 'sets the return date 30 days from today' do
subject.checkout(1,'Michael')
expect(subject.books[0][:return_date]).to eq expected_date
end

it 'gives an error message if book is not available' do
  expect(subject.checkout(2, 'Stefan')).to eq 'Book not available'
end

it 'shows the list of available books' do
  expect(subject.books_available.size).to eq 4
end

it 'shows return date of unavailable book' do
  expect(subject.return_date(2)).to eq '2016-05-25'
end

it 'set book availability to true, return date and name to nil when returned back' do
  subject.return(2)
  expect(subject.book[1][:available]).to eq true
  expect(subject.book[1][:person]).to eq nil
  expect(subject.book[1][:return_date]).to eq nil
end

end
