class Task < ActiveRecord::Base
    validates :content, uniqueness: {message: "¡Tarea ya en proyecto!"}
    validates :content, presence: {message: "¡No se puede guardar una tarea en blanco!"}

    belongs_to :user
    belongs_to :project
end
