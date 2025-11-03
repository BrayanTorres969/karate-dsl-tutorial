Feature: Articles

  Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'users/login'
    And request {"user": {"email": "brayan@gmail.com", "password": "brayan123"}}
    When method Post
    Then status 200
    * def token = response.user.token

  Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"title": "prueba3", "description": "pruebita", "body": "Este es un nuevo articulo","tagList":['Social Media', 'Blog']}}
    When method Post
    Then status 201
    And match response.article.title == 'prueba3'

  @onlyme
  Scenario: Create and delete article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"title": "delete article", "description": "pruebita", "body": "Este es un nuevo articulo","tagList":['Social Media', 'Blog']}}
    When method Post
    Then status 201
    * def articleId = response.article.slug

    Given params {limit:10,offset:0}
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    When method Get
    Then status 200
    #* def titles = get response.articles[*].title
    #And match titles contains 'delete article'
    And match response.articles[0].title == 'delete article'

    Given header Authorization = 'Token ' + token
    Given path 'articles',articleId
    When method Delete
    Then status 204

    Given params {limit:10,offset:0}
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    When method Get
    Then status 200
    #* def titlesAfter = get response.articles[*].title
    # match titlesAfter !contains 'delete article'
    And match response.articles[0].title != 'delete article'
