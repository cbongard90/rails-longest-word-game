# The games controller
require 'open-uri'
require 'json'

# The games controller
class GamesController < ApplicationController
  def new
    alphabet = ('A'...'Z').to_a
    # Generate 9 random letters
    @letters = []
    (0...10).each { |index| @letters[index] = alphabet.sample }
    @letters
  end

  def score
    guess = params[:guess].upcase
    grid = params[:letters].split(',')

    @valid_answer = valid_answer?(guess, grid)
    @valid_word = valid_word?(guess)
    # if valid_answer && valid_word
    #   @answer = win_message()
    # else
    #   @answer = lose_message(guess, valid_word)
    # end
  end

  private

  def valid_answer?(guess, grid)
    # verify IF the letters of the guess are in the grid
    # Break down each character of the guess
    guess_array = guess.chars
    # Find the letter present in the grid and delete it from the guess
    grid.each do |char|
      index = guess_array.find_index(char)
      guess_array.delete_at(index) unless index.nil?
    end
    guess_array.empty?
  end

  def valid_word?(guess)
    url = "https://wagon-dictionary.herokuapp.com/#{guess}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end
end
