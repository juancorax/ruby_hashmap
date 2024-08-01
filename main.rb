require_relative 'lib/hashmap'
require_relative 'lib/hashset'

hashmap = HashMap.new

hashmap.set('apple', 'red')
hashmap.set('banana', 'yellow')
hashmap.set('carrot', 'orange')
hashmap.set('dog', 'brown')
hashmap.set('elephant', 'gray')
hashmap.set('frog', 'green')
hashmap.set('grape', 'purple')
hashmap.set('hat', 'black')
hashmap.set('ice cream', 'white')
hashmap.set('jacket', 'blue')
hashmap.set('kite', 'pink')
hashmap.set('lion', 'golden')

hashmap.set('moon', 'silver')

p hashmap.length
p hashmap.entries
p hashmap.buckets.length
puts hashmap

hashset = HashSet.new

hashset.set('apple')
hashset.set('banana')
hashset.set('carrot')
hashset.set('dog')
hashset.set('elephant')
hashset.set('frog')
hashset.set('grape')
hashset.set('hat')
hashset.set('ice cream')
hashset.set('jacket')
hashset.set('kite')
hashset.set('lion')

hashset.set('moon')

p hashset.length
p hashset.keys
p hashset.buckets.length
puts hashset
