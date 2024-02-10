class Player
  def initialize(board, color)
    @board = board
    @color = color
  end

  def is_cpu?
    false
  end

  def put_stone(x, y)
    puts "Player.put_stone(#{x}, #{y})"
    if @board.try_put(x, y, @color) 
      return @board.put_stone(x, y, @color)
    end
    false
  end
end