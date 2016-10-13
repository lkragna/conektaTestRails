require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      :tans_id => "MyString",
      :name => "MyString",
      :credit_card => "MyString",
      :bin => "MyString",
      :currency => "MyString",
      :amount => "MyString",
      :card_schema => "MyString",
      :card_brand => "MyString",
      :exp_date => "MyString"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input#transaction_tans_id[name=?]", "transaction[tans_id]"

      assert_select "input#transaction_name[name=?]", "transaction[name]"

      assert_select "input#transaction_credit_card[name=?]", "transaction[credit_card]"

      assert_select "input#transaction_bin[name=?]", "transaction[bin]"

      assert_select "input#transaction_currency[name=?]", "transaction[currency]"

      assert_select "input#transaction_amount[name=?]", "transaction[amount]"

      assert_select "input#transaction_card_schema[name=?]", "transaction[card_schema]"

      assert_select "input#transaction_card_brand[name=?]", "transaction[card_brand]"

      assert_select "input#transaction_exp_date[name=?]", "transaction[exp_date]"
    end
  end
end
