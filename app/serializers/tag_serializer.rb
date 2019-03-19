class TagSerializer < ActiveModel::Serializer
  attributes(*Tag.attribute_names.map(&:to_sym))


end
