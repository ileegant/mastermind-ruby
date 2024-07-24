# frozen_string_literal: true

class Display
  def initialize; end

  def header
    puts "
      __  __           _                      _           _
     |  \\/  |         | |                    (_)         | |
     | \\  / | __ _ ___| |_ ___ _ __ _ __ ___  _ _ __   __| |
     | |\\/| |/ _` / __| __/ _ \\ '__| '_ ` _ \\| | '_ \\ / _` |
     | |  | | (_| \\__ \\ ||  __/ |  | | | | | | | | | | (_| |
     |_|  |_|\\__,_|___/\\__\\___|_|  |_| |_| |_|_|_| |_|\\__,_| (ruby)

     2024 @ileegant
     "
  end

  def rules
    puts 'Rules in progress'
  end

  def board(guesses)
    turns = Mastermind::MAX_TURNS - guesses.length

    guesses.transpose.each do |guess|
      guess.each { |color| print '  ⬤  '.colorize(color) }
      empty_spots(turns)
    end
  end

  def hints(hints)
    hints.flatten.each_slice(2).to_a.transpose.each do |hint|
      hint.each_with_index { |color, index| print "#{' ⦿'.colorize(color)}#{' ' if index.odd?}" }
      puts
    end
  end

  def secret_code(code)
    code.map { |color| '⬤'.colorize(color) }.join(' ')
  end

  def winner(code, guesses)
    puts 'WINNER! You cracked the code!'.colorize(:green)
    puts "The code was: #{secret_code(code)}"
    puts "You took #{guesses.length} turn(s) to solve it."
  end

  def loser(code)
    puts "LOOOOOOSER! You've used all your turns.".colorize(:red)
    puts "The code was: #{secret_code(code)}"
  end

  def empty_spots(turns)
    puts ('  ⬤  ' * turns).colorize(:gray)
  end

  def clear
    system('clear')
  end
end
