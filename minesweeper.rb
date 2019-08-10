require_relative './board'
require_relative './graphics'
require 'ruby2d'

class MineSweeper
    def initialize
        @playing = true
        size = 35
        @board = Board.new(size, 90)
        @graphics = Graphics.new(size)
        Window.on :mouse_down do |event|
            return if !@playing
            x_tile =  event.x / Graphics::TILE
            y_tile =  event.y / Graphics::TILE
            case event.button
            when :left
                tiles =  @board.on_click(x_tile, y_tile)
                @graphics.reveal(tiles)
                check_loss(tiles)
                check_win()
            when :right
                @board.toggle_flag(x_tile, y_tile)
                @graphics.toggle_flag(x_tile, y_tile)
            end
        end
        @graphics.show
    end

    def check_loss tiles
        if tiles.length == 1 && tiles[0][:val] == -1
            @graphics.lose
            @playing = false
            tiles = @board.get_bombs
            @graphics.reveal(tiles)
        end
    end

    def check_win
        if @board.to_reveal == 0
            @graphics.win
            @playing = false
        end
    end
end

MineSweeper.new

