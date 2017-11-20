require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    r = Random.new
    10.times do
      @letters << r.rand(65..90).chr
    end
    # raise
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if word_not_in_the_grid?(@word, @letters)
      @result = "not in the grid"
    else
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      word_serialized = open(url).read
      word = JSON.parse(word_serialized)
      if  word["found"] == true
        @score = word["length"]
      else
        @score = "not in the English dictionary"
      end
    end
  end
end

private

def word_not_in_the_grid?(attempt,grid)
  attempt.downcase.chars.any? { |char| attempt.downcase.count(char) > grid.downcase.count(char) }
end
