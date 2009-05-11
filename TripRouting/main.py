#!/usr/bin/python

# I believe that this would count as my very first Python program.
# Given that, I've probably missed some idioms. Corrections are welcome.

# Overall I'd say I like Python. The syntax is nice and clear, if a
# bit verbose at times. I did miss the rich list and enumerable functions
# that I'm used to in Haskell and Ruby, but I probably just need more practice.

import sys

# I question whether this class is really necessary, except to make some names
# nicer. I suppose I feel guilty programming in an object-oriented language and
# not making any objects
class Route:
    def __init__(self,a,b,road,distance):
        self.a = a
        self.b = b
        self.road = road
        self.distance = distance
        
    def __str__(self):
        return " ".join([self.a.ljust(20),
                         self.b.ljust(20),
                         self.road.ljust(10),
                         repr(self.distance).rjust(5)])


# Dijkstra's shortest path algorithm
# routes is a dict with city names as keys and a list of the roads leading out of it
# source and destination are both city names
def shortest_path(routes, source, destination):
     # initialize all cities with a distance of infinite from the source
    distance = dict().fromkeys(routes.keys(),float('inf'))
    
    # the trail is how we're going to keep track of what cities we've checked
    trail = dict()

    distance[source] = 0 # the source city is 0 miles away from itself.

    cities = routes.keys() # I'm just using a list. For better performance use a heap.

    while cities != []:

        current_city = min(cities, key = distance.get)
        cities.remove(current_city)

        # if we've reached our destination, trace back through the trail and return
        if current_city == destination:
            r = trail[destination]
            rs = [r]
            while r.a in trail:
                rs.append(trail[r.a])
                r = trail[r.a]
            rs.reverse()
            return rs

        # for each route coming out of the current city, check if it will result in
        # a shorter distance for it's target city.
        # if it does, set the distance for the target city to be the distance already
        # traveled plus the route's distance
        # else, leave as is
        for route in routes[current_city]:
            dist = distance[route.a] + route.distance
            if dist < distance[route.b]:
                distance[route.b] = dist
                trail[route.b] = route



lines = sys.stdin.readlines()
split = lines.index("\n")  # find where the routes end and the trips begin
edges = lines[:split]
trips = lines[split+1:]


graph = {} # build an adjaceny list
for edge in edges:
    a,b,road,distance = edge.split(",")
    graph.setdefault(a,[]).append(Route(a, b, road, int(distance)))
    graph.setdefault(b,[]).append(Route(b, a, road, int(distance)))

# find and print out each trip
for trip in trips:
    source, destination = trip.rstrip().split(",")
    total = 0

    print "\n\n" # there should be two newlines before each trip"
    print "From                 To                   Route      Miles"
    print "-------------------- -------------------- ---------- -----"

    for leg in shortest_path(graph,source,destination): # find the shortest path
        total += leg.distance
        print leg

    print "                                                     -----"
    print "                                          Total      " + repr(total).rjust(5)
    


