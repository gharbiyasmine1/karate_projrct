Feature: karate first test api

   Background:
    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def firstName = faker.name().firstName()
    * def lastName = faker.name().lastName()
    * def email = faker.internet().emailAddress()
    * def salary = faker.number().numberBetween(1000,5000)
    
    * url 'https://api.efi-academy.com'
     Given path 'auth/login'
    * def body_login = 
    """
    {
    "username": "admin",
    "password": "admin123"
    }
    """ 
    And request body_login
    When method post
    Then status 200
    * def token = response.accessToken


 
    @creerEmployee
    Scenario:creer un employe 
    * url 'https://api.efi-academy.com'
    Given path 'public/employees'
    * def body_emp = 
    """
    {
    "firstName": "Alice",
    "lastName": "Dupont",
    "email": "(#email)",
    "position": "Software Engineer",
    "salary": 55000,
    "hireDate": "2022-01-15",
    "status": "ACTIVE"
    }
    """
    And request body_emp
    When method post
    Then status 201
    * def msg_res = response.message 
    * def msg_att = "Employee created."
    Then match msg_res == msg_att
    Then match response.data.firstName == body_emp.firstName
    Given path 'public/employees' , response.data.id
    * def body = 
    """
    {
    "firstName": "Yass"
    }
    """
     And request body
     When method put
    Then status 200
    Then match response.data.firstName == body.firstName
    * def id = response.data.id


    
    Given path 'public/employees' , response.data.id
    When method delete
    Then status 200
    * def msg_res_delete = response.message 
    * def msg_att_delete = "Employee " + id + " deleted."
    Then match msg_res_delete == msg_att_delete

    
    @token
  Scenario:creer un employe avec token  
    * url 'https://api.efi-academy.com'
    Given path 'api/employees'
    * def body_emp = 
    """
    {
    "firstName": "Alice",
    "lastName": "Dupont",
    "email": "(#email)",
    "position": "Software Engineer",
    "salary": 55000,
    "hireDate": "2022-01-15",
    "status": "ACTIVE"
    }
    """
    And request body_emp
    * header Authorization = 'Bearer ' + token 
    When method post
    Then status 201
    * def msg_res = response.message 
    * def msg_att = "Employee created."
    Then match msg_res == msg_att
    Then match response.data.firstName == body_emp.firstName
   
   











        





    