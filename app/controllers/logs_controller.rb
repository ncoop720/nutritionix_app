class LogsController < ApplicationController

	$most_recent_search = []

	def index

	end

	def search_food
		query = { 
		  "query" => params[:term],
		  "branded" => false
		}

		header = { 
		  "x-remote-user-id" => "0",
		  "x-app-id" => ENV['nutritionix_id'],
		  "x-app-key" => ENV['nutritionix_key']
		}

		response = HTTParty.get("https://trackapi.nutritionix.com/v2/search/instant", 
		  :query => query,
		  :headers => header
		)

		$most_recent_search = response["common"]

		redirect_to root_path

	end

	# def test
	# 	query = { 
	# 	  "query" => params[:term],
	# 	  "branded" => false
	# 	}

	# 	header = { 
	# 	  "x-remote-user-id" => "0",
	# 	  "x-app-id" => ENV['nutritionix_id'],
	# 	  "x-app-key" => ENV['nutritionix_key']
	# 	}

	# 	response = HTTParty.get("https://trackapi.nutritionix.com/v2/search/instant", 
	# 	  :query => query,
	# 	  :headers => header
	# 	)

	# 	body = {
	# 		"query" => response["common"][0]["food_name"]
	# 	}

	# 	response2 = HTTParty.post("https://trackapi.nutritionix.com/v2/natural/nutrients", 
	# 	  :body => body,
	# 	  :headers => header
	# 	)

	# 	puts response["common"][0]["food_name"]

	# 	puts response2

	# 	redirect_to root_path
	# end

end
