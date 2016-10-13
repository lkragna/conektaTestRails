para realizar una prueba es necesario que este cargada la moneda y un usuario en base de datos
los pueden cargar desde la aplicación en la siguiente rutas

    usuarios: http://localhost:3000/users/
    monedas: http://localhost:3000/currencies/
    
pueden realizar una prueba de generación de token a 
    
    http://localhost:3000/token/new
    curl -X "POST" "http://localhost:3000/token/new" \
         -H "user_id: 1234" \
         -H "Content-Type: application/json" \
         -H "secret_key: qwerty" \
         -d "{\"credit_card_number\":\"4123123409872345\",\"exp_date\":\"04/19\",\"name\":\"ramses carbajal\",\"is_credit\":\"true\"}"

para procesar una compra 
    
    http://localhost:3000/purchase/generate
    curl -X "POST" "http://localhost:3000/purchase/generate" \
         -H "user_id: 1234" \
         -H "Content-Type: application/json" \
         -H "secret_key: qwerty" \
         -d "{\"token\":\"bda8bd174eb00885be28\",\"currency\":\"MXN\",\"amount\":\"1234.12\",\"cvc\":\"123\"}"



también pueden simular una compra rechazada con la tarjeta 

    4012888888881881

redis esta configurado en 
    
    config/initializers/redis.rb

y mongo esta configurado en 
    
    config/mingoid.yml


se utilizo rspec para hacer las pruebas, pueden ejecutarlas cargado un usuario y una moneda con el siguiente comando

    bundle exec rspec
    