class Transaction
  include Mongoid::Document
  field :tans_id, type: String
  field :name, type: String
  field :credit_card, type: String
  field :bin, type: String
  field :currency, type: String
  field :amount, type: String
  field :card_schema, type: String
  field :card_brand, type: String
  field :exp_date, type: String
end
