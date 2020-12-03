class UserSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:id] = object.id
    data[:email] = object.email
    data[:token] = self.instance_options[:serializer_options][:token]
    data
  end
end
