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
  
  def initialize
    @loadfactor = 0.8
    @capacity = 16
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

    #check here for possible increase of the capacity

    if @buckets[h_key].nil?
      ll = LinkedList.new
      ll.append(kv_pair)
      @buckets[h_key] = ll
    else
      @buckets[h_key].append(kv_pair)
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
            return current_node.value.value
          end
          current_node = current_node.next_node
        end
      end
    end
    nil
  end

  def length
    length = 0
    for i in 0..@buckets.size - 1 do
      list = @buckets[i]
      if !list.nil?
        if !list.head.nil?
          current_node = list.head
          for j in 0..list.size - 1 do
            length += 1
            current_node = current_node.next_node
          end
        end
      end
    end
    length
  end

  def clear
    @buckets.clear
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