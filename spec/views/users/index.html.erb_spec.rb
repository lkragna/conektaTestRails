require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :user_id => 2,
        :secret_key => "Secret Key",
        :status => false
      ),
      User.create!(
        :name => "Name",
        :user_id => 2,
        :secret_key => "Secret Key",
        :status => false
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Secret Key".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
