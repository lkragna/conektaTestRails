require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :tans_id => "Tans",
        :name => "Name",
        :credit_card => "Credit Card",
        :bin => "Bin",
        :currency => "Currency",
        :amount => "Amount",
        :card_schema => "Card Schema",
        :card_brand => "Card Brand",
        :exp_date => "Exp Date"
      ),
      Transaction.create!(
        :tans_id => "Tans",
        :name => "Name",
        :credit_card => "Credit Card",
        :bin => "Bin",
        :currency => "Currency",
        :amount => "Amount",
        :card_schema => "Card Schema",
        :card_brand => "Card Brand",
        :exp_date => "Exp Date"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => "Tans".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Credit Card".to_s, :count => 2
    assert_select "tr>td", :text => "Bin".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => "Amount".to_s, :count => 2
    assert_select "tr>td", :text => "Card Schema".to_s, :count => 2
    assert_select "tr>td", :text => "Card Brand".to_s, :count => 2
    assert_select "tr>td", :text => "Exp Date".to_s, :count => 2
  end
end
