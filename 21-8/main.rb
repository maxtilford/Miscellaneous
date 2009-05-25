#!/usr/bin/ruby

def neighbors(graph,v)
  ns = []
  walls = graph[v.first][v.last]
  ns << [v.first + 1, v.last] if 1 & walls == 0
  ns << [v.first, v.last + 1] if 2 & walls == 0
  ns << [v.first - 1, v.last] if 4 & walls == 0
  ns << [v.first, v.last - 1] if 8 & walls == 0
  ns
end

def print_path(graph,v)
  path = []
  while v
    path << "(%d, %d)" % v
    v = graph[v.first][v.last]
  end
  puts path.join(" ")
end


maze = readlines.map {|line| line.chomp.split("").map {|c| c.to_i(16) }}.transpose


maze[0][0] += 4
maze[-1][-1] += 1

path = Array.new(maze.size) {Array.new(maze.size)}


path[-1][-1]= false

queue = []


queue << [maze.size-1,maze.size-1]

until queue.empty?

  v = queue.shift
  neighbors(maze,v).each do |n|
    if path[n.first][n.last].nil?

      path[n.first][n.last] = v

      queue << n
    end
    
  end
end

print_path(path,[0,0])
