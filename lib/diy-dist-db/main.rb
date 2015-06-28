require_relative 'dist_db'
require_relative 'thing'

node_urls = ['http://localhost:8080',
             'http://localhost:8081',
             'http://localhost:8082']
DistDB.write(node_urls, 3, 2, Thing.new(3, 'foo'))
DistDB.write(node_urls, 3, 2, Thing.new(7, 'bar'))
thing_3 = DistDB.read(node_urls, 3)
thing_7 = DistDB.read(node_urls, 7)
puts thing_3
puts thing_7
