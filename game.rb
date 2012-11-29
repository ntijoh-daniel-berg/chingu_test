require 'chingu'

class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		Background.create
		@player = Player.create
		5.times { Asteroid.create}
	end

	def update
		super
		Laser.each_bounding_circle_collision(Asteroid) do |laser, target|
      		laser.destroy
      		target.destroy
    	end
	end
end

class Player < Chingu::GameObject

	#meta-constructor
	def setup
		@x, @y = 750, 400
		@image = Gosu::Image["ship.png"]
		@speed = 4
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down,
			holding_space: :fire
		}
	end

	def left
		unless @x - 28 <= 0
			@x -= @speed
		end
	end

	def right
		unless @x + 28 >= 800
			@x += @speed
		end
	end

	def up 
		unless @y - 28 <= 0
			@y -= @speed
		end
	end

	def down
		unless @y + 28 >= 600
			@y += @speed
		end
	end

	def fire
		Laser.create(x: self.x, y: self.y)
	end
end

class Laser < Chingu::GameObject
	has_traits :velocity, :collision_detection, :bounding_circle, :timer

	def setup
		@image = Gosu::Image["laser.png"]
		self.velocity_y = -10
		Gosu::Sound["pew-pew.wav"].play
		after(300) do
			self.destroy
		end
	end
end

class Background < Chingu::GameObject

	def setup
		@x, @y = 400,300
		@image = Gosu::Image["paper.jpg"]
	end

end

class Asteroid < Chingu::GameObject
	has_traits :collision_detection, :bounding_circle, :velocity

	def setup
		@x = rand(800)
		@y = 100
		@rotation = rand()
		@velocity_y = rand()
		@velocity_x = rand()
		@image = Gosu::Image["asteroid#{rand(4)}.png"]
	end

	def update
		super
		@angle += @rotation
	end

end

Game.new.show