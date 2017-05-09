class Treasurer < ApplicationRecord
  belongs_to :user
    def for_js
    {date: date, price: price, comment: comment, category: category, datetime: created_at.strftime(' %I:%M %p')}
  end
end
