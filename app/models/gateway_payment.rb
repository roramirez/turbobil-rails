class GatewayPayment < ActiveRecord::Base
  belongs_to :admin

  def to_s
    name
  end

end
