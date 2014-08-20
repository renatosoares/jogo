class Timer
	def initialize(window, tubarao, subinimigo, mergulhador)
		@subinimigo = subinimigo
		@tubarao = tubarao
		@mergulhador = mergulhador
		@window = window
		@start_time = Time.now
		@every_n_seconds = 5
		@last_recorded_seconds = 0
	end
	
	def update
		if (add_inimigos?) then
			@tubarao << Tubarao.new(@window)

			@subinimigo << SubInimigo.new(@window) 
		end
		@mergulhador << Mergulhador.new(@window)
	end
	
	def seconds
		(Time.now-@start_time).to_i
	end

	
	def add_inimigos?
		if seconds != @last_recorded_seconds and seconds % @every_n_seconds == 0
			@last_recorded_seconds = seconds
			true
		else
			false
		end
	end
	
end