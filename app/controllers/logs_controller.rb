class LogsController < ApplicationController

	before_action :current_selected_date
	before_action :set_log

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

		if response.nil?
			current_user.recent_search = []
		else
			current_user.recent_search = response["common"]
		end

		current_user.save

		redirect_back fallback_location: root_path
	end

	def add_food
		header = { 
		  "x-remote-user-id" => "0",
		  "x-app-id" => ENV['nutritionix_id'],
		  "x-app-key" => ENV['nutritionix_key']
		}

		body = {
			"query" => params[:term]
		}

		response = HTTParty.post("https://trackapi.nutritionix.com/v2/natural/nutrients", 
		  :body => body,
		  :headers => header
		)

		food_data = {
			name: response["foods"][0]["food_name"],
			thumb: response["foods"][0]["photo"]["thumb"],
			serving: response["foods"][0]["serving_unit"],
			grams: response["foods"][0]["serving_weight_grams"],
			calories: response["foods"][0]["nf_calories"],
			fat: response["foods"][0]["nf_total_fat"],
			sat_fat: response["foods"][0]["nf_saturated_fat"],
			mono_fat: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 645}[0]["value"],
			poly_fat: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 646}[0]["value"],
			trans_fat: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 605}[0]["value"],
			cholesterol: response["foods"][0]["nf_cholesterol"],
			protein: response["foods"][0]["nf_protein"],
			carbs: response["foods"][0]["nf_total_carbohydrate"],
			sugar: response["foods"][0]["nf_sugars"],
			fiber: response["foods"][0]["nf_dietary_fiber"],
			b1: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 404}[0]["value"],
			b2: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 405}[0]["value"],
			b3: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 406}[0]["value"],
			b5: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 410}[0]["value"],
			b6: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 415}[0]["value"],
			b12: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 418}[0]["value"],
			folate: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 417}[0]["value"],
			a: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 318}[0]["value"],
			c: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 401}[0]["value"],
			d: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 324}[0]["value"],
			e: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 323}[0]["value"],
			k: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 430}[0]["value"],
			calcium: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 301}[0]["value"],
			iron: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 303}[0]["value"],
			magnesium: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 304}[0]["value"],
			phosphorus: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 305}[0]["value"],
			potassium: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 306}[0]["value"],
			sodium: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 307}[0]["value"],
			zinc: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 309}[0]["value"],
			copper: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 312}[0]["value"],
			fluoride: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 313}[0]["value"],
			manganese: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 315}[0]["value"],
			selenium: response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 317}[0]["value"]
		}

		@log.foods.push(food_data)
		@log.save

		redirect_back fallback_location: root_path
	end

	def load_dash
		date = Date.parse params[:date].values.join("-")

		if Log.where(user_id: current_user.id).find_by(date: date).nil?
			@log = current_user.logs.create(date: date)
		else
			@log = Log.where(user_id: current_user.id).find_by(date: date)
		end

		current_user.update(selected_date: date)
		current_user.save

		redirect_back fallback_location: root_path
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

	private

		def current_selected_date
			puts "CURRENT_SELECTED_DATE HAS BEEN CALLED"
			if current_user.selected_date.nil?
				current_user.update(selected_date: Date.today)
				current_user.save
			end
			@selected_date = current_user.selected_date
		end

		def set_log
			puts "SET_LOG HAS BEEN CALLED"
			if Log.where(date: @selected_date).find_by(user_id: current_user.id).nil?
				@log = current_user.logs.create(date: @selected_date)
			else
				@log = Log.where(date: @selected_date).find_by(user_id: current_user.id)
			end
		end

    def all_logs
      @logs = Log.where(user_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:date, :foods, :user_id)
    end

end
