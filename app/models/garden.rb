class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :banner_url, presence: true
  URL_REGEXP = %r{\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,9}(:[0-9]{1,5})?(\/.*)?\z}ix
  validates :banner_url, format: { with: URL_REGEXP, message: 'format invalid' }
end
