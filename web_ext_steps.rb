When /^I select the following:$/ do |table|
  table.raw.each do |field, value|
    When %Q{I select "#{value}" from "#{field}"}
  end
end

Then /^the "([^\"]*)" textarea(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    if defined?(Spec::Rails::Matchers)
      find_field(field).text.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_labeled(field).text)
    end
  end
end

Then /^I should see the following in order:$/ do |table|
  page.body.should match(Regexp.new(table.raw.join('.*?'), Regexp::MULTILINE))
end

When /^the "([^\"]*)" field should be empty$/ do |field|
  find_field(field).value.should be_nil
end

Then /^I should( not)? see the following:$/ do |negate, table|
  table.raw.each do |row|
    Then %Q{I should#{negate} see "#{row[0]}"}
  end  
end

When /^(.*) in the "([^\"]*)" section$/ do |action, title|
  within :xpath, "//*[(h1|h2|h3|h4|h5|h6|legend|caption)/descendant-or-self::*[contains(text(), '#{title}')]]" do
    When action
  end
end

When /^(.*) in the "([^\"]*)" row$/ do |action, title|
  within :xpath, "//*[(th|td)/descendant-or-self::*[contains(text(), '#{title}')]]" do
    When action
  end
end

Then /^I should see (?:(css|xpath) )?selector "([^\"]*)" (\d+) times?$/ do |mode, selector, number|
  mode = :css if mode.blank?
  all(mode.to_sym, selector).should have(number.to_i).items
end

When /^(.*) inside (?:(xpath|css) )?"([^\"]*)"$/ do |step, selector_type, selector|
  selector_type ||= Capybara.default_selector
  within(selector_type.to_sym, selector) do
    When step
  end
end

When /^(.*) inside (?:(xpath|css) )?"([^\"]*)":$/ do |step, selector_type, selector, table|
  selector_type ||= Capybara.default_selector
  within(selector_type.to_sym, selector) do
    When step + ":", table
  end
end