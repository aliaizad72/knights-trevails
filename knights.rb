# frozen_string_literal: true

require 'matrix'

# class Vertex that for each vertex that contains some important attr for BFS
class Vertex
  attr_accessor :value, :color, :distance, :pi

  def initialize(value)
    @value = value
    @color = 'white'
    @distance = nil # distance in the BFS tree from the root
    @pi = nil # attr whether the vertex in the BFS tree has a predecessor
  end
end

# Contains the relationship between each 'box' with it's appropriate move
class KnightGraph
  attr_reader :vertices, :edge_map

  def initialize
    @vertices = create_vertices
    @edge_map = create_edge_map
  end

  def create_vertices
    arr = []
    8.times do |row|
      8.times do |column|
        arr.push(Vertex.new([row, column]))
      end
    end
    arr
  end

  def create_edge_map
    hashmap = {}
    @vertices.each do |vertex|
      hashmap[vertex] = edges(vertex.value).map { |coor| search(coor) }
    end
    hashmap
  end

  def search(coordinates)
    @vertices.find { |vertex| vertex.value == coordinates }
  end

  def edges(coordinates)
    edges = []
    max_moves.each do |move|
      edge = []
      edge[0] = move[0] + coordinates[0]
      edge[1] = move[1] + coordinates[1]

      next if edge[0].negative? || edge[1].negative? || edge[0] > 7 || edge[1] > 7

      edges.push(edge)
    end
    edges
  end

  def max_moves
    moves = []
    [1, 2, -1, -2].permutation(2) do |perm|
      moves.push(perm) if perm.map(&:abs).sum == 3
    end
    moves
  end
end

def bfs(graph, source)
  source.color = 'grey'
  source.distance = 0
  source.pi = nil

  queue = []
  queue.push(source)
  i = 0

  until queue.empty?
    dequeued = queue.shift
    arr = graph.edge_map[dequeued]
    arr.each do |vertex|
      next if vertex.color != 'white'

      vertex.color = 'grey'
      vertex.distance = dequeued.distance + 1
      vertex.pi = dequeued
      queue.push(vertex)
    end
    dequeued.color = 'black'
    i += 1
  end
end

def print_path(graph, source, finish, output = '')
  if finish == source
    output += "Knight moves from: #{source.value} "
  else
    print_path(graph, source, finish.pi, output)
    output += "-> #{finish.value} "
  end
  print output
end

def knight_moves(start, finish)
  knight_graph = KnightGraph.new
  start = knight_graph.search(start)
  finish = knight_graph.search(finish)

  bfs(knight_graph, start)
  print_path(knight_graph, start, finish)
end

knight_moves([7, 7], [3, 3])
