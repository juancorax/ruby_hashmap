require_relative 'node'

class LinkedList
  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  attr_accessor :size, :head, :tail

  def append(key, value = nil)
    new_node = Node.new
    new_node.key = key
    new_node.value = value

    if size.positive?
      tail.next_node = new_node
    else
      self.head = new_node
    end

    self.tail = new_node
    self.size += 1
  end
end
