module ApplicationHelper
  def yen(n)
    "￥#{number_with_delimiter(n)}"
  end
end
