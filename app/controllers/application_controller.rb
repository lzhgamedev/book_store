class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.is_a?(Manager)
      admin_books_path
    else
      if session[:cart_entry]
        create_and_carts_path
      else
        categories_path
      end
    end
  end

end
