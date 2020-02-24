
require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def clear_screen
  system("clear") || system("cls")
end

def messages(message)
  MESSAGES[message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def number?(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

def valid?(input)
  number?(input) && input.to_f > 0
end

def retrieve_amount
  amount = ''
  loop do
    amount = gets.chomp
    break if valid?(amount)
    prompt(messages('try_again'))
  end
  amount
end

clear_screen
prompt(messages('welcome'))

loop do
  prompt("What is your loan amount?")
  loan_amount = retrieve_amount
  prompt("What is the Annual Percentage Rate (APR)?")
  prompt("Enter 2.5 for 2.5%, 0.5 for 0.5%")
  apr = retrieve_amount
  prompt("What is the loan duration (in months)?")
  duration_in_months = retrieve_amount
  monthly_interest_rate = (apr.to_f / 100) / 12
  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**-duration_in_months.to_i))
  prompt("Monthly payment: $#{format('%.2f', monthly_payment)}")

  prompt(messages('another_calculation'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('good_bye'))
