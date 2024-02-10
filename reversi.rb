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
    @mouse_x = 0
    @mouse_y = 0

    @board = Board.new(BOARD_LEN)
    player1 = Player.new(@board, Cell::BLACK)
    player2 = Player.new(@board, Cell::WHITE)
    @game = Game.new(@board, player1, player2)
  end

  def update
    return if @game.finished?

    player = @game.active_player
    color = @game.active_player_color

    if !@board.puttable?(color)
      puts "#{color} not puttable"
      @game.turn_change
      return
    end

    if player.is_cpu? || Gosu.button_down?(Gosu::MsLeft)
      player.put_stone(@mouse_x / CELL_SIZE, @mouse_y / CELL_SIZE)
      if @game.finished?
        @game.calc_winner
        if @game.winner == :black
          puts "black win"
        elsif @game.winner == :white
          puts "black win"
        else
          puts "draw"
        end
        return
      end
      @game.turn_change
    end
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
      @mouse_x, @mouse_y = [mouse_x, mouse_y]
      puts "(#{@mouse_x}, #{@mouse_y})"
    end
  end
end