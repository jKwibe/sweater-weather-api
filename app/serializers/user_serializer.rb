class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email
  attribute :access_token do |user, params|
    params[:access_token]
  end
end
