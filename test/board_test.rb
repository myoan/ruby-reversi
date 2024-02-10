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

  describe "Board.try_put_line" do
    describe "when next cell is not found" do
      it "returns false" do
        _(@board.try_put_line(0, 0, -1, 0, Cell::BLACK)).must_equal false
      end
    end

    describe "when next cell is empty" do
      it "returns false" do
        _(@board.try_put_line(0, 0, 1, 0, Cell::BLACK)).must_equal false
      end
    end

    describe "when next cell is same color" do
      it "returns false" do
        _(@board.try_put_line(3, 2, -1, 0, Cell::BLACK)).must_equal false
      end
    end

    describe "when next cell is other color" do
      describe "when same color not found in line" do
        it "returns false" do
          _(@board.try_put_line(3, 2, -1, -1, Cell::BLACK)).must_equal false
        end
      end

      describe "when same color found in line" do
        it "returns true" do
          _(@board.try_put_line(3, 1, -1, 0, Cell::BLACK)).must_equal true
        end
      end

      describe "when empty cell is found" do
        before do
          # X . O . <- put here
          # . . . .
          # . . . .
          # . . . .
          @board.put_stone(1, 1, Cell::NONE)
          @board.put_stone(1, 2, Cell::NONE)
          @board.put_stone(2, 1, Cell::NONE)
          @board.put_stone(2, 2, Cell::NONE)

          @board.put_stone(0, 0, Cell::BLACK)
          @board.put_stone(2, 0, Cell::WHITE)
        end

        it "returns false" do
          _(@board.try_put_line(3, 0, -1, 0, Cell::BLACK)).must_equal false
        end
      end
    end
  end
end