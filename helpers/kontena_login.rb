require 'kommando'

master_name, master_url, email, password, max_tries, delay = ARGV
success=false
tries=1

while true do
  puts "Login try ##{tries}"

  k = Kommando.new "kontena login --name #{master_name} #{master_url}", {
    output: true,
    timeout: 15
  }

  k.out.on /Email:/ do
    k.in << "#{email}\n"

    k.out.on /Password:/ do
      k.in << "#{password}\n"

      k.out.on /Welcome!/ do
        success=true
      end
    end

  end

  k.run

  break if success || tries == max_tries

  tries = tries + 1
  sleep delay.to_i
end

if success
  exit 0
else
  exit 1
end
