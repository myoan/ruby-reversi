require "./lib/game"

class Board
  attr_reader :board

  def initialize(size)
    raise "invalid size" if size % 2 != 0
    @size = size
    @board = Array.new(size) { Array.new(size) { Cell::NONE }}

    put_stone(size/2-1, size/2-1, Cell::BLACK)
    put_stone(size/2,   size/2,   Cell::BLACK)
    put_stone(size/2-1, size/2,   Cell::WHITE)
    put_stone(size/2,   size/2-1, Cell::WHITE)
  end

  def score
    black = 0
    white = 0
    @board.each do |line|
      line.each do |cell|
        black += 1 if cell == Cell::BLACK
        white += 1 if cell == Cell::WHITE
      end
    end
    return black, white
  end

  def filled?
    @board.all? { |line| line.none? { |cell| cell == Cell::NONE }}
  end

  def try_put(x, y, color, dry_run=false)
    # TODO: implement method
    true
  end

  def puttable?(color)
    # TODO: implement method
    true
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

  def put_stone(x, y, color)
    puts "put_stone (#{x}, #{y}) -> #{color}"
    @board[y][x] = color
  end

  def get_stone(x, y)
    @board[y][x]
  end
end