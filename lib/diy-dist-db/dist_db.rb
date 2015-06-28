require_relative 'node'

module DistDB
    def DistDB.write(node_urls, thing)
        #todo: only works with one node, need to make distributed!
        Node.put_thing(node_urls[0], thing)
    end

    def DistDB.read(node_urls, id)
        #todo: only works with one node, need to make distributed!
        Node.get_thing(node_urls[0], id)
    end
end

