# Cuke-kit

Here are some cucumber steps that I find insanely useful.

Documentation below is not complete, also it's probably better if you just check out the steps.

## web_ext_steps.rb:

### When I select the following:

    When I select "foo" from "bar"
    And I select "bar" from "baz"
    
turns into

    When I select the following:
      | foo | bar |
      | bar | baz |
    
### When ... in the row/section

Wrapper step courtesy of Tim Pope. Scopes the step to a table row or an element with the specified header.


## interactive_steps.rb:

### When I go interactive

Drops you into an irb-style prompt where you can enter steps or ruby code.
Works best for writing tests to cover an existing site with Selenium.
    
