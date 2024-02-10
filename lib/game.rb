module Cell
  NONE  = 0
  BLACK = 1
  WHITE = 2
end

class Game
  attr_reader :winner, :active_player, :active_player_color

  def initialize(board, p1, p2)
    @board = board
    @p1 = p1
    @p2 = p2
    @winner = Cell::NONE
    @active_player = p1
    @active_player_color = Cell::BLACK
  end

  def finished?
    @board.filled?
  end

  def turn_change
    puts "turn_change"
    if @active_player_color == Cell::BLACK
      @active_player = @p2
      @active_player_color = Cell::WHITE
    else
      @active_player = @p1
      @active_player_color = Cell::BLACK
    end
  end

  def calc_winner
  end
end

