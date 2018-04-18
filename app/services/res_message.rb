module ResMessage
  module_function

  ALIAS = {
    '高麗菜' => '甘藍',
    'A菜' => '萵苣',
    '大陸妹' => '萵苣',
    '地瓜' => '甘藷',
    '地瓜葉' => '甘藷葉',
    '青江菜' => '青江白菜'
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

    return Quotation::Chicken.find_all if product.match('雞')
    return Quotation::Goose.find_all if product.match('鵝')
    return Quotation::Duck.find_all if product.match('鴨')
    return Quotation::Agriculture.find_by(location) if product.match('豬')
    # if product.match('牛')
    # if product.match('魚')
    return Quotation::Agriculture.find_by(location, product)
  end
end