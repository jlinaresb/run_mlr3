# Tuners
# ======

gridSearch = function(){
	
	tuner = tnr("grid_search", resolution = 50)
	return(tuner)

}

nonLinearSearch = function(){

	tuner = tnr("nloptr")
	return(tuner)

}

randomSearch = function(){

	tuner = tnr("random_search")
	return(tuner)
	
}