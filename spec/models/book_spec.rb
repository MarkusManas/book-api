require 'rails_helper'

RSpec.describe Book, type: :model do
    let!(:book) { create :book }

    describe "Validations" do
        it 'does not accept invalid isbn' do
            book.isbn13 = '12345'
            expect(book).to_not be_valid
        end

        it 'does not accept invalid characters in isbn' do
            book.isbn13 = 'asd1234-5-6-7-8'
            expect(book).to_not be_valid
        end

        it 'has working isbn validation' do
            book.isbn13 = '978-92-95055-02-5'
            expect(book).to be_valid
        end

        it 'is not valid with an empty title' do
            book.title = nil
            expect(book).to_not be_valid
        end

        it 'is not valid without a title' do
            book.title = nil
            expect(book).to_not be_valid
        end
    end

    describe "Class Methods" do
        it 'has working isbn check digit calculator' do
            check_digit = Book.calculate_isbn13_check_digit('978929505502')
            expect(check_digit).to eq(5)

            check_digit = Book.calculate_isbn13_check_digit('978014300723')
            expect(check_digit).to eq(4)

            check_digit = Book.calculate_isbn13_check_digit('417011597379')
            expect(check_digit).to eq(0)
        end
    end
end