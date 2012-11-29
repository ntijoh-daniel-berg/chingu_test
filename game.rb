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

	has_traits :velocity

	#meta-constructor
	def setup
		@x, @y = 750, 400
		@image = Gosu::Image["ship.png"]
		@velocity_x = 0
		@velocity_y = 0
		self.input = {
			holding_left: :turn_left,
			holding_right: :turn_right,
			holding_up: :accelerate,
			holding_space: :fire
		}
	end

	def turn_left
		@angle -= 4.5
	end

	def turn_right
		@angle += 4.5
	end

	def accelerate 
		@velocity_x += Gosu::offset_x(@angle, 0.5)
		@velocity_y += Gosu::offset_y(@angle, 0.5)
	end

	def update
		@velocity_x *= 0.95
		@velocity_y *= 0.95
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