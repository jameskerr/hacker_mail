require "test_helper"

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscriber = subscribers(:one)
  end

  test "should get new" do
    get new_subscriber_url
    assert_response :success
  end

  test "should create subscriber" do
    assert_difference("Subscriber.count") do
      post subscribers_url, params: { subscriber: { email: "kerr@me.com", threshold: 100 } }
    end

    assert_response :created
  end

  test "should create subscriber when confirmed" do
    Subscriber.create(email: "kerr@me.com", threshold: 300, confirmed: true)
    assert_no_difference("Subscriber.count") do
      post subscribers_url, params: { subscriber: { email: "kerr@me.com", threshold: 100 } }
    end

    assert_response :created
  end

  test "should get edit" do
    get edit_subscriber_url(@subscriber)
    assert_response :success
  end

  test "should confirm subscriber when visiting" do
    assert_equal false, @subscriber.confirmed
    get subscriber_url(@subscriber)
    assert_equal true, @subscriber.reload.confirmed
  end

  test "should update subscriber" do
    patch subscriber_url(@subscriber), params: { subscriber: { threshold: 100 } }
    assert_redirected_to @subscriber
  end

  test "should destroy subscriber" do
    assert_difference("Subscriber.count", -1) do
      delete subscriber_url(@subscriber)
    end

    assert_redirected_to new_subscriber_url
  end
end
