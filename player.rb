class Player
	attr_reader :lives, :x, :y, :laser, :direcao
	def initialize(window)
		@window = window
		@icon = Gosu::Image.new(@window, "subyellow.png", true)
		@x = 100
		@y = window.height - 200
		@explosion = Gosu::Image.new(@window, "explosion.png", true)
		@exploded = false
		@lives = 3
		@laser = Laser.new(self, @window)
		@direcao = 1
	end
	def update
		if @window.button_down? Gosu::Button::KbLeft
			move_left
			@direcao=-1
		end
		if @window.button_down? Gosu::Button::KbRight
			move_right
			@direcao=1
		end
		if @window.button_down? Gosu::Button::KbDown
			move_down
		end
		if @window.button_down? Gosu::Button::KbUp
			move_up
		end
		if @window.button_down? Gosu::Button::KbSpace
			@laser.shoot(@x, @y, @direcao)
		end
		@laser.update
	end
	def move_right
		@x = @x + 10
		if @x > @window.width-50
			@x = @window.width-50
		end
	end
	def move_left
		@x = @x - 10
		if @x < 0
			@x = 0
		end
	end
	def move_down
		@y = @y + 10
		if @y > 350
			@y = 350
		end
	end
	def move_up
		@y = @y - 10
		if @y < 120
			@y = 120
		end
	end
	def draw
		if @exploded
			@explosion.draw(@x, @y, 4)
		else
			@icon.draw(@x, @y, 2, @direcao)
			@laser.draw
		end
	end
	def hit_by?(bullets)
		@exploded = bullets.any? {|bullet| Gosu::distance(bullet.x, bullet.y, @x, @y) < 20}
		if @exploded
			@lives = @lives - 1
		end
		@exploded
	end
	def reset_position
		@x = rand(@window.width)
	end
end
