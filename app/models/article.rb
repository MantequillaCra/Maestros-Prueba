class Article < ApplicationRecord
  has_many :comments
  has_many :users, through: :comments
  belongs_to :user

  def self.buscador(termino)
    Article.where("title LIKE ?", "%#{termino}%")
  end
end
