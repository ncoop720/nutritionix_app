module LogsHelper

	def calculate_totals(food_log_arr)
    	@cals = 0
    	@fat = 0
    	@sat_fat = 0
    	@mono_fat = 0
    	@poly_fat = 0
    	@trans_fat = 0
    	@chol = 0
    	@protein = 0
    	@carbs = 0
    	@fiber = 0
    	@sugar = 0
    	@b1 = 0
    	@b2 = 0
    	@b3 = 0
    	@b5 = 0
    	@b6 = 0
    	@b12 = 0
    	@folate = 0
    	@v_a = 0
    	@v_c = 0
    	@v_d = 0
    	@v_e = 0
    	@v_k = 0
    	@calcium = 0
    	@iron = 0
    	@magnesium = 0
    	@phosphorus = 0
    	@potassium = 0
    	@sodium = 0
    	@zinc = 0
    	@copper = 0
    	@fluoride = 0
    	@manganese = 0
    	@selenium = 0

    	food_log_arr.each do |food|
    		@cals += food[:calories]
	    	@fat += food[:fat]
	    	@sat_fat += food[:sat_fat]
	    	@mono_fat += food[:mono_fat]
	    	@poly_fat += food[:poly_fat]
	    	@trans_fat += food[:trans_fat]
	    	@chol += food[:cholesterol]
	    	@protein += food[:protein]
	    	@carbs += food[:carbs]
	    	@fiber += food[:fiber]
	    	@sugar += food[:sugar]
	    	@b1 += food[:b1]
	    	@b2 += food[:b2]
	    	@b3 += food[:b3]
	    	@b5 += food[:b5]
	    	@b6 += food[:b6]
	    	@b12 += food[:b12]
	    	@folate += food[:folate]
	    	@v_a += food[:a]
	    	@v_c += food[:c]
	    	@v_d += food[:d]
	    	@v_e += food[:e]
	    	@v_k += food[:k]
	    	@calcium += food[:calcium]
	    	@iron += food[:iron]
	    	@magnesium += food[:magnesium]
	    	@phosphorus += food[:phosphorus]
	    	@potassium += food[:potassium]
	    	@sodium += food[:sodium]
	    	@zinc += food[:zinc]
	    	@copper += food[:copper]
	    	@fluoride += food[:fluoride]
	    	@manganese += food[:manganese]
	    	@selenium += food[:selenium]
    	end
    end

    def food_data_help(var_data)
    	if var_data != []
    		return var_data[0]["value"]
    	else
    		return 0
    	end
    end

    def food_date_help2(var_data)
    	if var_data != []
    		return var_data
    	else
    		return 0
    	end
    end

    def generate_food_data(response)
    	food_data = {
				name: food_date_help2(response["foods"][0]["food_name"]),
				thumb: food_date_help2(response["foods"][0]["photo"]["thumb"]),
				serving: food_date_help2(response["foods"][0]["serving_unit"]),
				grams: food_date_help2(response["foods"][0]["serving_weight_grams"]),
				calories: food_date_help2(response["foods"][0]["nf_calories"]),
				fat: food_date_help2(response["foods"][0]["nf_total_fat"]),
				sat_fat: food_date_help2(response["foods"][0]["nf_saturated_fat"]),
				mono_fat: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 645}),
				poly_fat: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 646}),
				trans_fat: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 605}),
				cholesterol: food_date_help2(response["foods"][0]["nf_cholesterol"]),
				protein: food_date_help2(response["foods"][0]["nf_protein"]),
				carbs: food_date_help2(response["foods"][0]["nf_total_carbohydrate"]),
				sugar: food_date_help2(response["foods"][0]["nf_sugars"]),
				fiber: food_date_help2(response["foods"][0]["nf_dietary_fiber"]),
				b1: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 404}),
				b2: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 405}),
				b3: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 406}),
				b5: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 410}),
				b6: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 415}),
				b12: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 418}),
				folate: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 417}),
				a: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 318}),
				c: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 401}),
				d: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 324}),
				e: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 323}),
				k: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 430}),
				calcium: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 301}),
				iron: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 303}),
				magnesium: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 304}),
				phosphorus: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 305}),
				potassium: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 306}),
				sodium: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 307}),
				zinc: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 309}),
				copper: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 312}),
				fluoride: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 313}),
				manganese: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 315}),
				selenium: food_data_help(response["foods"][0]["full_nutrients"].select{|nutrient| nutrient["attr_id"] == 317})
			}

			return food_data
    	
    end

end
