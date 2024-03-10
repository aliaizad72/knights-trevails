# frozen_string_literal: true

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
        coordinate = [row]
        coordinate.push(column)
        arr.push(coordinate)
      end
    end
    arr
  end

  def create_edges
  end
end

p KnightMoves.new.vertices.length
