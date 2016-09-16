require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  # test "the truth" do
  #   assert true
  # end
  test "should not save order without status" do
    order = Order.new
    assert order.save
  end

  test "get all orders " do
    all_orders = Order.all

    assert_equal 2, all_orders.length
    assert_equal 'Trimis', orders(:one).order_status

  end

  test "gets order by id" do
    order = Order.find_by_id(orders(:one).id)

    assert_not_nil order

  end

  test "update order" do
    order = orders(:two)
    order.order_status = 'Trimisa'
    order.save

    update_order = Order.find_by_id(orders(:two).id)
    assert_equal 'Trimisa' , update_order.order_status
  end

  test "delete order" do
    orders = Order.all

    assert_equal 2, orders.length

    orders(:one).destroy
    orders = Order.all

    assert_equal 1, orders.length

  end

end
