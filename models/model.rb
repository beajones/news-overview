#import the gems we need to pull data from an API
require 'net/http'
require 'json'
require 'rubygems'


# get the top articles from news sources stored as values in a hash
def get_articles(source_hash)
	# make string of all the sources in hash
	sources_string = ""
	source_hash.each_value do |source_array|
		source_array.each do |source|
			sources_string += "#{source},"
		end
	end


	request_string = "https://newsapi.org/v2/top-headlines?sources=#{sources_string}&apiKey=ecd08186d0394c99bcd808f2f76eed1b"
	
	sample_uri = URI(request_string) #opens a portal to the data at that link
	sample_response = Net::HTTP.get(sample_uri) #go grab the data in the portal
	sample_parsedResponse = JSON.parse(sample_response) #makes data easy to read
	
	# articles stored as an ARRAY stored in value of key "articles"
	article_data = sample_parsedResponse["articles"]
	# data is now an array of articles from all sources
	return article_data
end

# return result array with a certain number of articles per source
def trim_article_data(source_hash, article_data, num_per_source)
	# array to hold results
	trimmed_array = []
	i = 0
	
	source_hash.each_value.each do |source|
		while i < num_per_source do
			article_data.each do |article_hash|
				if article_hash["source"]["id"] == source then
					trimmed_array.push(article_hash)
					i+= 1
				end
			end
		end
	end

	return trimmed_array
end

@source_biases = {
      "left" => ["cnn","msnbc"],
      "left-center" => ["the-new-york-times","bbc-news"],
	    "least-biased" => ["associated-press","reuters"],
	    "right-center" => ["the-wall-street-journal","the-telegraph"],
	    "right" => ["fox-news","breitbart-news"]
    }
@articles = get_articles(@source_biases)
@trimmed_articles = trim_article_data(@source_biases, @articles, 5)
puts @trimmed_articles.length
p @trimmed_articles

