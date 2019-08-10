require_relative './tile'
require 'set'
# 0 - 8: number of bombs
# -1: a bomb
class Board
    def initialize size, bomb_count
        @grid = Array.new(size) { Array.new(size) {Tile.new(0)} }
        while bomb_count > 0
            x,y = rand(size), rand(size)
            if @grid[y][x].val != -1
                @grid[y][x].val = -1
                bomb_count -= 1
                [-1, 0, 1].each do |y_p|
                    [-1, 0, 1].each do |x_p|
                        new_y = y + y_p
                        new_x = x + x_p
                        next if out_of_bounds?(new_x, new_y)
                        next if @grid[new_y][new_x].val == -1
                        @grid[new_y][new_x].val += 1
                    end
                end
            end
        end

        render()
    end

    def on_click(x, y)
        return [] if !@grid[y][x].hidden

        seen = Set.new
        revealed = []
        to_process = [ {tile: @grid[y][x], x: x, y: y} ]

        while !to_process.empty?
            processing = to_process.shift
            coords = [processing[:x], processing[:y]]
            next if seen.include?(coords)
            seen << [processing[:x], processing[:y]]
            tile = processing[:tile]
            next if !tile.hidden
            tile.hidden = false
            revealed << { x: processing[:x], y: processing[:y], val:tile.val }
            next if tile.val != 0
            [-1, 0, 1].each do |y_p|
                [-1, 0, 1].each do |x_p|
                    x = processing[:x] + x_p
                    y = processing[:y] + y_p
                    next if out_of_bounds?(x, y)
                    to_process << {tile: @grid[y][x], x: x, y: y} 
                end
            end
        end
        return revealed
    end


    def render
        @grid.each do |row|
            row.each do |el|
                print (el == -1) ? ' x ' : " #{el.val} "
            end
            puts
        end
    end


    private

    def out_of_bounds?(x, y)
        size = @grid.length
         return y < 0 || y >= size || x < 0 || x >= size
    end


        # def [](x, y)
        #     @grid[y][x]
        # end

        # def []= (x, y, val)
        #     @grid[x,y] = val 
        # end

end