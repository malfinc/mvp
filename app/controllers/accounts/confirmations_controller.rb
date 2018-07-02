class Accounts::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation?confirmation_token=abcdef
  def edit
    self.resource = resource_class.find_first_by_auth_conditions(:confirmation_token => params.fetch(:id))
  end

  # PUT /resource/confirmation/:id
  def update
    Account.transaction do
      self.resource = resource_class.confirm_by_token(params.fetch(:id))

      resource.update!(:name => params.fetch(:account).fetch(:name), :password => params.fetch(:account).fetch(:password))

      resource.complete!
    end

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) {redirect_to after_confirmation_path_for(resource_name, resource)}
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity) {render :new}
    end
  end
end
