class BinaryTree:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __unicode__(self):
        return '%s' % self.data


def recursive_dfs(tree):
    '''A recursive, eager, depth-first search traversal.'''
    nodes = []
    if(tree != None):
        nodes.append(tree.data)
        nodes.extend(recursive_dfs(tree.left))
        nodes.extend(recursive_dfs(tree.right))
    return nodes


def basic_dfs(tree):
    '''A basic, generator based, pre-order tree traversal.'''
    if(tree!=None):
        yield tree.data
        for node_data in basic_dfs(tree.left):
            yield node_data
        for node_data in basic_dfs(tree.right):
            yield node_data


def left_then_right(tree):
    '''Child node chooser function for pre-order tree traversal'''
    if(tree!=None):
        yield tree.left
        yield tree.right


def right_then_left(tree):
    '''Child node chooser function for post-order tree traversal'''
    if(tree!=None):
        yield tree.right
        yield tree.left


def dfs(tree, chooser=left_then_right):
    '''Generic depth first search function that can be customized 
    with child node chooser function.  Thus it can be used for
    pre and post order traversal.'''
    if(tree!=None):
        yield tree.data
        for immediate_child in chooser(tree):
            for node_data in dfs(immediate_child, chooser):
                yield node_data


def binary_search_chooser(value):
    '''Returns a dfs chooser function (a closure) for finding
    a particular value in a BST.  Note that the returned function
    will yield one and only one node.'''
    def binary_search_chooser_inner(tree):
        if(tree!=None and tree.data!=None):
            if(value<=tree.data):
                print 'Searching left...'
                yield tree.left
            else:
                print 'Searching right...'
                yield tree.right

    return binary_search_chooser_inner


def binary_search(tree, value):
    '''Search a binary search tree for a value.  Return
    the value if it is found. False otherwise.'''
    for i in dfs(tree, binary_search_chooser(value)):
        if(i == value):
            return i
    return False
    


if __name__ == '__main__':
    a = BinaryTree(1,
                   left = BinaryTree(2,
                                     left = BinaryTree(3)),
                   right = BinaryTree(4))
    print 'recursive dfs'
    for i in recursive_dfs(a):
        print i


    print 'basic dfs'
    for i in dfs(a):
        print i

    print 'left then right'
    for i in dfs(a):
        print i

    print 'right then left'
    for i in dfs(a, chooser=right_then_left):
        print i

    bst = BinaryTree(5,
                     left = BinaryTree(2,
                                       left = BinaryTree(1),
                                       right = BinaryTree(4)),
                     right = BinaryTree(7,
                                        left = BinaryTree(6),
                                        right = BinaryTree(9)))
    


    print 'binary search'
    print binary_search(bst, 9)
