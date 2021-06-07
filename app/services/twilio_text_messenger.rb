require 'twilio-ruby'
class TwilioTextMessenger
  # attr_reader :message

  def initialize(message)
      @message = message
  end

  def call
    @message = params[:message]
    account_sid = 'AC4f46a84a6e9e247e4dc86bed72556d3a'
    auth_token = 'c2b984934090e16b4fd1238bb4bae718'
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+17653357040' # Your Twilio number
    to = '+918903078020' # Your mobile phone number

    client.messages.create(
    from: from,
    to: to,
    body: @message.status
    )
end
def msg
  account_sid = 'AC4f46a84a6e9e247e4dc86bed72556d3a'
  auth_token = 'c2b984934090e16b4fd1238bb4bae718'
  client = Twilio::REST::Client.new(account_sid, auth_token)

  messagess=client.messages('SM9ef97cd9d5c24eab8cd49214e979370c').fetch

  return  messagess.body
end
end