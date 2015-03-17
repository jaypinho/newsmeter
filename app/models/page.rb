class Page < ActiveRecord::Base
  belongs_to :site
  has_many :keywords, through: :page_keywords
end
