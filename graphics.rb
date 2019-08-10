require 'ruby2d'
class Graphics
    TILE = 20
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
    def initialize(size)
        last = size * TILE
        @size = size
        @flags = {}
        size.times do |coord|
            pos = coord * TILE
            Line.new(x1: 0, y1: pos, x2: last, y2: pos, width: 1, color: 'black', z: 1)
            Line.new(x1: pos, y1: 0, x2: pos, y2: last, width: 1, color: 'black', z: 1)
        end
     
        Window.set(height:size*TILE , width: size*TILE, background: 'silver')
        
    end

    def reveal(tiles)
        tiles.each do |tile|
            Square.new( x: tile[:x] * TILE, y: tile[:y] * TILE, size: TILE, color: 'gray', z: 2)
            if (tile[:val] != 0)
                text = tile[:val] != -1 ? tile[:val] : 'X'
                color = COLORS[tile[:val]]
                Text.new(text, x: tile[:x] * TILE + 4, y: tile[:y] * TILE - 2, size: TILE, color: color, z: 3)
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
        else
            @flags[[x,y]] = Text.new('P', x: x * TILE + 4, y: y * TILE - 2, size: TILE, color: 'red', z: 3)
        end
    end

    def lose 
        Text.new('You Lose', x:@size  , y: (@size * TILE / 2) - @size * 4, size: @size* 4, color: 'red', z: 4)
    end

    def win 
        Text.new('You Win', x:@size  , y: (@size * TILE / 2) - @size * 4, size: @size* 4, color: 'red', z: 4)
    end
end
