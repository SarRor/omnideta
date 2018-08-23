class Usuarios::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/usuario.rb)
    # auth = request.env["omniauth.auth"]
    # raise auth.to_yaml
    @usuario = Usuario.from_omniauth(request.env["omniauth.auth"])
    if @usuario.persisted?
      sign_in_and_redirect @usuario, event: :authentication #this will throw if @usuario is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_usuario_registration_url
    end
  end
  def failure
    redirect_to root_path
  end
end