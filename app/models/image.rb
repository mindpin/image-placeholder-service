class Image
  include Mongoid::Document
  field :url, type: String
  field :width, type: Integer
  field :height, type: Integer
  field :ratio, type: Float
end
