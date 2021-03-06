class Account < ActiveRecord::Base
  self.table_name = 'account'

  validates_uniqueness_of :code
  validates_presence_of :code
  validates :codecs, :presence => { :message => "Select a codec" }

  has_many :account_codecs
  has_many :codecs, :through => :account_codecs

  belongs_to :customer
  belongs_to :admin

end
