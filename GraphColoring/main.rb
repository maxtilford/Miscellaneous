#!/usr/bin/ruby

# Goal: Given a graph, make the maximum number of nodes black, where
#       black nodes cannot be adjacent.

# Conversely, we are trying to minimize the number of white nodes.

# Statement: Black nodes cause white nodes.

# So if we chose black nodes by choosing nodes with the lowest 
# degree (lowest number of neighbors) first, we force the least 
# amount of nodes to be white.

# Intuitively, this would seem to maximize the number of black nodes.

# I don't know how to prove this formally, but it seems to work. Obviously I
# need to study graph theory more.


# given an array of nodes and an adjacency list, return a maximal array of
# black nodes
def black_nodes(nodes, adjacency_list)
  blacks = []
  
  while nodes != []
    
    # get the node with the lowest degree
    black = nodes.min do |n,m| 
      adjacency_list[n-1].length <=> adjacency_list[m-1].length
    end

    # delete the node and the node's neighbors from the list of possible
    # black nodes
    nodes -= adjacency_list[black-1] << black

    # delete the node's neighbors from all the other neighbors
    # this removes the blackened node and it's neighbors from the graph
    adjacency_list.map! {|l| l - adjacency_list[black-1] }

    # add the blackened node to the list of black nodes
    blacks << black
  end

  blacks.sort 
end


num_graphs = gets.to_i

num_graphs.times do

  num_nodes, num_edges = gets.split.map{|s| s.to_i}

  # initialize an adjacency list from the edges given
  adjacency_list = Array.new(num_nodes,[])
  num_edges.times do
    u, v = gets.split.map{|s| s.to_i}
    adjacency_list[u-1] += [v] # Ruby arrays are 0-indexed
    adjacency_list[v-1] += [u]
  end
  
  blacks = black_nodes((1..num_nodes).to_a, adjacency_list)
 
  puts blacks.length, blacks.join(" ")
end




