class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
         return true
      else
         error.add(:base, 'Line Items present')
         return false
      end
    end


  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with       => %r{\.(gif|jpg|png)$}i,
    :message    => 'Must be a URL for GIF, JPG or PNG image.'
  }
end
