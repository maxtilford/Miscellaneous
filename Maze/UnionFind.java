/*
	Max Tilford
	maxtilford@gmail.com
	Amazing Union-Find
	assn: 21-6
	04/20/09
	UnionFind.java
	Implements a UnionFind data-structure.
	Tested
*/


// This class implements a Union-Find data-structure
// using a disjoint set forest.
// It makes use the 'union by rank' and 'path compression'
// heuristics.
class UnionFind {
	Tree[] forest;

	// build the initial forest
	// each tree initially points to itself as it's parent
	UnionFind(int size) {
		forest = new Tree[size];
		for (int i = 0; i < forest.length; i++) {
			forest[i] = new Tree(i);
		}
	}

	// If x and y are in different sets, link their sets
	// and return true.
	// Else, return false.
	public Boolean union(int x, int y) {
		int xRoot = find(x);
		int yRoot = find(y);
		
		if (xRoot != yRoot) {
			link(xRoot, yRoot);
			return true;
		}
		else {
			return false;
		}
	}

	// helper function for union.
	// merges together two sets according to their rank
	// adjusts rank if necessary
	private void link(int x, int y) {
		Tree a = forest[x];
		Tree b = forest[y];
		if (a.rank > b.rank) {
			b.parent = x;
		}
		else if (a.rank < b.rank) {
			a.parent = y;
		}
		else { 
			a.parent = y;
			b.rank++;
		}
	}

	// find the representative of this element's set
	// if this x is itself the representative, just return it
	// else, return the representative, and compress the path
	// so that it won't take as long next time
	public int find(int x) {
		
		if (forest[x].parent != x) {
			forest[x].parent = find(forest[x].parent);
		}
	
		return forest[x].parent;
	
	}
	
	// Tree is a small data-structure that holds a parent
	// and a rank.
	class Tree {
		public int parent;
		public int rank;
		
		Tree(int p) {
			parent = p;
			rank = 0;
		}
	}
}

