Feature: Get elo scores
    This should get the score from http://www.eloratings.net/world_cup.html

Scenario: Get html
    Give the application is started
    When there is no html already
    Then get the html
