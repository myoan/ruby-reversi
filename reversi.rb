require "gosu"
require "./lib/game"
require "./lib/board"
require "./lib/player"

BOARD_LEN = 8
TEXT_HEIGHT = 32
CELL_SIZE = 64

class Reversi < (Example rescue Gosu::Window)
  def initialize
    super BOARD_LEN * CELL_SIZE, BOARD_LEN * CELL_SIZE + 2 * TEXT_HEIGHT

    @cell_image  = Gosu::Image.new("media/cell.png")
    @black_image = Gosu::Image.new("media/black.png")
    @white_image = Gosu::Image.new("media/white.png")

    @board = Board.new(BOARD_LEN)
    player1 = Player.new(@board, Cell::BLACK)
    player2 = Player.new(@board, Cell::WHITE)
    @game = Game.new(@board, player1, player2)
    @font = Gosu::Font.new(TEXT_HEIGHT)
  end

  def update
  end

  def draw
    if @game.finished?
      @font.draw_text("#{Cell.name(@game.winner)} win! (press ESC)", 0, BOARD_LEN * CELL_SIZE, 1, 1, 1, Gosu::Color::WHITE)
    else
      @font.draw_text("next: #{Cell.name(@game.active_player_color)}", 0, BOARD_LEN * CELL_SIZE, 1, 1, 1, Gosu::Color::WHITE)
    end
    b_score, w_score = @board.score
    @font.draw_text("Black: #{b_score}, White: #{w_score}", 0, BOARD_LEN * CELL_SIZE + TEXT_HEIGHT, 1, 1, 1, Gosu::Color::WHITE)
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
    when Gosu::KB_ESCAPE
      close
    end
  end
end