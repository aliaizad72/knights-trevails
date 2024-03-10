# frozen_string_literal: true

require 'matrix'

# Contains the relationship between each 'box' with it's appropriate move
class KnightMoves
  attr_reader :vertices, :edges

  def initialize
    @vertices = create_vertices
    @edges = create_edges
  end

  def create_vertices
    arr = []
    8.times do |row|
      8.times do |column|
        arr.push(Vector[row, column])
      end
    end
    arr
  end

  def create_edges
  end

  def all_movements
    movements = []
    [1, 2, -1, -2].permutation(2) do |perm|
      movements.push(Vector.elements(perm)) if perm.map(&:abs).sum == 3
    end
    movements
  end
end
knight = KnightMoves.new
vertices = knight.vertices
movements = knight.all_movements.map { |v| v + vertices[24] }
movements = movements.filter do |vectors|
  vectors.all? { |v| v >= 0 && v < 8 }
end
p movements
