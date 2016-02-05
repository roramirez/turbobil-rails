class Account < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  self.table_name = 'account'

  validates_uniqueness_of :code
  validates_presence_of :code
  validates :codecs, :presence => { :message => "Select a codec" }

  has_many :account_codecs
  has_many :codecs, :through => :account_codecs

  belongs_to :customer
  belongs_to :admin

  def is_enabled
    if expire.nil?
      return false
    end

    if customer.active == false
      return false
    end
    if expire > (Time.now)
      return true
    else
      return false
    end
    true
  end
end
