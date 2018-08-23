class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  mount_uploader :imagen, ImagenUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |usuario|
      usuario.email = auth.info.email
      usuario.password = Devise.friendly_token[0,20]
      usuario.nombre = auth.info.name   # assuming the user model has a name
      usuario.imagen = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # usuario.skip_confirmation!
    end
  end

end
