Feature: Get elo scores
  This gets the score from http://www.eloratings.net/world_cup.html.

Scenario: Get html
  When there is no html already
  Then get the html
  And the html should be there
