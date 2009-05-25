/*
	Max Tilford
	maxtilford@gmail.com
	Amazing Union-Find
	assn: 21-6
	04/20/09
	Main.java
	Interacts with a user and a maze;
	Tested
*/

import java.util.Scanner;

// Get an int n from input
// build an n by n maze with it
// output the maze
class Main {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int n = sc.nextInt();

	 	Maze maze = new Maze(n);

		System.out.print(maze);
	}
}