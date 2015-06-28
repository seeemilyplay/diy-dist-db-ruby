require_relative 'node'

module DistDB
    def DistDB.write(node_urls,
                     replication_factor,
                     write_consistency,
                     thing)
        results = node_urls.take(replication_factor).map { |node_url|
            begin
                Node.put_thing(node_url, thing)
                1
            rescue Exception
                0 
            end
        } 
        success_count = results.reduce(:+)
        if success_count < write_consistency
            raise "Only wrote to #{success_count} nodes"    
        end
    end

    def DistDB.read(node_urls, id)
        #todo: only works with one node, need to make distributed!
        Node.get_thing(node_urls[0], id)
    end
end

