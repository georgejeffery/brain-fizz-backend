class Note < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  require_relative './tone.rb'

  def self.tagged_with(name)
    Tag.find_by!(name: name).notes
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def get_tone
    toneresult = find_tone(self.content)
    majortone=""
    toneresult.each do |tone|
      if tone["score"] > 0.5
        majortone = tone["tone_id"]
      end
    end
    majortone
  end



end
