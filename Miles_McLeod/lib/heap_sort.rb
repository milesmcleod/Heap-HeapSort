require_relative "heap"
require 'byebug'

class Array
  def heap_sort!
    # debugger
    heap = BinaryMinHeap.new
    while !self.empty?
      heap.push(self.pop)
    end
    while heap.count > 0
      self.push(heap.extract)
    end
  end
end
