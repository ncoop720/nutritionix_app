class LogsController < ApplicationController

	include LogsHelper

	before_action :set_log
	before_action :set_log_today, only: [:index]

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

		response = HTTParty.get("https://trackapi.nutritionix.com/v2/search/instant/", 
		  :query => query,
		  :headers => header
		)

		if response.nil?
			current_user.recent_search = []
		else
			current_user.recent_search = response["common"].take(10)
		end

		current_user.save

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

		response = HTTParty.post("https://trackapi.nutritionix.com/v2/natural/nutrients/", 
		  :body => body,
		  :headers => header
		)

		food_data = generate_food_data(response)

		@log.foods.push(food_data)
		@log.save

		calculate_totals(@log.foods)

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

		calculate_totals(@log.foods)
	end

	def remove_food
		@log.foods.delete_at(params[:index].to_i)
		@log.save

		calculate_totals(@log.foods)
	end

	def change_calories
		index = params[:index].to_i
		calories_old = params[:calories_old].to_f
		calories = params[:calories].to_f
		ratio = calories / calories_old

		@log.foods[index].each {|key, value|
			if key != "name" && key != "thumb"
				@log.foods[index][key] *= ratio		
			end
		}
		@log.save
		
		calculate_totals(@log.foods)
	end

	def change_grams
		index = params[:index].to_i
		grams_old = params[:grams_old].to_f
		grams = params[:grams].to_f
		ratio = grams / grams_old

		@log.foods[index].each {|key, value|
			if key != "name" && key != "thumb"
				@log.foods[index][key] *= ratio		
			end
		}
		@log.save
		
		calculate_totals(@log.foods)
	end

	private

		def set_log

			if current_user.selected_date.nil?
				current_user.update(selected_date: Date.today)
				current_user.save
			end

			@selected_date = current_user.selected_date

			if Log.where(date: @selected_date).find_by(user_id: current_user.id).nil?
				@log = current_user.logs.create(date: @selected_date)
			else
				@log = Log.where(date: @selected_date).find_by(user_id: current_user.id)
			end

			calculate_totals(@log.foods)
		end

		def set_log_today
			current_user.update(selected_date: Date.today)
			current_user.save

			if Log.where(date: Date.today).find_by(user_id: current_user.id).nil?
				@log = current_user.logs.create(date: Date.today)
			else
				@log = Log.where(date: Date.today).find_by(user_id: current_user.id)
			end

			calculate_totals(@log.foods)
		end

    def all_logs
      @logs = Log.where(user_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:date, :foods, :user_id)
    end

end
