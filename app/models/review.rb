class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user
   validates  :content,:rating, presence: true
   validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
 after_save :update_rating
 private

  def update_rating
    service = self.service
    avg_rating = service.reviews.average(:rating).to_i
    service.update(avg_rating: avg_rating)
  end
end
