require "application_system_test_case"

class CreditCardsTest < ApplicationSystemTestCase
  setup do
    @credit_card = credit_cards(:one)
  end

  test "visiting the index" do
    visit credit_cards_url
    assert_selector "h1", text: "Credit cards"
  end

  test "should create credit card" do
    visit credit_cards_url
    click_on "New credit card"

    fill_in "Name", with: @credit_card.name
    click_on "Create Credit card"

    assert_text "Credit card was successfully created"
    click_on "Back"
  end

  test "should update Credit card" do
    visit credit_card_url(@credit_card)
    click_on "Edit this credit card", match: :first

    fill_in "Name", with: @credit_card.name
    click_on "Update Credit card"

    assert_text "Credit card was successfully updated"
    click_on "Back"
  end

  test "should destroy Credit card" do
    visit credit_card_url(@credit_card)
    click_on "Destroy this credit card", match: :first

    assert_text "Credit card was successfully destroyed"
  end
end
