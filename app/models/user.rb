class User < ActiveRecord::Base
    has_secure_password
    validates :username, uniqueness: {message: "¡Nombre de usuario ya en uso!"}
    validates :email, uniqueness: {message: "¡Correo electrónico ya en uso!"}
    validates :password, length: {minimum: 5, message: "¡La contraseña debe tener más de 5 caracteres!"}

    has_many :projects, dependent: :destroy 
    has_many :tasks, through: :projects
end
