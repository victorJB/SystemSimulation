class Node
    attr_reader :id, :log, :state

    def initialize(id)
        @id = id
        @neighbors = []
        @state = nil
        @proposal_value = 0
        @promised_value = 0
        @accepted_value = 0
        @log = []
        @accepted_state = nil
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

    def propose_state(state)
        @proposal_value = state
        add_log("Proposed state #{state}")
        majority_accept = []
    
        @neighbors.each do |neighbor|
          if neighbor.prepare(@proposal_value)
            majority_accept << neighbor
          end
        end
    
        if majority_accept.size >= (@neighbors.size / 2.0).ceil
            add_log("Node #{@id} accepted by majority")
          majority_accept.each do |neighbor|
            neighbor.accept(@proposal_number, state)
          end
          accept_state(state)
        else
            add_log("Node #{@id} no accepted")
        end
    end

    def prepare(proposal_number)
        if proposal_number < @promised_value
          @promised_value = proposal_number
          add_log("Proposal accepted #{proposal_number}.")
          true
        else
          add_log("Proposal rejected #{proposal_number}.")
          false
        end
    end

    def accept(proposal_number, state)
        p proposal_number
        p @promised_value
        if proposal_number >= @promised_value
            @accepted_value = proposal_number
            @accepted_value = state
            log_state("State accepted #{state}")
        end
    end

    def simulate_partition(nodes)
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
node1.propose_state(1)
puts node1.retrieve_log
puts node2.retrieve_log
puts node3.retrieve_log