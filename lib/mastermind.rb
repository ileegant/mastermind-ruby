# frozen_string_literal: true

class Mastermind
  COLORS = %i[black white blue yellow green red].freeze
  MAX_TURNS = 12

  def initialize
    @turns   = MAX_TURNS
    @display = Display.new
    @code    = generate_secret_code
    @guesses = []
    @hints   = []
  end

  def play
    MAX_TURNS.times do
      system('clear')
      display_board_with_hints
      process_guess

      if game_won?
        @display.winner(@code, @guesses)
        break
      end

      @turns -= 1
    end

    @display.loser(@code) unless game_won?
  end

  private

  def generate_secret_code
    Array.new(4) { COLORS.sample }
  end

  def process_guess
    @guess = fetch_user_guess
    @guesses << @guess
    generate_hints
  end

  def fetch_user_guess
    print "Enter your guess (e.g., 'color color color color'):\n"
    loop do
      guess = gets.chomp.split.map(&:to_sym)
      return guess if valid_guess?(guess)

      print 'Incorrect colors. Try again: '.colorize(:red)
    end
  end

  def valid_guess?(guess)
    guess.length == 4 && guess.all? { |color| COLORS.include?(color) }
  end

  def generate_hints
    exact_matches = @guess.each_index.count { |i| @guess[i] == @code[i] }
    color_matches = calculate_color_matches - exact_matches
    no_matches = 4 - (exact_matches + color_matches)
    @hints << [:red] * exact_matches + [:yellow] * color_matches + [:white] * no_matches
    puts "#{exact_matches} red, #{color_matches} yellow, #{no_matches} white."
  end

  def calculate_color_matches
    code_tally = @code.tally
    guess_tally = @guess.tally

    guess_tally.sum do |color, count|
      [count, code_tally[color] || 0].min
    end
  end

  def display_board_with_hints
    @display.board(@guesses)
    @display.hints(@hints)
  end

  def game_won?
    @code == @guess
  end
end
