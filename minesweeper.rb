require_relative './board'
require_relative './graphics'
require 'ruby2d'
require 'date'

class MineSweeper
    def initialize(size, bomb_count)
        @playing = true
        @start_time = DateTime.now
        @board = Board.new(size, bomb_count)
        @graphics = Graphics.new(size, bomb_count)
        Window.on :mouse_down do |event|
            return if !@playing
            x_tile = event.x / Graphics::TILE
            y_tile = (event.y / Graphics::TILE) - Graphics::BANNER_HEIGHT
            next if y_tile < 0
            case event.button
            when :left
                tiles =  @board.on_click(x_tile, y_tile)
                @graphics.reveal(tiles)
                check_loss(tiles)
                check_win()
            when :right
                @flagged = @board.toggle_flag(x_tile, y_tile) 
                @graphics.toggle_flag(x_tile, y_tile)
            end
        end

        Window.update do
            now = DateTime.now
            interval = ((now - @start_time) * 24 * 60 * 60).to_i
            @graphics.update_time(interval)
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

MineSweeper.new 35, 90

