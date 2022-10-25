# frozen_string_literal: true

class LinkedLists
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @tail = new_node
    else
      new_node.get_next_node(@head)
    end
    @head = new_node
  end

  def append(value)
    new_node = Node.new(value)
    if @tail.nil?
      @head = new_node
    else
      @tail.get_next_node(new_node)
    end
    @tail = new_node
  end

  def size(node = @head, i = 0)
    if @head.nil?
      return 0
    elsif node.next_node.nil?
      i += 1
      return i
    end

    i += 1
    size(node.next_node, i)
  end

  def at(index = 0, i = 0, node = @head)
    if @head.nil?
      'List is empty'
    elsif node.next_node.nil? && i != index
      return 'Index not found'
    elsif i == index
      return node.value
    end

    at(index, i += 1, node.next_node)
  end

  def head
    @head.nil? ? nil : @head.value
  end

  def tail
    @tail.nil? ? nil : @tail.value
  end

  def pop(node = @head)
    if node.next_node.nil? && node == @head
      node.next_node = nil
      @tail = nil
      @head = nil
      return
    elsif node.next_node == @tail
      node.next_node = nil
      @tail = node
      return
    end
    pop(node.next_node)
  end

  def contains?(value, node = @head)
    found = false
    if node.next_node.nil? && node.value != value
      return nil
    elsif node.nil?
      return nil
    elsif node.value == value
      found = true
      return found
    end

    contains?(value, node.next_node)
  end

  def find(value, index = 0, node = @head)
    if node.next_node.nil? && node.value != value
      return nil
    elsif node.nil?
      return nil
    elsif node.value == value
      return index
    end

    find(value, index += 1, node.next_node)
  end

  def to_s(node = @head)
    return 'This list contains no items' if @head.nil?

    first_half = "(#{node.value}) -> "
    return "(#{node.value}) -> nil" if node.next_node.nil?

    second_half = to_s(node.next_node)
    "#{first_half}#{second_half}"
  end

  def insert_at(value, index, node = @head, i = 0)

    if @head.nil?
      prepend(value)
    elsif node.next_node.nil? && i != index
      append(value)
    elsif i == index - 1
      new_node = Node.new(value)
      new_node.next_node = node.next_node
      node.next_node = new_node
      return
    end
  insert_at(value, index, node.next_node, i += 1)
  end

  def remove_at(index, node = @head, i = 0)
    if self.size == 1
      @head = nil
      @tail = nil
      return
    elsif node.next_node.nil?
      self.pop
      return
    elsif i == index
      delete(node.next_node, index)
      return
    end

    remove_at(index, node.next_node, i += 1)
  end

  def delete(new_next, index, i = 0, node = @head)
    if i == index - 1
      node.next_node = new_next
      return
    end

    delete(new_next, index, i += 1, node.next_node)
  end
end

class Node  
  attr_accessor :value, :next_node

  def initialize(value)
    @value = get_value(value)
    @next_node = nil
  end

  def get_next_node(node)
    @next_node = node
  end

  def get_value(data)
    data
  end
end

list = LinkedLists.new
list.prepend('Stormy')
list.prepend('Dexter')
list.prepend('Sushi')
list.prepend('Pascal')
puts "List: #{list.to_s}"
puts "list size is #{list.size}"
puts "head is #{list.head}"
puts "tail is #{list.tail}"
puts list.at(1)
puts list.contains?('Dexter')
puts "Stormy is at index #{list.find('Stormy')}"
list.insert_at('Duncan', list.find('Stormy'))
puts list.to_s
list.insert_at('Maggie', 2)
puts list.to_s
list.remove_at(2)


