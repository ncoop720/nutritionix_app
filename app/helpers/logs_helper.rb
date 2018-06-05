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
    
end
