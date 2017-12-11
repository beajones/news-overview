#import the gems we need to pull data from an API
require 'net/http'
require 'json'
require 'rubygems'


# get the top articles from news sources stored as keys in a hash
def get_articles(source_hash)
	# make string of all the sources in hash
	sources_string = ""
	source_hash.each_key do |source| 
		sources_string += "#{source},"
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

# p get_articles(source_biases)


# method to get headlines of articles from a certain source
# INPUT: an array of article hashes as fetched from an API
# OUTPUT: an array of the headlines of reviews
# def get_headlines(source_array)
#     #search through urls for review
   
#   headline_array=[]
   
#   source_array.each do |article_hash|
#       #get the url for each article
#       this_url = article_hash["url"]
#       #check to see if this article is a review
#       if this_url.end_with?("-review","review/") || this_url.include?("review-")
#           #find the review, return the hash for this article
#           article_array.push(article_hash)
#       end
#   end
#   #return the array of review article hashes
#   return headline_array
# end



