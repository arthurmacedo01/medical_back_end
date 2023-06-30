class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :jti, :created_at
end
