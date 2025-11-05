Feature: Tests for the home page
  Background: Define URL
    Given url apiUrl
  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['Bondar Academy','Blog']
    And match response.tags !contains 'Damaris'


  Scenario: Get 10 articles from the page
    #Given param limit = 10
    #Given param offeset = 0
    Given params {limit:10,offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
