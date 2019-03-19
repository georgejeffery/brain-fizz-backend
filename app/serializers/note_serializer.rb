class NoteSerializer < ActiveModel::Serializer
  attributes(*Note.attribute_names.map(&:to_sym))

  has_many :tags, serializer: TagSerializer


end
