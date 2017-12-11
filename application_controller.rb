require 'bundler'
Bundler.require
require_relative 'models/model.rb'
class MyApp < Sinatra::Base

  get '/' do
    # define list of sources and their biases
    # (based on info from mediafactcheck.org)
    @source_biases = {
      "left" => ["cnn","msnbc"],
      "left-center" => ["the-new-york-times","bbc-news"],
	    "least-biased" => ["associated-press","reuters"],
	    "right-center" => ["the-wall-street-journal","the-telegraph"],
	    "right" => ["fox-news","breitbart-news"]
    }
    
    # get_articles returns an array of article hashes
    @articles = get_articles(@source_biases)
    erb :index
  end
  
end