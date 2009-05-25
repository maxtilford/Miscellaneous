/*
	Max Tilford
	maxtilford@gmail.com
	Amazing Union-Find
	assn: 21-6
	04/20/09
	Maze.java
	Implements a Maze class.
	Tested
*/


import java.util.Arrays;
import java.util.Collections;


// The Maze class builds a maze using a union-find data-structure
// A maze can turn itself into a string.
class Maze {
	
	int width;
	int size;
	int[] rooms;
	Wall[] walls;


	// Build our Maze
	Maze(int n) {
		width = n;
		size = n * n;
	

		// get all our walls together
		Wall[] walls = getWalls();


		// mix up the walls, so we don't end up with
		// a boring maze
		Collections.shuffle(Arrays.asList(walls));


		// initialize our rooms (each surrounded by walls)
		rooms = new int[size];
		Arrays.fill(rooms, 15);


		// demolish left wall of the first room
		rooms[0] -= 4; 


		// demolish right wall of the last room
		rooms[rooms.length-1] -= 1; 


		// keep track of what rooms have been unioned into the maze
		UnionFind mergedRooms = new UnionFind(size);


		// break down walls until we run out of walls or
		// all the rooms are connected
		for (Wall w : walls) {
			if (mergedRooms.union(w.left, w.right)) {
				breakWall(w.left, w.right);
			}
		}
	}


	// Tear down this Wall!
	private void breakWall(int i, int j) {
		if (j - i == 1) { // if they are horizontally adjacent
			rooms[i] -= 1;  // tear down right wall
			rooms[j] -= 4;  // tear down left wall
		}
		else {           // if they are vertically adjacent
			rooms[i] -= 2; // tear down bottom wall
			rooms[j] -= 8; // tear down top wall
		}
	}
	 
	
	private Wall[] getWalls() {
		
		// the number of inner walls in an n by n maze
		// is 2n^2 - 2n
		walls = new Wall[2*size-2*width]; 
		int wallIndex = 0;

		// collect walls which vertically separate rooms
		for (int i = 0; i < size - width; i++) {
			walls[wallIndex] = new Wall(i, i + width);
			wallIndex++;
		}

		// collect walls which horizontally separate rooms
		for (int i = 0; i < size - 1; i++) {
			if ((i + 1) % width != 0) {
				walls[wallIndex] = new Wall(i,i+1);
				wallIndex++;
			}
		}
		return walls;
	}


	// build a string out of the rooms array
	public String toString() {
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < rooms.length; i++) {
			sb.append(Integer.toHexString(rooms[i]).toUpperCase());
			
			// add a newline for rectangular formatting
			if ((1 + i) % width == 0) {
				sb.append("\n");
			}
		}
		return sb.toString(); 
	}

	// Wall is a small data class that represents a wall
	// holds the indices of the rooms it separates
	class Wall {
		public int left; // or top
		public int right; // or bottom
		
		Wall(int l, int r) {
			left = l;
			right = r;
		}
		
	}

}