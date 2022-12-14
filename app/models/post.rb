class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :default_values

  after_save :update_post_counter

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def default_values
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_post_counter
    author.update(post_counter: author.posts.count)
  end
end