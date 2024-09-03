<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<style>
div[class~="block"] {
  width: 15px;
  height: 15px;
  position: absolute;
}
.black {
  background-color: black;
}
.white {
  background-color: white;
}
.red {
  background-color: red;
  z-index: 2;
}
.blue {
  background-color: blue;
}
#maze {
  width: 345px;
  height: 345px;
}
.left {
  left: 15px;
}
.right {
  right: 15px;
}</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<div id="maze" style="display: block;"></div>

<button id="btn">무작위 미로 생성</button>
<script>
$(document).ready(function () {
	  var wall = "-1",
	    start = "0",
	    end = "1",
	    empty = "2";
	  var maze;
	  var mazeSize = 10;

	  function setMaze(size) {
	    var maze,
	      visited,
	      i,
	      j,
	      width = size * 2 + 3,
	      height = size * 2 + 3;
	    maze = new Array(height);
	    visited = new Array(height);
	    for (i = 0; i < height; i++) {
	      maze[i] = new Array(width);
	      visited[i] = new Array(width);
	    }
	    for (i = 0; i < height; i++) {
	      for (j = 0; j < width; j++) {
	        maze[i][j] = wall;
	        visited[i][j] = false;
	      }
	    }
	    // 시작점 좌표 (1,1)
	    DFS(maze, visited, 1, 1);
	    return maze;
	  }

	  function DFS(maze, visited, y, x) {
	    maze[y][x] = start;
	    visited[y][x] = true;
	    subDFS(maze, visited, y, x);
	    // 끝점 좌표는 미로의 최우하단
	    maze[maze.length - 2][maze.length - 2] = end;
	  }

	  function subDFS(maze, visited, y, x) {
	    var temp = new Array(4),
	      i,
	      num,
	      size = maze.length;
	    var dx = [-2, 2, 0, 0],
	      dy = [0, 0, -2, 2],
	      wx = [-1, 1, 0, 0],
	      wy = [0, 0, -1, 1];
	    for (i = 0; i < 4; i++) {
	      num = Math.floor(Math.random() * 4);
	      if (temp.indexOf(num) == -1) {
	        temp[i] = num;
	      } else {
	        i--;
	      }
	    }
	    for (i = 0; i < 4; i++) {
	      if (
	        y + dy[temp[i]] >= 1 &&
	        y + dy[temp[i]] < size - 1 &&
	        x + dx[temp[i]] >= 1 &&
	        x + dx[temp[i]] < size - 1 &&
	        visited[y + dy[temp[i]]][x + dx[temp[i]]] == false
	      ) {
	        maze[y + dy[temp[i]]][x + dx[temp[i]]] = empty;
	        maze[y + wy[temp[i]]][x + wx[temp[i]]] = empty;
	        visited[y + dy[temp[i]]][x + dx[temp[i]]] = true;
	        visited[y + wy[temp[i]]][x + wx[temp[i]]] = true;
	        subDFS(maze, visited, y + dy[temp[i]], x + dx[temp[i]]);
	      }
	    }
	  }

	  function printMaze(maze) {
	    $("div[id='maze']").empty();
	    for (i = 0; i < maze.length; i++) {
	      for (j = 0; j < maze.length; j++) {
	        if (maze[i][j] == "-1") {
	          $("div[id='maze']").append(
	            "<div class ='block black obstacle' style = 'top : " +
	              15 * i +
	              "px; left : " +
	              15 * j +
	              "px;'></div>"
	          );
	        } else if (maze[i][j] == "0") {
	          $("div[id='maze']").append(
	            "<div class ='block red' style = 'top : " +
	              15 * i +
	              "px; left : " +
	              15 * j +
	              "px; z-index: 10;'></div>"
	          );
	        } else if (maze[i][j] == "1") {
	          $("div[id='maze']").append(
	            "<div class ='block blue' style = 'top : " +
	              15 * i +
	              "px; left : " +
	              15 * j +
	              "px;'></div>"
	          );
	        } else {
	          $("div[id='maze']").append(
	            "<div class ='block white' style = 'top : " +
	              15 * i +
	              "px; left : " +
	              15 * j +
	              "px; background-color: rgba(255, 255, 255, 0.5);'></div>"
	          );
	        }
	      }
	    }
	  }

	  function resetMaze() {
	    maze = setMaze(mazeSize);
	    printMaze(maze);
	  }

	  $("button#btn").on("click", function () {
	    maze = setMaze(mazeSize);
	    printMaze(maze);
	  });

	  $("button#resetBtn").on("click", function () {
	    resetMaze();
	  });

	  document.addEventListener("keydown", function (e) {
	    const redDiv = document.querySelector(".red");
	    if (!redDiv) return; // redDiv가 없을 경우 무시

	    let currentLeft = parseInt(window.getComputedStyle(redDiv).left);
	    let currentTop = parseInt(window.getComputedStyle(redDiv).top);
	    let nextLeft = currentLeft;
	    let nextTop = currentTop;

	    const blockSize = 15;
	    const mazeX = currentLeft / blockSize;
	    const mazeY = currentTop / blockSize;

	    if (e.keyCode === 37) {
	      // 왼쪽으로 이동
	      nextLeft = currentLeft - blockSize;
	    } else if (e.keyCode === 39) {
	      // 오른쪽으로 이동
	      nextLeft = currentLeft + blockSize;
	    } else if (e.keyCode === 38) {
	      // 위쪽으로 이동
	      nextTop = currentTop - blockSize;
	    } else if (e.keyCode === 40) {
	      // 아래쪽으로 이동
	      nextTop = currentTop + blockSize;
	    }

	    const nextMazeX = nextLeft / blockSize;
	    const nextMazeY = nextTop / blockSize;

	    // 배열 범위 내인지 확인하고, 이동하려는 위치가 벽 또는 장애물이 아닌지 확인
	    const nextElement = document.elementFromPoint(
	      nextLeft + blockSize / 2,
	      nextTop + blockSize / 2
	    );
	    if (
	      nextMazeX >= 0 &&
	      nextMazeX < maze[0].length &&
	      nextMazeY >= 0 &&
	      nextMazeY < maze.length &&
	      maze[nextMazeY][nextMazeX] !== parseInt(wall) &&
	      !(nextElement && nextElement.classList.contains("obstacle"))
	    ) {
	      redDiv.style.left = nextLeft + "px";
	      redDiv.style.top = nextTop + "px";
	    }
	  });

	  // 초기 상태로 설정
	  resetMaze();
	});
</script>
</body>
</html>