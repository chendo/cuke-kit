When /^I go interactive$/ do
  require 'readline'  
  puts "^D to exit the console, '.list' to show current steps, '.dump' to copy steps to clipboard, '.clear' to clear steps"
  valid_steps = []
  while line = Readline.readline('>> ', true)
    line.strip!
    begin
      if line =~ /^(Given|When|Then|And|But).*?(:)?$/
        if $2
          while l = Readline.readline("#{$1} >> ")
            line += "\n  #{l}"
          end
        end
        
        steps line
        valid_steps << line

      elsif line == '.dump'
        IO.popen('pbcopy', 'w') do |f|
          f.puts valid_steps.join("\n")
        end
        puts "Copied #{valid_steps.length} steps to clipboard."
        valid_steps.clear
        
      elsif line == '.list'
        puts valid_steps.join("\n")
        
      elsif line == '.clear'
        valid_steps.clear
        
      else
        puts "=> #{eval(line, binding).inspect}"
      end
    rescue => e
      p e
    end
  end
end
