require "minitest/autorun"
# require "minitest/unit"
require "board"

class TestMeme < Minitest::Test
  def setup
    @meme = Meme.new
    @board = Board.new(4)
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", "OHAI!"
  end
end