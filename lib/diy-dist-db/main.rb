require_relative 'dist_db'
require_relative 'thing'

node_urls = ['http://localhost:8080']
DistDB.write(node_urls, Thing.new(3, 'foo'))
DistDB.write(node_urls, Thing.new(7, 'bar'))
thing_3 = DistDB.read(node_urls, 3)
thing_7 = DistDB.read(node_urls, 7)
puts thing_3
puts thing_7
