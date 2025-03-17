require_relative '../linkedList/linkedList.rb'

class KeyValuePair

  attr_reader :key, :value
  attr_writer :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def to_array
    [@key, @value]
  end

end

class HashMap
  
  attr_accessor :load_factor
  attr_reader :length

  def initialize
    @load_factor = 0.8
    @capacity = 16
    @length = 0
    @buckets = Array.new(@capacity)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code % @capacity
  end

  def set(key, value)
    h_key = hash(key)
    kv_pair = KeyValuePair.new(key, value)

    @length += 1

    self.adjust_capacity

    if @buckets[h_key].nil?
      ll = LinkedList.new
      ll.append(kv_pair)
      @buckets[h_key] = ll
    else
      @buckets[h_key].append(kv_pair)
    end
  end

  def adjust_capacity
    if self.length >= @capacity * @load_factor
      @capacity *= 2
      data = self.entries
      self.clear

      for i in 0..data.length - 1
        pair = data[i]
        self.set(pair[0], pair[1])
      end
    end
  end

  def get(key)
    list = @buckets[hash(key)]
    if !list.nil?
       if !list.head.nil?
        current_node = list.head
        for j in 1..list.size do
          if current_node.value.key == key
            return current_node.value.value
          end
          current_node = current_node.next_node
        end
      end
    end
    nil
  end

  def has?(key)
    if self.get(key).nil?
      false
    else
      true
    end
  end

  def remove(key)
    list = @buckets[hash(key)]
    if !list.nil?
       if !list.head.nil?
        current_node = list.head
        for j in 0..list.size - 1 do
          if current_node.value.key == key
            list.remove_at(j)
            @length -= 1
            return current_node.value.value
          end
          current_node = current_node.next_node
        end
      end
    end
    nil
  end

  def clear
    @buckets.clear
    @length = 0
  end

  def keys
    keys = Array.new
    for i in 0..@buckets.size - 1 do
      list = @buckets[i]
      if !list.nil?
        if !list.head.nil?
          current_node = list.head
          for j in 0..list.size - 1 do
            keys.push(current_node.value.key)
            current_node = current_node.next_node
          end
        end
      end
    end
    keys
  end
  
  def values
    values = Array.new
    for i in 0..@buckets.size - 1 do
      list = @buckets[i]
      if !list.nil?
        if !list.head.nil?
          current_node = list.head
          for j in 0..list.size - 1 do
            values.push(current_node.value.value)
            current_node = current_node.next_node
          end
        end
      end
    end
    values
  end

  def entries
    entries = Array.new
    for i in 0..@buckets.size - 1 do
      list = @buckets[i]
      if !list.nil?
        if !list.head.nil?
          current_node = list.head
          for j in 0..list.size - 1 do
            entries.push(current_node.value.to_array)
            current_node = current_node.next_node
          end
        end
      end
    end
    entries
  end

end