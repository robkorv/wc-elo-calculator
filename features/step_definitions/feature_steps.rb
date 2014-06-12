Before do
  @calc = Elocalculator.new
end

# Feature: Get elo scores
When(/^there is no elorating$/) do
  expect(@calc.html_exist).to be false
end

Then(/^get the html$/) do
  @calc.download_html
end

Then(/^the html should be there$/) do
  expect(@calc.html_exist).to be true
end

# Feature: Parse elo scores
Given(/^there is a test set$/) do
  @calc.html_file = 'test/eloratings.html'
  expect(@calc.html_exist).to be true
end

Then(/^parse the elorating$/) do
  @calc.parse_html
  expect(@calc.html_doc.css('title').to_s)
  .to include('World Football Elo Ratings')
end

Then(/^search the dom for the ratings table$/) do
  @calc.search_dom
  expect(@calc.found_html.to_s).to include('table')
end

Then(/^find a way to read the values$/) do
  @calc.read_values
  expect(@calc.elo_hash).to be_truthy
end

Then(/^create an object with the score per country$/) do
  expect(@calc.elo_hash).to be_an_instance_of(Hash)
end

# Feature: Calculate the match outcome
Given(/^the elo scores are parsed$/) do
  steps %Q(
    Given there is a test set
    Then parse the elorating
    Then search the dom for the ratings table
    Then find a way to read the values
    And create an object with the score per country
  )
end

Given(/^there is a (\d+)\.(\d+) average goals per match$/) do |arg1, arg2|
  expect(@calc.avg_goals).to eq("#{arg1}.#{arg2}".to_f)
end

Then(/^the highest rating scores ~(\d+) goals against the lowest$/) do
  |avg_goals|
  expect(@calc.avg_goals.round).to eq(avg_goals.to_i)
end

Then(/^every other match will be derived from that$/) do
  highest = @calc.elo_hash.max_by { | _country, rating | rating }
  lowest  = @calc.elo_hash.min_by { | _country, rating | rating }
  expect(@calc.highest).to eq(highest)
  expect(@calc.lowest).to eq(lowest)
end

Given(/^that "(.*?)" is the highest ranked$/) do |highest_country|
  expect(@calc.highest[0]).to eq(highest_country)
end

Given(/^"(.*?)" the lowest$/) do |lowest_country|
  expect(@calc.lowest[0]).to eq(lowest_country)
end

Given(/^that the rating difference is (\d+) between these$/) do |ratio_diff|
  difference = @calc.highest[1] - @calc.lowest[1]
  expect(difference).to eq(ratio_diff.to_i)
  expect(@calc.max_difference).to eq(difference)
end

Then(/^(\d+) difference will end in (\d+) against (\d+)$/) do
  |difference, goals_for, goals_against|
  winratio     = difference.to_i / @calc.max_difference
  goals_winner = winratio * @calc.avg_goals
  rest         = goals_winner - @calc.avg_goals
  expect(goals_for.to_i).to eq(goals_winner.round)
  expect(goals_against.to_i).to eq(rest.round)
end

Then(/^the match between "(.*?)" and "(.*?)" will be won by "(.*?)"$/) do
  |country1, country2, winner|
  diff_country1 = @calc.elo_hash[country1] - @calc.lowest[1]
  diff_country2 = @calc.elo_hash[country2] - @calc.lowest[1]
  winratio_country1 = diff_country1.to_f / @calc.max_difference.to_f
  winratio_country2 = diff_country2.to_f / @calc.max_difference.to_f
  total_ratio_match = winratio_country1 + winratio_country2
  match_ratio_country1 = winratio_country1 / total_ratio_match
  match_ratio_country2 = winratio_country2 / total_ratio_match
  goals_country1 = match_ratio_country1 * @calc.avg_goals
  goals_country2 = match_ratio_country2 * @calc.avg_goals
  calc_winner = goals_country1 < goals_country2 ? country2 : country1
  expect(winner).to eq(calc_winner)
end

Then(/^the score will be (\d+) \- (\d+)$/) do |goals_for, goals_against|
  matchhash = @calc.calculate_match('Australia', 'Italy')
  expect(goals_for.to_i).to eq(matchhash[:goals1])
  expect(goals_against.to_i).to eq(matchhash[:goals2])
end

Then(/^for fun output all matches$/) do
  file = File.open('output.txt', 'w')
  begin
    @calc.elo_hash.keys.each do | basecountry |
      @calc.elo_hash.keys.each do | country |
        next unless basecountry != country
        hash = @calc.calculate_match(basecountry, country)
        file.write(hash.to_s + "\n")
      end
    end
  ensure
    file.close unless file.nil?
  end
end
