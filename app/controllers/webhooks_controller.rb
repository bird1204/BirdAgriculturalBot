require 'line/bot'
class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render plain: 'THIS IS FOR bird-line-argicultural-bot', status: 200
  end
  def create
    # Line Bot API 物件初始化
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['line_channel_secret']
      config.channel_token = ENV['line_channel_token']
    }

    service = ResService.new(params)
    reply_token = service.reply_token
    response_message = service.response!

    client.reply_message(reply_token, response_message) if response_message.present?
    head :ok
  end
end