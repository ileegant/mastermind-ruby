# frozen_string_literal: true

require 'tty-prompt'
require 'colorize'

class Menu
  def initialize
    @prompt = TTY::Prompt.new
    @options = [
      { name: 'Start', value: 1 },
      { name: 'Rules', value: 2 },
      { name: 'Exit', value: 0 }
    ]
  end

  def run
    loop do
      display_header
      user_choice = @prompt.select('', @options, symbols: { marker: '•' })
      handle_choice(user_choice)
      break if user_choice == 1
    end
  end

  private

  def display_header
    puts <<-HEADER

      __  __           _                      _           _
     |  \\/  |         | |                    (_)         | |
     | \\  / | __ _ ___| |_ ___ _ __ _ __ ___  _ _ __   __| |
     | |\\/| |/ _` / __| __/ _ \\ '__| '_ ` _ \\| | '_ \\ / _` |
     | |  | | (_| \\__ \\ ||  __/ |  | | | | | | | | | | (_| |
     |_|  |_|\\__,_|___/\\__\\___|_|  |_| |_| |_|_|_| |_|\\__,_| (ruby)

     2024 @ileegant
    HEADER
  end

  def handle_choice(choice)
    case choice
    when 1
      start_game
    when 2
      display_rules
    when 0
      exit_program
    else
      puts 'Invalid choice, please try again.'
    end
  end

  def start_game
    Mastermind.new.play
  end

  def display_rules
    puts 'Rules'
    puts 'These are the rules of the game...'
    @prompt.keypress('Press any key to go back to the main menu')
    system('clear')
  end

  def exit_program
    puts 'Goodbye!'
    exit
  end
end
