require "gosu"
require "./lib/game"
require "./lib/board"
require "./lib/player"

BOARD_LEN = 8
CELL_SIZE = 64
WIDTH, HEIGHT = 640, 480

class Reversi < (Example rescue Gosu::Window)
  def initialize
    super BOARD_LEN * CELL_SIZE, BOARD_LEN * CELL_SIZE

    @cell_image  = Gosu::Image.new("media/cell.png")
    @black_image = Gosu::Image.new("media/black.png")
    @white_image = Gosu::Image.new("media/white.png")

    @board = Board.new(BOARD_LEN)
    player1 = Player.new(@board, Cell::BLACK)
    player2 = Player.new(@board, Cell::WHITE)
    @game = Game.new(@board, player1, player2)
  end

  def update
  end

  def draw
    @board.board.each.with_index do |line, y|
      line.each.with_index do |cell, x|
        if cell == Cell::BLACK
          @black_image.draw(x * CELL_SIZE, y * CELL_SIZE, 0)
        elsif cell == Cell::WHITE
          @white_image.draw(x * CELL_SIZE, y * CELL_SIZE, 0)
        else
          @cell_image.draw(x * CELL_SIZE, y * CELL_SIZE, 0)
        end
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      x = (mouse_x / CELL_SIZE).floor
      y = (mouse_y / CELL_SIZE).floor
      @game.notify(x, y)
    end
  end
end