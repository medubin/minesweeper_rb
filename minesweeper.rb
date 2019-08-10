require_relative './board'
require_relative './graphics'
require 'ruby2d'

class MineSweeper
    def initialize
        size = 20
        @board = Board.new(size, 20)
        @graphics = Graphics.new(size)
        Window.on :mouse_down do |event|
            x_tile =  event.x / Graphics::TILE
            y_tile =  event.y / Graphics::TILE
            puts "#{x_tile}, #{y_tile}"
            tiles =  @board.on_click(x_tile, y_tile)
            @graphics.reveal(tiles)
        end
        @graphics.show
    end
end

MineSweeper.new

