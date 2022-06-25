class Book < ApplicationRecord
    validates :title, presence: true, allow_blank: false
    validates :isbn13, presence: true, allow_blank: false
 
    validate :valid_isbn13?

    def self.calculate_isbn13_check_digit(partial_isbn)
        partial_isbn = partial_isbn.to_s
        sum = 0
        partial_isbn.each_char.with_index do |digit, i|
            sum += i.even? ? digit.to_i : digit.to_i * 3
        end

        return (10 - sum) % 10
    end

    # validation guidlines are based here https://www.isbn-international.org/content/what-isbn
    def valid_isbn13?
        digits = self.isbn13.scan(/\d/).join
        
        self.errors.add(:isbn13, 'has invalid character') if self.isbn13.match?(/[^\d\-]/) 
        self.errors.add(:isbn13, 'has invalid check digit') unless self.class.calculate_isbn13_check_digit(digits[0..-2]) == digits[-1].to_i
        
        return false if self.errors.present?
        
        return true
    end

end
 