require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :tans_id => "Tans",
      :name => "Name",
      :credit_card => "Credit Card",
      :bin => "Bin",
      :currency => "Currency",
      :amount => "Amount",
      :card_schema => "Card Schema",
      :card_brand => "Card Brand",
      :exp_date => "Exp Date"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Tans/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Credit Card/)
    expect(rendered).to match(/Bin/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/Amount/)
    expect(rendered).to match(/Card Schema/)
    expect(rendered).to match(/Card Brand/)
    expect(rendered).to match(/Exp Date/)
  end
end
