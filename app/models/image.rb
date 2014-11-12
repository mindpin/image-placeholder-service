class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :width, type: Integer
  field :height, type: Integer
  field :ratio, type: Float
  attr_accessor :file

  before_create :calculate_ratio
  def calculate_ratio
    self.ratio = self.width.to_f / self.height.to_f
    self.ratio = (self.ratio * 100).round / 100.0
  end

  def self.random
    offset = rand(self.count)
    rand_record = self.offset(offset).first
  end
end
