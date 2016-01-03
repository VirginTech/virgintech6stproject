module ApplicationHelper
  
  def category_list
    @list={
          "カテゴリー　１" => 1,
          "カテゴリー　２" => 2,
          "カテゴリー　３" => 3,
          "カテゴリー　４" => 4,
          "カテゴリー　５" => 5,
          "カテゴリー　６" => 6,
          "カテゴリー　７" => 7,
          "カテゴリー　８" => 8,
          "カテゴリー　９" => 9,
          "カテゴリー１０" => 10
    }
  end

  def price_list
    @list={
          "無 料" => 1,
          "有 料" => 2,
    }
  end
  
end
