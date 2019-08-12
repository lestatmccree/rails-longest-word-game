require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    word = params[:word]
    json = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    data = JSON.parse(json)
    # data = JSON.parse(open(url).read)
    if data["found"] && check(word, params[:letters])
      @message = "Congratulations!"
    else
      @message = "Fail"
    end
  end

  def check(word, letters)
    word.each_char do |char|
      return false unless letters.include?(char)
    end
    true
  end
end
