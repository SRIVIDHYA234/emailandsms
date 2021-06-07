require 'twilio-ruby'
class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_attributes)
    account_sid = 'AC4f46a84a6e9e247e4dc86bed72556d3a'
    auth_token = 'c2b984934090e16b4fd1238bb4bae718'
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+17653357040' # Your Twilio number
    to = '+918903078020' # Your mobile phone number

    @sid_data = client.messages.create(
    from: from,
    to: to,
    body: @message.body
    )
    if @message.save
      # TwilioTextMessenger.new(message: @message).call
     
      @message.status = @sid_data.sid
      MessageMailer.with(message: @message).email.deliver_now!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # account_sid = 'AC4f46a84a6e9e247e4dc86bed72556d3a'
    # auth_token = 'c2b984934090e16b4fd1238bb4bae718'
    # @client = Twilio::REST::Client.new(account_sid, auth_token)

    # messages = @client.messages.list(
    #                               date_sent: (Date.parse('2021-01-06')..Date.parse('2021-03-06')),
    #                               from: '+17653357040',
    #                               to: '+918903078020',
    #                               limit: 20
    #                             )

    # messages.each do |record|
    #   puts record.body
    #   @message = Message.find(params[:id])
      
    #   @message.status  = record.body

    # end
    @messagessss=TwilioTextMessenger.new(message: @message).msg
    @message = Message.find(params[:id])
    @message.status = @messagessss
  end

  private

  def message_attributes
    params.require(:message).permit(:to, :subject, :body)
  end
end
