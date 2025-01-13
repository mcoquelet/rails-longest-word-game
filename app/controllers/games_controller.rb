require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample;
    end
    return @letters
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(" ")
    valid = true
    @word.each_char do |char|
      valid = false unless @letters.join.count(char) >= @word.upcase.count(char) && @letters.include?(char)
    end
    if valid
      url = "https://dictionary.lewagon.com/#{@word.downcase}"
      word_check_serialized = URI.parse(url).read
      word_check = JSON.parse(word_check_serialized)
      @score = 100 if word_check["found"]
    else
      @score = 0
    end
  end
end
