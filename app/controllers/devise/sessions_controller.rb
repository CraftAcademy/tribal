class Devise::SessionsController < DeviseController
    prepend_before_action :require_no_authentication, only: [:new, :create]
    prepend_before_action :allow_params_authentication!, only: :create
    prepend_before_action :verify_signed_out_user, only: :destroy
    prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }
  
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end
  
    def create
      if warden.authenticate
        self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        render json: {errors: "Invalid Email or password."}
      end
    end
  
    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message! :notice, :signed_out if signed_out
      yield if block_given?
      # respond_to_on_destroy
    end
  
    protected
  
    def sign_in_params
        params.permit(:email,:password)
    end
  
    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :password if resource.respond_to?(:password)
      { methods: methods, only: [:password] }
    end
  
    def auth_options
      { scope: resource_name, :recall => '/register' }
    end
  
    def translation_scope
      'devise.sessions'
    end
  
    private
  
    def verify_signed_out_user
      if all_signed_out?
        set_flash_message! :notice, :already_signed_out
        respond_to_on_destroy
      end
    end
  
    def all_signed_out?
      users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }
      users.all?(&:blank?)
    end
  
    def respond_to_on_destroy
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
      end
    end
  end