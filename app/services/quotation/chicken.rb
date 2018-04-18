module Quotation::Chicken
  module_function

  URLS = [
    'http://data.coa.gov.tw/Service/OpenData/FromM/PoultryTransBoiledChickenData.aspx',
    'http://data.coa.gov.tw/Service/OpenData/FromM/PoultryTransLocalBlackChickenData.aspx', #黑羽土雞
    'http://data.coa.gov.tw/Service/OpenData/FromM/PoultryTransLocalRedChickenData.aspx', #紅羽土雞
  ]

  def find_all
    return_messages = ["今日(#{Time.zone.now.strftime('%F')})報價："]
    five_days_ago = (Time.zone.now - 5.days).strftime('%Y/%m/%d')
    URLS.each do |url|
      url = URI.encode("#{url}?StartDate=#{five_days_ago}")
      res = Net::HTTP.get_response(URI.parse(url))

      if JSON.parse(res.body).present?
        return_messages += JSON.parse(res.body)[0].map do |key ,value|
          next if ['日期', '農曆'].include?(key)
          "#{key}：#{value}"
        end.compact.uniq
      end
    end

    return return_messages.join("\n") if return_messages.size > 1
    return "沒有找到最近的資料"
  end
end