class SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    # current_user.update authentication_token: nil

    respond_to do |format|
      format.html { redirect_to "/chats"}
      format.json {
        render :json => {
               :user => { id: current_user.id,
               name: current_user.username,
               messages_count: current_user.messages.count,
               token: current_user.authentication_token  
                                                                } } }
    end
  end

  # # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end
end
