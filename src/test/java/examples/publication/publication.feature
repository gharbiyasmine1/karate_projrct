Feature: Test de publication

  Background:

    * url 'https://preprod.thrundrz.fr/backendpublic/public/api/v1/'
     Given path 'login/client'
    * def body_login = 
    """
    {
    "email": "yasmine@example.com",
    "password": "motdepasse123",
    "fcm_token": "fcm_xxx"
    }
    """
    And request body_login
    When method post
    Then status 200
    * def token = response.token

    @partagerEvenement
  Scenario:
    Given path 'posts/share-event'
    * def bodyPartager =
    """
    {
    "even_id": 42,
    "titre": "Je participe à ce concert 🎉 Qui vient ?",
    "contenu": "Je serai là dès 20h"
    }
    """
    And request bodyPartager
    * header Authorization = 'Bearer ' + token 
    When method post
    Then status 201
    * def msg_response = response.message 
    * def msg_attendu = "Événement partagé"
    Then match msg_response == msg_attendu
    * def id = response.data.id

    Given path 'posts' , id , 'comments'
     * def bodyCommenter =
    """
    {
    "contenu": "Super, je viens aussi !",
      "parent_id": null

    }
    """
    And request bodyCommenter
    * header Authorization = 'Bearer ' + token 
    When method post
    Then status 201
    Then match response.success == true

     Given path 'posts/' + id + '/like'
    * header Authorization = 'Bearer ' + token 
    When method post
    Then status 200
    Then match response.success == true

    Given path 'posts', id
    * header Authorization = 'Bearer ' + token 
     When method delete
    Then status 200
    Then match response.message == "Publication supprimée"








   







    
