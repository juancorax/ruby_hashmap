require_relative 'linkedlist'

class HashMap
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
    entries_array = entries
    self.buckets = Array.new(buckets.length * 2)
    self.length = 0

    entries_array.each do |key_value_pair|
      key, value = key_value_pair

      set(key, value)
    end
  end

  def set(key, value)
    bucket = hash(key) % buckets.length

    if buckets[bucket].nil?
      buckets[bucket] = LinkedList.new
    else
      current_node = buckets[bucket].head

      until current_node.nil?
        if current_node.key == key
          current_node.value = value

          return
        end

        current_node = current_node.next_node
      end
    end

    buckets[bucket].append(key, value)
    self.length += 1

    grow_buckets if self.length > (buckets.length * load_factor)
  end

  def get(key)
    bucket = hash(key) % buckets.length

    return nil if buckets[bucket].nil?

    current_node = buckets[bucket].head

    until current_node.nil?
      return current_node.value if current_node.key == key

      current_node = current_node.next_node
    end

    nil
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
        return current_node.value
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

  def values
    values_array = []

    buckets.each do |bucket|
      next if bucket.nil?

      current_node = bucket.head

      until current_node.nil?
        values_array << current_node.value

        current_node = current_node.next_node
      end
    end

    values_array
  end

  def entries
    key_value_pairs = []

    buckets.each do |bucket|
      next if bucket.nil?

      current_node = bucket.head

      until current_node.nil?
        key_value_pairs << [current_node.key, current_node.value]

        current_node = current_node.next_node
      end
    end

    key_value_pairs
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
        string_representation += "( #{current_node.key}, #{current_node.value} ) -> "
        string_representation += 'nil, ' if current_node.next_node.nil?

        current_node = current_node.next_node
      end
    end

    string_representation[-2] = ''
    "#{string_representation}]"
  end
end
