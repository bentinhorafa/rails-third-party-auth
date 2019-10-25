class UserAuthenticationService::RequestFacebook < UserAuthenticationService::RequestBase
  attr_reader :request_auth, :request_strategy

  def initialize(raw_request)
    @request_auth     = raw_request.env["omniauth.auth"]
    @request_strategy = raw_request.env['omniauth.strategy']
  end

  def provider
    'facebook'
  end

  def uid
    @uid ||= request_auth.uid
  end

  def user_name
    @user_name ||= request_auth.info.name
  end

  def user_gender; end

  def user_email
    @user_email ||= request_auth.info.email
  end

  def raw_image_url
    @raw_image_url ||= request_auth.info.image
  end

  def user_image_url
    "#{raw_image_url}?type=large" if raw_image_url.present?
  end

  def user_locale
    @user_locale ||= :en
  end

  def credentials_token
    @credentials_token ||= request_auth.credentials.token
  end

  def credentials_expiration
    @credentials_expiration ||= Time.at(request_auth.credentials.expires_at)
  end

  def request_validation_token
    @request_validation_token ||= request_strategy.options.client_id
  end
end
