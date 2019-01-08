class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  def recent_posts
    posts.order(created_at: :desc).limit(10)
  end

end
