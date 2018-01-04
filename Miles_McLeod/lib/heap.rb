require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    if prc
      @prc = prc
    else
      @prc = Proc.new { |x, y| x > y ? 1 : -1 }
    end
  end

  def count
    @store.length
  end

  def extract
    return @store.pop if @store.length == 1
    temp = @store[0]
    @store[0] = @store[-1]
    @store[-1] = temp
    return_val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    return_val
  end

  def peek
    @store[0]
  end

  def push(val)
    # debugger
    @store.push(val)
    child_idx = @store.length - 1
    BinaryMinHeap.heapify_up(@store, child_idx)
  end

  def self.child_indices(len, parent_index)
    left = (2 * parent_index) + 1
    right = left + 1
    if left == len - 1
      return [left]
    else
      return [left, right]
    end
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    return array if len == 1
    prc ||= Proc.new { |x, y| x > y ? 1 : -1 }
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    if child_indices.length == 1
      child_idx = child_indices[0]
    elsif prc.call(array[child_indices[0]], array[child_indices[1]]) == 1
      child_idx = child_indices[1]
    else
      child_idx = child_indices[0]
    end
    while prc.call(array[parent_idx], array[child_idx]) == 1 && array[child_idx]
      temp = array[parent_idx]
      array[parent_idx] = array[child_idx]
      array[child_idx] = temp
      parent_idx = child_idx
      child_indices = BinaryMinHeap.child_indices(len, parent_idx)
      break if !array[child_indices[0]]
      if child_indices.length == 1
        child_idx = child_indices[0]
      elsif prc.call(array[child_indices[0]], array[child_indices[1]]) == 1
        child_idx = child_indices[1]
      else
        child_idx = child_indices[0]
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if len == 1
    prc ||= Proc.new { |x, y| x > y ? 1 : -1 }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    while prc.call(array[parent_idx], array[child_idx]) == 1 && child_idx != 0
      temp = array[parent_idx]
      array[parent_idx] = array[child_idx]
      array[child_idx] = temp
      child_idx = parent_idx
      break if child_idx == 0
      parent_idx = BinaryMinHeap.parent_index(child_idx)
    end
    array
  end
end

# (2n + 1), (2n + 2) => left child, right child
