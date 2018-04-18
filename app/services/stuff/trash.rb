module Stuff::Trash
  module_function

  DICTIONARY = %w(喔～ 恩恩恩！ 好啊 你剛剛說？ 可是... 說什麼幹話 盡說有的沒的 啊不然你唱歌啊 我真的很孤單 現在是跟我聊天？ 你想清楚了嗎！ 好啦 不然怎麼辦... 我在墾丁肚子餓 在說什麼啦QQ 我哭哭喔)

  def blahblahblah!
    DICTIONARY[rand(0..DICTIONARY.size-1)]
  end
end