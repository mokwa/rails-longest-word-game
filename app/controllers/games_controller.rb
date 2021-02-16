require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end
  def score
    if can_be_built?(params[:word]) == false
      end_score = "Sorry but #{params[:word]} cant't be built out of #{@letters}"
    elsif english_word?(params[:word]) == false
      end_score =  "Sorry but #{params[:word]} does not seem to be a valid English word"
    else
      end_score =  "Congratulations #{params[:word]} is a valid English word"
    end
    retun end_score
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json_string = open(url).read
    json_hash = JSON.parse(json_string)
    return true if json_hash["word"] == 'yes'
  end

  def can_be_built?(word)
    word = word.chars
    word.forEach do |letter|
      return false unless @letters.include? letter

      @letters.delete(letter)
    end
  end
end
