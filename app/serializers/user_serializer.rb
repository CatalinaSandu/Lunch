class UserSerializer < ActiveModel::Serializer
  attributes :email, :password, :name
end
