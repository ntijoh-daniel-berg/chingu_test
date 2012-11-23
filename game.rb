require 'chingu'

class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		@player = Player.create
		@targets = []
		5.times { @targets << Target.create}
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
			space: :fire
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
	has_traits :velocity

	def setup
		@image = Gosu::Image["laser.png"]
		self.velocity_y = -10
	end
end

class Target < Chingu::GameObject

	def setup
		@x = rand(800)
		@y = 100
		@image = Gosu::Image["target.png"]
	end
end

Game.new.show