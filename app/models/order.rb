class Order < ActiveRecord::Base
  belongs_to :menu
  belongs_to :user

  belongs_to :dish, foreign_key: 'dish1_id'
  belongs_to :dish, foreign_key: 'dish2_id'
  belongs_to :dish, foreign_key: 'dessert_id'

  def dish1
    @dish1 ||= Dish.find_by_id dish1_id
  end

  def dish2
    @dish2 ||= Dish.find_by_id dish2_id
  end

  def dessert
    @dessert ||= Dish.find_by_id dessert_id
  end


  def dish1_title
    safe_dish_title dish1
  end

  def dish2_title
    safe_dish_title dish2
  end

  def dessert_title
    safe_dish_title dessert
  end


  private

  def safe_dish_title(dish)
    return dish.dish_title if dish
    '---'
  end

end
