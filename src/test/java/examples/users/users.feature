  #Autor: Juan Diego Moncaleano Quiñones
  # language: en

  Feature: User´s CRUD

    Background:
      * url baseUrl
      * header Accept = "application/json"
      * def create_user_request =
    """
    {
      "id": 0,
      "username": "EricaL",
      "firstName": "Erica Lorena",
      "lastName": "Marin",
      "email": "erical@gmail.com",
      "password": "Password123*",
      "phone": "3009876546",
      "userStatus": 1
    }
    """
      * def update_user_request =
    """
    {
      "id": 0,
      "username": "EricaL",
      "firstName": "Erica Lauren",
      "lastName": "Marin",
      "email": "ericalala@gmail.com",
      "password": "Password123*",
      "phone": "3009876546",
      "userStatus": 1
    }
    """


    Scenario: Create a user

# Aqí enviamos la información del usuario que vamos a crear
      Given path '/user'
      And request create_user_request
      When method post
      Then status 200

      * def userName = create_user_request.username
      * print 'User Name: ',userName


    Scenario: Search the new user
      # Aquí buscamos el usuario que acabamos de buscar
      Given path '/user/',create_user_request.username
      When method get
      Then status 200

      * def expectedUsername = create_user_request.username
      * def expectedEmail = create_user_request.email

      And match response.username == expectedUsername
      And match response.email == expectedEmail



    Scenario: Update user
        #Aquí se actualizaran los datos firstname y email
      Given path '/user/',create_user_request.username
      And request update_user_request
      When method put
      Then status 200


    Scenario: Delete an user
     # Aquí eliminamos el usuario que acabamos de buscar
      Given path '/user/',create_user_request.username
      When method delete
      Then status 200





