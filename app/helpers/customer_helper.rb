module CustomerHelper
  def type_payment type
    case type
      when 1
        :prepay
      when 2
        :postpay
    end
  end

  def status_payment status
    case status
      when 0
        :Processing
      when 1
        :Success
      when 2
        :Failed
    end
  end
end
