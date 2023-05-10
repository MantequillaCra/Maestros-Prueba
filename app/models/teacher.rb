class Teacher < ApplicationRecord
  has_many :teacher_comments
  has_many :users, through: :teacher_comments
  belongs_to :user

  def self.buscador(termino)
    Teacher.where("title LIKE ?", "%#{termino}%")
  end
end
