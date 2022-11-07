class CatFact < ApplicationRecord
    validates :fact, uniqueness: true
end