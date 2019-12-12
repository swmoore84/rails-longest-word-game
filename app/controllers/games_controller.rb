class GamesController < ApplicationController
  def new
    @letters = generate_grid
  end

  def score
    # raise
    @answer = params[:word]
    @grid = params[:letters].split
    puts @grid
    @real_word = check_if_word?(@answer)
    @in_grid = check_word_grid?(@answer, @grid)
  end

  def generate_grid
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def check_word_grid?(word, letter_grid)
    word_char = word.upcase.split(//)
    grid = letter_grid.clone
    word_char.each do |char|
      if grid.include?(char)
        grid.delete_at(grid.index(char))
      else
        return false
      end
    end
    return true
  end

  def check_if_word?(word)
    require 'json'
    require 'open-uri'
    require 'rest_client'

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # word_serialized = open(url).read
    word_serialized = RestClient.get(url)
    word = JSON.parse(word_serialized)
    word['found']
  end


end
