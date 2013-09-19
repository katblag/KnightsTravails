require 'TreeNode'

class KnightPathFinder
  def initialize(starting_position)
    @starting_position = starting_position
    build_move_tree
  end

  def find_path(target_pos)
    test = @move_tree[@starting_position].bfs(target_pos) { |node| node if node.value == target_pos }
    values = test.path.reverse!
    values.each{ |val| p val }
  end

  def self.new_move_positions(pos)
    i,j = pos
    new_moves = [[i+1, j+2], [i+1, j-2], [i-1, j+2], [i-1, j-2],
                 [i+2, j+1], [i+2, j-1], [i-2, j+1], [i-2, j-1]]

    new_moves.select { |move| move[0].between?(0, 7) && move[1].between?(0, 7)}
  end
  
  private
  def build_move_tree
    @move_tree = { @starting_position => TreeNode.new(@starting_position) }
    move_from = [@starting_position]

    until move_from.empty?
      current_position = move_from.shift
      
      new_moves = KnightPathFinder.new_move_positions(current_position)
      new_moves.each do |move|
        unless @move_tree.keys.include?(move)
          new_node = TreeNode.new(move)
          @move_tree.merge!( { move => new_node } )
          new_node.parent = @move_tree[current_position]
          move_from << move
        end
      end
    end
  end
end
