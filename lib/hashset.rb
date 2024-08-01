require_relative 'linkedlist'

class HashSet
  def initialize(buckets_size = 16, load_factor = 0.75)
    @buckets = Array.new(buckets_size)
    @length = 0
    @load_factor = load_factor
  end

  attr_accessor :buckets, :length
  attr_reader :load_factor

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def grow_buckets
    keys_array = keys
    self.buckets = Array.new(buckets.length * 2)
    self.length = 0

    keys_array.each do |key|
      set(key)
    end
  end

  def set(key)
    bucket = hash(key) % buckets.length

    if buckets[bucket].nil?
      buckets[bucket] = LinkedList.new
    else
      current_node = buckets[bucket].head

      until current_node.nil?
        return if current_node.key == key

        current_node = current_node.next_node
      end
    end

    buckets[bucket].append(key)
    self.length += 1

    grow_buckets if self.length > (buckets.length * load_factor)
  end

  def has?(key)
    bucket = hash(key) % buckets.length

    return false if buckets[bucket].nil?

    current_node = buckets[bucket].head

    until current_node.nil?
      return true if current_node.key == key

      current_node = current_node.next_node
    end

    false
  end

  def remove(key)
    bucket = hash(key) % buckets.length

    return nil if buckets[bucket].nil?

    previous_node = nil
    current_node = buckets[bucket].head

    until current_node.nil?
      if current_node.key == key
        previous_node.next_node = current_node.next_node
        self.length -= 1
        return current_node.key
      end

      previous_node = current_node
      current_node = current_node.next_node
    end

    nil
  end

  def clear
    self.buckets = Array.new(16)
  end

  def keys
    keys_array = []

    buckets.each do |bucket|
      next if bucket.nil?

      current_node = bucket.head

      until current_node.nil?
        keys_array << current_node.key

        current_node = current_node.next_node
      end
    end

    keys_array
  end

  def to_s
    string_representation = '[ '

    buckets.each do |bucket|
      if bucket.nil?
        string_representation += 'nil, '
        next
      end

      current_node = bucket.head

      until current_node.nil?
        string_representation += "( #{current_node.key} ) -> "
        string_representation += 'nil, ' if current_node.next_node.nil?

        current_node = current_node.next_node
      end
    end

    string_representation[-2] = ''
    "#{string_representation}]"
  end
end
