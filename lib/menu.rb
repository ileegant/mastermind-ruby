# frozen_string_literal: true

require 'tty-prompt'
require 'colorize'

class Menu
  def initialize
    @prompt = TTY::Prompt.new
    @display = Display.new
    @options = [
      { name: 'Start', value: 1 },
      { name: 'Rules', value: 2 },
      { name: 'Exit', value: 0 }
    ]
    @roles = [
      { name: 'Codebreaker', value: true },
      { name: 'Codemaker', value: false }
    ]
  end

  def run
    loop do
      @display.header
      user_choice = @prompt.select('', @options, symbols: { marker: '•' })
      handle_choice(user_choice)
    end
  end

  private

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
    role = @prompt.select('Choose your role:', @roles, symbols: { marker: '•' })
    Mastermind.new.play
  end

  def display_rules
    @display.rules
    @prompt.keypress('Press any key to go back to the main menu')
    system('clear')
  end

  def exit_program
    puts 'Goodbye!'
    exit
  end
end
