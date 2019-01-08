class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: {minimum: 5, maximum: 50}
  validates :category_id, presence: true
  validates :user_id, presence: true

  def self.search_by_title(title)
    where("lower(title) LIKE ?", "%#{title.downcase}%").limit(20)
  end

end
