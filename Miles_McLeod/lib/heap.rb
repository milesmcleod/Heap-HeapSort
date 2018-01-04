class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
  end

  def extract
    temp = @store[0]
    @store[0] = @store[-1]
    @store[-1] = temp
    return_val = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length, @prc)
    return_val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    child_idx = @store.length - 1
    BinaryMinHeap.heapify_up(@store, child_idx, @store.length, @prc)
  end

  def self.child_indices(len, parent_index)
    left = (2 * parent_index) + 1
    right = left + 1
    [left, right]
  end

  def self.parent_index(child_index)
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    while array[parent_idx] > array[child_idx] && child_idx != parent_idx
      temp = array[parent_idx]
      array[parent_idx] = array[child_idx]
      array[child_idx] = temp
      child_idx = parent_idx
      parent_idx = BinaryMinHeap.parent_index(child_idx)
    end
  end
end

# (2n + 1), (2n + 2) => left child, right child
