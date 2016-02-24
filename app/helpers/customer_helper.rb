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
        :procesing
      when 1
        :done
      when 2
        :reject
    end
  end
end
