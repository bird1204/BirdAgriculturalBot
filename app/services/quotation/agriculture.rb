module Quotation::Agriculture
  module_function

  ALIAS = {
    '高麗菜' => '甘藍',
    'A菜' => '萵苣',
    '大陸妹' => '萵苣',
    '地瓜' => '甘藷',
    '地瓜葉' => '甘藷葉',
    '青江菜' => '青江白菜'
  }

  def find_by(location, product)
    product = ALIAS[product] || product.remove('菜')
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