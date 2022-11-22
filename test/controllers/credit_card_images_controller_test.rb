require "test_helper"

class CreditCardImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get credit_card_images_create_url
    assert_response :success
  end

  test "should get show" do
    get credit_card_images_show_url
    assert_response :success
  end

  test "should get new" do
    get credit_card_images_new_url
    assert_response :success
  end

  test "should get index" do
    get credit_card_images_index_url
    assert_response :success
  end
end
