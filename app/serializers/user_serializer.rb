class UserSerializer < ActiveModel::Serializer
  attributes(*User.attribute_names.map(&:to_sym))

  has_many :notes, serializer: NoteSerializer


end
