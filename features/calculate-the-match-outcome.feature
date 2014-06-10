Feature: Calculate the match outcome

Scenario: Calculate the match outcome
  Given there is a 2.27 average goals per match
  Then the highest rating scores ~2 goals against the lowest
  And every other match will be derived from that
  Given that "Brazil" is the highest ranked
  And "Cameroon" the lowest
  Then that match will end in 2 against 0 for "Brazil"
