#include <iostream>
#include <algorithm>
//height of every node in the avl tree
using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;
    int height;

    Node(int val) {
        data = val;
        left = right = NULL;
        height = 1;
    }
};

class AVLTree {
public:
    Node* root;

    AVLTree() 
    {
        root=NULL;
    }

    int height(Node* node) {
        if (node==NULL)
           { return 0;}

        return node->height;
    }

    int getBalance(Node* node) {
        if (node == nullptr) return 0;
        return height(node->left) - height(node->right);
    }

    Node* rightRotate(Node* y) {
        Node* x = y->left;
        Node* T2 = x->right;
        x->right = y;
        y->left = T2;
        y->height = max(height(y->left), height(y->right)) + 1;
        x->height = max(height(x->left), height(x->right)) + 1;
        return x;
    }

    Node* leftRotate(Node* x) {
        Node* y = x->right;
        Node* T2 = y->left;
        y->left = x;
        x->right = T2;
        x->height = max(height(x->left), height(x->right)) + 1;
        y->height = max(height(y->left), height(y->right)) + 1;
        return y;
    }

    Node* insert(Node* node, int data) {
        if (node == nullptr)
            return new Node(data);
        if (data < node->data)
            node->left = insert(node->left, data);
        else if (data > node->data)
            node->right = insert(node->right, data);
        else
            return node;
        node->height = 1 + max(height(node->left), height(node->right));
        int balance = getBalance(node);
        if (balance > 1 && data < node->left->data)
            return rightRotate(node);
        if (balance < -1 && data > node->right->data)
            return leftRotate(node);
        if (balance > 1 && data > node->left->data) {
            node->left = leftRotate(node->left);
            return rightRotate(node);
        }
        if (balance < -1 && data < node->right->data) {
            node->right = rightRotate(node->right);
            return leftRotate(node);
        }
        return node;
    }
    void insert(int data) {
        root = insert(root, data);
    }
    void printHeights(Node* node) {
        if (node == nullptr)
            return;
        printHeights(node->left);
        cout << "Node " << node->data << " has height: " << node->height << endl;
        printHeights(node->right);
    }
    void printHeights() {
        printHeights(root);
    }
};
int main() {
    AVLTree tree;
    int n;
    cout<<"enter total no. of nodes";
    cin>>n;
    int x;
    for (int i=0;i<n;i++)
    {
        cin>>x;
        tree.insert(x);
    }
    tree.printHeights();

    return 0;
}
