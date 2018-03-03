class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # true 將會關閉單一表格繼承STI(Single-table inheritance)，使個別的類別(class)有自己的資料表。
end
