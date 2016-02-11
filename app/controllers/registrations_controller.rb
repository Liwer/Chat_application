class RegistrationsController < Devise::RegistrationsController

  respond_to :html, :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    respond_to do |format|
      if resource.persisted?
        if resource.active_for_authentication?
          format.html {
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, location: root_path }
            format.json { render :json => { user: { :id => @user.id, :name => @user.username, :messages_count => @user.messages.count } } }
        else
          format.html {
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource) }
            format.json { render :json => { code: "500", message: "#{resourse.inactive_message}" }}
        end
      else
        format.html {
          clean_up_passwords resource
          set_minimum_password_length
          respond_with resource }
          format.json { render json: { code: "500", message: "Username already exist" } }
      end

    end
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

end

