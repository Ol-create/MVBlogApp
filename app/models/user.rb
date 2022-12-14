class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, dependent: :destroy, foreign_key: 'author_id'
  has_many :comments, dependent: :destroy, foreign_key: 'author_id'
  has_many :likes, dependent: :destroy, foreign_key: 'author_id'

  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :default_values

  def last_3_posts
    posts.order(created_at: :desc).limit(3)
  end

  def admin?
    :role == 'admin'
  end

  private

  def default_values
    self.post_counter ||= 0
    self.photo ||= 'https://i.stack.imgur.com/YQu5k.png'
  end
end
