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

    def DistDB.read(node_urls,
                    replication_factor,
                    read_consistency,
                    id)
        things = []
        node_urls.take(replication_factor).each { |node_url|
            if things.length < read_consistency
                begin
                    things << Node.get_thing(node_url, id)
                rescue Exception
                    #ignore
                end
            end
        }
        if things.length < read_consistency
            raise "Only read from #{things.length} nodes"
        end
        things.max_by { |thing| thing.timestamp }
    end
end

