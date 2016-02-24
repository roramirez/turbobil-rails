class Plan < ActiveRecord::Base
  belongs_to :admin
  has_many :payments

  def to_s
    name
  end

end
