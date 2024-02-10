module Cell
  NONE  = 0
  BLACK = 1
  WHITE = 2

  def other(color)
    case color
    when Cell::BLACK
      Cell::WHITE
    when Cell::WHITE
      Cell::BLACK
    when Cell::NONE
      Cell::NONE
    end
  end

  def name(color)
    case color
    when Cell::BLACK
      "Black"
    when Cell::WHITE
      "White"
    when Cell::NONE
      "None"
    end
  end

  module_function :other, :name
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
    puts "turn_change: #{@active_player_color}"
  end

  def calc_winner
  end

  def notify(x, y)
    putted = @active_player.put_stone(x, y)
    if finished?
      calc_winner
      if @winner == :black
        puts "black win"
      elsif @winner == :white
        puts "black win"
      else
        puts "draw"
      end
      return
    end

    return if !putted && @board.puttable?(@active_player_color)
    if @active_player_color == Cell::BLACK
      puts "BLACK: puts (#{x}, #{y})"
    else 
      puts "WHITE: puts (#{x}, #{y})"
    end
    @board.show
    if @board.puttable?(Cell.other(@active_player_color))
      turn_change
    end
  end
end

