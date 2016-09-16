require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  fixtures :menus
  # test "the truth" do
  #   assert true
  # end
  test "should not save menu without title" do
    menu = Menu.new
    assert_not menu.save
  end

  test "should not save menu without a valid first_dish " do
    menu = Menu.new(title: 'food1',
      first_dish: 'dish',
      second_dish: 'second dish',
      dessert: 'dessert',
      date: '2016-09-12')

    assert_not menu.save
  end

  test "should not save menu without a valid date " do
    menu = Menu.new(title: 'food1',
      first_dish: 'first dish',
      second_dish: 'second dish',
      dessert: 'dessert',
      date: '2016-09-12')

    assert menu.save

  end

  test "gets all all_menus" do
    all_menus = Menu.all

    assert_equal 2, all_menus.length
    assert_equal 'Meniu simplu', menus(:two).title
    assert_equal 'Meniul zilei', menus(:one).title
  end

  test "gets menu by title" do
    menu = Menu.find_by_title('Meniu simplu')

    assert_not_nil menu

  end

  test "update menu " do
    menu = menus(:one)
    menu.dessert += ' update'
    menu.save

    update_menu = Menu.find_by_title('Meniul zilei')
    assert_equal 'clatite update' , update_menu.dessert

  end

  test "delete menu " do
    menus = Menu.all

    assert_equal 2, menus.length

    menus(:one).destroy
    menus = Menu.all
    assert_equal 1, menus.length

  end


end
