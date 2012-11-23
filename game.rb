require 'chingu'

class Game < Chingu::Window

	#constructor
	def initialize
		super
		self.input = {esc: :exit}
		@player = Player.create
	end
end

class Player < Chingu::GameObject

	#meta-constructor
	def setup
		@x, @y = 750, 400
		@image = Gosu::Image["ship.png"]
		self.input = {
			holding_left: :left,
			holding_right: :right,
			holding_up: :up,
			holding_down: :down
		}
	end

	def left
		unless @x - 28 <= 0
			@x -= 1
		end
	end

	def right
		unless @x + 28 >= 800
			@x += 1
		end
	end

	def up 
		unless @y - 28 <= 0
			@y -= 1
		end
	end

	def down
		unless @y + 28 >= 600
			@y += 1
		end
	end
end

Game.new.show