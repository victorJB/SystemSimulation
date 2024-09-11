class Node
    attr_reader :id, :log, :state

    def initialize(id)
        @id = id
        @neighbors = []
        @log = []
        @state = nil
    end

    def add_neighbor(node)
        @neighbors << node
        add_log("Added neighbor #{node.id}")
    end

    def add_log(message)
        @log << message
    end

    def retrieve_log
        @log
    end
end

node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)
node1.add_neighbor(node2)
node1.add_neighbor(node3)
node2.add_neighbor(node1)
node2.add_neighbor(node3)
node3.add_neighbor(node1)
node3.add_neighbor(node2)
puts node1.retrieve_log
puts node2.retrieve_log
puts node3.retrieve_log