require "minitest/autorun"
require "board"

class TestBoard < Minitest::Test
  def setup
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", "OHAI!"
  end
end

describe Board do
  before do
    @board = Board.new(4)
  end

  describe "Board.filled?" do
    describe "when board is not filled" do
      it "returns false" do
        _(@board.filled?).must_equal false
      end
    end

    describe "when board is filled" do
      before do
        @board.board.each.with_index do |line, y|
          line.each.with_index do |cell, x|
            @board.put_stone(x, y, Cell::BLACK)
          end
        end
      end

      it "returns true" do
        _(@board.filled?).must_equal true
      end
    end
  end
end