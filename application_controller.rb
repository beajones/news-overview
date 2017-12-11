require 'bundler'
Bundler.require
require_relative 'models/model.rb'
class MyApp < Sinatra::Base

  get '/' do
    # define list of sources and their biases
    # (based on info from mediafactcheck.org)
    @source_biases = {
      "strong-left" => "msnbc",
      "left" => "cnn",
      "left-center" => "the-new-york-times",
	    "least-biased" => "associated-press",
	    "right-center" => "the-wall-street-journal",
	    "right" => "fox-news",
	    "strong-right" => "breitbart-news" 
    }
    
    # get_articles returns an array of article hashes
    @articles = get_articles(@source_biases)
    erb :index
  end
  
end