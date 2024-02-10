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

  def show
    @board.each do |line|
      line.each do |cell|
        case cell
        when Cell::NONE
          print '. '
        when Cell::BLACK
          print 'X '
        when Cell::WHITE
          print 'O '
        end
      end
      puts ""
    end
  end

  def is_inside?(x, y)
    return false if x < 0 || @size <= x
    return false if y < 0 || @size <= y
    true
  end

  def try_put_line(x, y, dx, dy, color)
    next_x = x + dx
    next_y = y + dy
    return false if !is_inside?(next_x, next_y)
    return false if @board[next_y][next_x] != Cell.other(color)

    loop do
      next_x += dx
      next_y += dy
      return false if !is_inside?(next_x, next_y)
      return false if @board[next_y][next_x] == Cell::NONE
      return true if @board[next_y][next_x] == color
    end

    false
  end

  def put_line!(x, y, dx, dy, color)
    next_x = x + dx
    next_y = y + dy
    loop do
      self.put_stone(next_x, next_y, color)
      next_x += dx
      next_y += dy
      return if !self.is_inside?(next_x, next_y)
      return if @board[next_y][next_x] == color
    end
  end

  def try_put(x, y, color)
    puts "tring to (#{x}, #{y}, #{@board[y][x]}): #{color} ..."
    return false if @board[y][x] != Cell::NONE

    lines = [
      [-1, -1], [0, -1], [1, -1],
      [-1, 0], [1, 0],
      [-1, 1], [0, 1], [1, 1],
    ].select { |dx, dy| try_put_line(x, y, dx, dy, color) }

    puts "lines: #{lines}"

    return false if lines.empty?

    lines.each { |dx, dy| put_line!(x, y, dx, dy, color)}
    true
  end

  def put_stone(x, y, color)
    @board[y][x] = color
  end
end