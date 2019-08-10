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
            case event.button
            when :left
                tiles =  @board.on_click(x_tile, y_tile)
                @graphics.reveal(tiles)
            when :right
                @board.toggle_flag(x_tile, y_tile)
                @graphics.toggle_flag(x_tile, y_tile)
            end
        end
        @graphics.show
    end
end

MineSweeper.new

