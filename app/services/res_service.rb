class ResService
  attr_reader :reply_token

  def initialize(params)
    @params = params
    @reply_token = params['events'][0]['replyToken']

    @message_type = params['events'][0]["message"]["type"].downcase
    @message_text = params['events'][0]["message"]["text"].downcase
  end

  def response!
    if trigger_response?
      key_words = @message_text.remove('bird').strip.split(' ')
      if key_words.present?
        return response_message(response_by_key_word(key_words))
      end
    end
    nil
  end

  private

  def trigger_response?
    @message_type == "text" && @message_text.start_with?("bird")
  end

  def response_message(message)
    {
      type: "text",
      text: message
    }
  end

  def response_by_key_word(key_words)
    if key_words.size == 2
      ResMessage.find_by(key_words[0], key_words[1])
    else
      case key_words[0]
      when 'help'
        return ResMessage.help
      when 'whoami'
        return ResMessage.whoami
      else
        return ResMessage.error
      end
    end

  end
end