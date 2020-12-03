class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user
end
