# Override/monkeypatch Devise's RegistrationsController. This is done
# because we need to add some extra fields to the user model and Rails
# 4 strong parameters are handled in the controller, not the
# model. Note that the PROPER way to do this is to write our own
# sanitizer and register it with Devise. However:
#
# 1. I am on a plane right now and I can't find a good reference for
# creating my own sanitizer
# 2. I am on a plane right now and I *CAN* find a good reference for
# monkeypatching Devise's controller.
# 3. I am David Effing Brady and I say MONKEYPATCH ALL THE THINGS
class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
