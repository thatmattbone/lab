from __future__ import print_function

TRIANGLE = [[75,],
            [95, 64],
            [17, 47, 82],
            [18, 35, 87, 10],
            [20,  4, 82, 47, 65],
            [19,  1, 23, 75,  3, 34],
            [88,  2, 77, 73,  7, 63, 67],
            [99, 65,  4, 28,  6, 16, 70, 92],
            [41, 41, 26, 56, 83, 40, 80, 70, 33],
            [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
            [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
            [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
            [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
            [63, 66,  4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
            [04, 62, 98, 27, 23,  9, 70, 98, 73, 93, 38, 53, 60,  4, 23]]

I = 0

class Node(object):
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right


    def path_sums(self):
        global I
        I += 1
        if self.left is None and self.right is None:
            return self.value
        else:
            return self.value + max(self.left.path_sums(), self.right.path_sums())


def build_node_structure(triangle):
    new_triangle = []
    for row in triangle:
        new_triangle.append([Node(value) for value in row])

    for i, row in enumerate(new_triangle):
        for j, node in enumerate(row):
            print(i, j)
            if i + 1 < len(new_triangle):
                node.left = new_triangle[i + 1][j]
                node.right = new_triangle[i + 1][j + 1]

    return new_triangle

if __name__ == "__main__":
    nodes = build_node_structure(TRIANGLE)
    root = nodes[0][0]

    print(root.path_sums())

    print(I)
    
