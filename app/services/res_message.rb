module ResMessage
  module_function

  ALIAS = {
    '高麗菜' => '甘藍',
    'A菜' => '萵苣',
    '大陸妹' => '萵苣',
    '地瓜' => '甘藷',
    '地瓜葉' => '甘藷葉'
  }

  def help
    "[INFO]\n搜尋菜價: bird [地點] [菜名]\n找台北的高麗菜，請輸入bird 台北 高麗菜\n找幫助: bird help\n找作者: bird whoami"
  end

  def error
    "我還不了解這件事的處理方式QQ\n\n" << help << "\n" << whoami
  end

  def whoami
    "你可以在linkedin上找到我:\nhttps://www.linkedin.com/in/wei-yi-chiu-85b048104/"
  end

  def find_by(location, product)
    product = ALIAS[product] || product
    url = URI.encode("https://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx?Crop=#{product}&Market=#{location}")
    res = Net::HTTP.get_response(URI.parse(url))

    if JSON.parse(res.body).present?
      return "今日(#{Time.zone.now.strftime('%F')})報價：\n" << JSON.parse(res.body).map do |product|
        "#{product['作物名稱']}: 每公斤#{product['平均價']}元"
      end.join("\n")
    end

    return "沒有找到今天的資料"
  end
end