class Tile
    attr_accessor :val, :hidden, :flag
    def initialize val
        @val = val
        @hidden = true
        @flag = false
    end
end