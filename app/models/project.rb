class Project < ActiveRecord::Base
    validates :title, uniqueness: {message: "El proyecto %{value} ya existe!"}
    validates :title, presence: {message: "¡El proyecto debe tener un título!"}
    validates :description, presence: {message: "¡El proyecto debe tener una descripción!"}

    belongs_to :user
    has_many :tasks, dependent: :destroy
end
