require 'ruby2d'
class Graphics
    TILE = 20
    BANNER_HEIGHT = 2
    COLORS = {
        -1 => 'red',
        1 => 'blue',
        2 => 'olive',
        3 => 'maroon',
        4 => 'navy',
        5 => 'brown',
        6 => 'black',
        7 => 'black',
        8 => 'black'
    }
    def initialize(size, bomb_count)
        last = size * TILE
        offset = TILE * BANNER_HEIGHT
        @size = size
        @flags = {}        
        size.times do |coord|
            x_pos = coord * TILE
            y_pos = (coord + BANNER_HEIGHT) * TILE
            Line.new(x1: 0, y1: y_pos, x2: last, y2: y_pos, width: 1, color: 'black', z: 1)
            Line.new(x1: x_pos, y1: offset, x2: x_pos, y2: last + offset, width: 1, color: 'black', z: 1)
        end
     
        Window.set(height:last + offset, width: last, background: 'silver')

        @bomb_count = Text.new(bomb_count, x: TILE / 2, y: TILE / 2, size: TILE, color: 'red', z: 3)
        @timer = Text.new(0, x: (size * TILE) - TILE * 2, y: TILE / 2, size: TILE, color: 'red', z: 3)
    end


    

    def reveal(tiles)
        tiles.each do |tile|
            y = (tile[:y] + 2) * TILE
            Square.new( x: tile[:x] * TILE, y: y, size: TILE, color: 'gray', z: 2)
            if (tile[:val] != 0)
                text = tile[:val] != -1 ? tile[:val] : 'X'
                color = COLORS[tile[:val]]
                Text.new(text, x: tile[:x] * TILE + 4, y: y - 2, size: TILE, color: color, z: 3)
            end
        end 
    end

    def show
        Window.show
    end

    def toggle_flag(x, y)
        if @flags[[x, y]]
            @flags[[x,y]].remove
            @flags[[x,y]] = nil
            @bomb_count.text = @bomb_count.text.to_i + 1
        else
            offset_y = (y + 2)
            @flags[[x,y]] = Text.new('P', x: x * TILE + 4, y: offset_y * TILE - 2, size: TILE, color: 'red', z: 3)
            @bomb_count.text = @bomb_count.text.to_i - 1
        end
    end

    def lose 
        Text.new('You Lose', x:@size  , y: (@size * TILE / 2) - @size * 4, size: @size* 4, color: 'red', z: 4)
    end

    def win 
        Text.new('You Win', x:@size  , y: (@size * TILE / 2) - @size * 4, size: @size* 4, color: 'red', z: 4)
    end

    def update_time(sec)
        time = sec.to_s
        time = '999' if sec > 999
        time = '0' + time if time.length <= 1
        time = '0' + time if time.length <= 2 
        @timer.text = time
    end

end
