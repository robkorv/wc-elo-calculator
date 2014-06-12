Feature: Calculate the match outcome

Scenario: Calculate the match outcome
  Given the elo scores are parsed
  Given there is a 2.27 average goals per match
  Then the highest rating scores ~2 goals against the lowest
  And every other match will be derived from that
  Given that "Brazil" is the highest ranked
  And "Cameroon" the lowest
  Given that the rating difference is 511 between these
  Then 511 difference will end in 2 against 0
  Then the match between "Australia" and "Italy" will be won by "Italy"
  And the score will be 1 - 2
  Then for fun output all matches
