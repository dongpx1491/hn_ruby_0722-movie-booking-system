class MovieSerializer < ActiveModel::Serializer
  belongs_to :genre
  attributes :id, :title, :description, :release_date, :duration,
             :thumbnail, :cast, :status
end
