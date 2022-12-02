class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_counter
  
  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_post_counter
    author.update(post_counter: author.posts.count)
  end

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
