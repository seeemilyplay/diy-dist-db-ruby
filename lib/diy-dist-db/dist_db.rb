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

    def DistDB.resolve(things)
        things.compact.max_by { |thing| thing.timestamp }
    end

    def DistDB.read_repair(node_urls,
                           replication_factor,
                           id)
        things = node_urls.take(replication_factor).map { |node_url|
            begin
                Node.get_thing(node_url, id)
            rescue Exception
                nil
            end
        }
        thing = resolve(things)
        things.each_with_index { |current_thing, index|
            # see if it's broken, and if it is fix it
            if !current_thing || current_thing.value != thing.value
                Node.put_thing(node_urls[index], thing)
            end
        }
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
        DistDB.read_repair(node_urls, replication_factor, id)
        DistDB.resolve(things)
    end
end

