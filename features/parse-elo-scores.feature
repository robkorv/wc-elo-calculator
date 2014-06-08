Feature: Parse elo scores
  This parses the scores in eloratings

Scenario: Get html
  Given there is a test set
  Then parse the elorating
  And I will have an object with the score per country
