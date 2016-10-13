class PurchaseController < ApplicationController
  def generate
    user = valid_user(request.env["HTTP_USER_ID"], request.env["HTTP_SECRET_KEY"])
    if !user.any?
      return render json: {:message => 'invalid user'}, status: :unauthorized
    end
    token_card = TokenCard.new(params['token'])
    credit_card_data = token_card.find
    if credit_card_data == nil
      return render json: {:message => 'invalid token'}, status: :bad_request
    end


    if !valid_currency(params['currency'])
      return render json: {:message => 'invalid currency'}, status: :bad_request
    end

    if !valid_cvc(params['cvc'])
      return render json: {:message => 'invalid cvc'}, status: :bad_request
    end

    if !validate_amount(params['amount'])
      return render json: {:message => 'invalid amount'}, status: :bad_request
    end

    credit_card_data["amount"] = params['amount']
    credit_card_data["currency"] = params['currency']
    if !process_purchase(credit_card_data)
      return render json: {:message => 'error with your purchase pls contact your bank'}, status: :bad_request
    end
    return render json: {:message => 'purchase succes', :transaction_id => @transaction_id}
  end


  private
  def valid_currency(currency_id)
    if currency_id != nil
      currency_id = currency_id.strip.upcase
    end
    currency = Currency.where(currency_id: currency_id)
    if !currency.any?
      return false
    end
    true
  end

  def valid_cvc(cvc)
    if !/^[0-9]{3,4}$/.match(cvc)
      return false
    end
    true
  end


  def validate_credit_credit_card_in_token(credit_card, token_card)

    credit_card.eql? token_card

  end

  def validate_date_with_token(date, token_date)
    date.eql? token_date

  end

  def validate_amount(amount)
    if !/^[0-9]{1,15}\.[0-9]{2,3}$/.match(amount)
      return false
    end
    true
  end

  def process_purchase(params)
    if params['credit_card_number'] == '4012888888881881'
      return false
    end



    @transaction_id = SecureRandom.hex(10)

    purchase_data = {:name => params["name"], :credit_card => params["credit_card_number"], :bin => params["bin"],
     :currency => params["currency"], :amount => params["amount"], :card_schema => params["is_credit"],
     :card_brand => params["credit_card_type"], :exp_date => params["exp_date"], :tans_id => @transaction_id}
    if !create_purchase(purchase_data)
      return false
    end

    remove_token = TokenCard.new(nil)
    remove_token.remove(params['token'])
    true
  end

  def create_purchase(transaction_params)

    @transaction = Transaction.new(transaction_params)
    @transaction.save

  end


end
