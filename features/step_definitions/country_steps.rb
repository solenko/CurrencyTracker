Given /the following countries exist:/ do |countries|
  Country.create!(countries.hashes)
end

Given /user "([^"]*)?" visit countries "([^"]*)?"/ do |user_email, country_list|
  user = User.where(:email => user_email).first!
  country_list.split(',').each do |country_code|
    country = Country.where(:code => country_code.strip).first!
    FactoryGirl.create :user_visit, :country => country, :user => user
  end
end


Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('section>table>tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }

  expected_table.diff!(rows)
end
