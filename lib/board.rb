require "./lib/game"

class Board
  attr_reader :board

  def initialize(size)
    raise "invalid size" if size % 2 != 0
    @size = size
    @board = Array.new(size) { Array.new(size) { Cell::NONE }}

    @board[size / 2 - 1][size / 2 - 1] = Cell::BLACK
    @board[size / 2][size / 2]         = Cell::BLACK
    @board[size / 2 - 1][size / 2]     = Cell::WHITE
    @board[size / 2][size / 2 - 1]     = Cell::WHITE
  end

  def filled?
    @board.all? { |line| line.none? { |cell| cell == Cell::NONE }}
  end

  def puttable?(color)
    @board.each.with_index do |line, y|
      line.each.with_index do |cell, x|
        return true if self.try_put(x, y, cell)
      end
    end
    false
  end

  def try_put(x, y, color)
    true
  end

  def put_stone(x, y, color)
    @board[y][x] = color
  end
end

