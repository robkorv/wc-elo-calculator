Feature: Parse elo scores
  This parses the scores in eloratings

Scenario: Get html
  Given there is a test set
  Then parse the elorating
  Then search the dom for the ratings table
  Then find a way to read the values
  And create an object with the score per country
