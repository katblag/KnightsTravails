class TreeNode
  attr_reader :parent, :value, :children
  
  def initialize(value)
    @value = value
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def bfs(target = nil, &block)
    unless block_given?
      block = Proc.new { |node| p node.value == target }
    end

    possible_nodes = [self]
    
    until possible_nodes.empty?
      current_node = possible_nodes.shift
      return current_node if block.call(current_node)
      
      possible_nodes += current_node.children
    end

    nil
  end

  def dfs(target = nil, &block)
    unless block_given?
      block = Proc.new { |node| node.value == target }
    end

    return self if block.call(self)
    
    children.each do |child|
      if child
        found_node = child.dfs(target, &block)
        return found_node if found_node
      end
    end

    nil
  end
  
  def parent=(parent)
    @parent = parent
    parent.add_child(self)
  end
  
  def path
    path = []
    node = self.dup

    while true
      path << node.value
      break if node.parent.nil?
      node = node.parent
    end

    path
  end
end