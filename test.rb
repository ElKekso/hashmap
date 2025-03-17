require_relative 'hashmap.rb'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

test.set('apple', 'creamy')
puts(test.get('apple'))
puts(test.capacity)
puts(test.length)
test.set('elephant', 'cute')
puts(test.get('elephant'))
puts(test.capacity)
puts(test.length)

test.set('moon', 'silver')
puts(test.get('moon'))
puts(test.capacity)
puts(test.length)

test.remove('moon')
puts(test.get('moon'))