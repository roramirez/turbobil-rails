require 'rubygems'
require 'yaml'
require 'authorizenet'
require 'securerandom'

class AuthorizedService

  def execute(payment)

    gw = payment.gateway
    transaction = AuthorizeNet::API::Transaction.new('5vLNyK2Zy43H', '63Lr2e2yAw8VC5E7', :gateway => :sandbox)

    request = AuthorizeNet::API::CreateTransactionRequest.new

    request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
    request.transactionRequest.amount = ((SecureRandom.random_number + 1 ) * 150 ).round(2)
    request.transactionRequest.payment = AuthorizeNet::API::PaymentType.new
    request.transactionRequest.payment.creditCard = AuthorizeNet::API::CreditCardType.new('4242424242424242','0220','123')
    request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction

    response = transaction.create_transaction(request)

    if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
      puts "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
    else
      puts response.messages.messages[0].text
      puts response.transactionResponse.errors.errors[0].errorCode
      puts response.transactionResponse.errors.errors[0].errorText
      raise "Failed to charge card."
    end

    return response
  end
end
