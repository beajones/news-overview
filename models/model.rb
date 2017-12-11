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
# INPUT: source_hash, a hash with arrays of source ids as values
#		 article_data, an array of article hashes from news-api
#		 num_per_source, a user-given argument for the number of articles to
#						 include from each source (maximum 10, per API)
# OUTPUT: a trimmed array of article hashes
def trim_article_data(source_hash, article_data, num_per_source)
	# array to hold results
	trimmed_array = []
	
	# iterate through arrays of sources
	source_hash.each_value do |source_array|
		source_array.each do |source|
			# initialize array to hold articles for each source
			temp_array = []
			# check for correct source and add to source's temp array
			article_data.each do |article_hash|
				if article_hash["source"]["id"] == source then
					temp_array.push(article_hash)
				end
			end
			# sample number of articles per source as indicated
			temp_array = temp_array.sample(num_per_source)
			# append contents of temp_array onto result array
			trimmed_array.concat(temp_array)
		end
	end
	return trimmed_array
end

