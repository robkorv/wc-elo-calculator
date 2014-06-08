Feature: Get elo scores
  This gets the score from http://www.eloratings.net/world_cup.html.

Scenario: Get elorating
  When there is no elorating
  Then get the html
  And the html should be there
