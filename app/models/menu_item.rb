class MenuItem < ApplicationRecord
  belongs_to :menu

  def tods
    "#{name} desc: #{description}"
  end
end
