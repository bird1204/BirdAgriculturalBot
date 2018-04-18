module Quotation::Pig
  module_function

  def find_by(location)
    location = '新北市' if location.match('北') or location.match('基隆')
    return_messages = ["今日(#{Time.zone.now.strftime('%F')})報價："]
    url = URI.encode("http://data.coa.gov.tw/Service/OpenData/FromM/AnimalTransData.aspx?MarketName=#{location}")
    res = Net::HTTP.get_response(URI.parse(url))

    if JSON.parse(res.body).present?
      return_messages += JSON.parse(res.body)[0].map do |key ,value|
        next if ['交易日期', '市場名稱'].include?(key)
        "#{key}：#{value}"
      end.compact.uniq
    end

    return return_messages.join("\n") if return_messages.size > 1
    return "沒有找到最近的資料"
  end
end