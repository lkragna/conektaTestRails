class TokenCard
  attr_reader(:token)
  def initialize(params)
    @params = params
  end

  def encript(text_to_encript)
    pass = "secret"
    salt = "saltsalt"
    iter = 20000
    key_len = 16
    key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, iter, key_len)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = key
    cipher.iv = key
    encrypted = cipher.update(text_to_encript) + cipher.final
  end


  def decript(text_to_decipher)

    pass = "secret"
    salt = "saltsalt"
    iter = 20000
    key_len = 16
    key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, iter, key_len)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = key
    decipher.iv = key
    plain = decipher.update(text_to_decipher) + decipher.final

  end
  def save

    @token = SecureRandom.hex(10)
    new_params = valid_params(@params)
    $redis.set(@token, encript(new_params.to_json))
    $redis.expire( @token, 60*5 )





  end


  def valid_params(params)
    new_params = {:credit_card_number => params[:credit_card_number], :exp_date=> params[:exp_date], :name => params[:name],
                  :bin => params[:bin], :credit_card_type => params[:credit_card_type], :is_credit =>  params[:is_credit]}

  end

  def find
    redis_reponse = $redis.get(@params)
    if(redis_reponse != nil)
      card_info = JSON.parse(decript(redis_reponse))

    end
    card_info
  end

  def test_token(test_params)
    if(test_params == nil)
      test_params = {:credit_card_number=>"3456", :exp_date=>"11/18", :name=>"Ramses Carbajal", :bin=>"513456", :credit_card_type=>"MASTERCARD", :is_credit=>true}
    end
    @params = test_params
    save()
    @token
  end
  def remove(token)
    $redis.del(token)
  end


end