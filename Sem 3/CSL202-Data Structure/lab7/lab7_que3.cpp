#include <iostream>
using namespace std;
class Node {
public:
    int key;
    Node* left;
    Node* right;
    int height;

    Node(int k) {
    key=k; 
    this->left=NULL;
    this->right=NULL;
    height=1;
    }
};

class AVLTree {
private:
    int getHeight(Node* node) {
        return node ? node->height : 0;
    }

    int getBalance(Node* node) {
        return node ? getHeight(node->left) - getHeight(node->right) : 0;
    }
    Node* rotateRight(Node* root) {
        Node* child=root->left;
        Node* childRight=child->right;
        child->right=root;
        root->left=childRight;
        root->height=1+max(getHeight(root->left),getHeight(root->right));
        child->height=1+max(getHeight(child->left),getHeight(child->right));
        return child;

    }
    Node* rotateLeft(Node* root) {
        Node* child=root->right;
        Node* childLeft=child->left;
       child->left=root;
       root->right=childLeft;
       root->height=1++max(getHeight(root->left),getHeight(root->right));
        child->height=1+max(getHeight(child->left),getHeight(child->right));
        return child;
    }
    Node* insert(Node* node, int key) {
        if (!node) return new Node(key);
        if (key < node->key)
            node->left = insert(node->left, key);
        else if (key > node->key)
            node->right = insert(node->right, key);
        else
            return node;
        node->height = 1 + max(getHeight(node->left), getHeight(node->right));
        int balance = getBalance(node);
        if (balance > 1 && key < node->left->key)
            return rotateRight(node);
        if (balance < -1 && key > node->right->key)
            return rotateLeft(node);
        if (balance > 1 && key > node->left->key) {
            node->left = rotateLeft(node->left);
            return rotateRight(node);
        }
        if (balance < -1 && key < node->right->key) {
            node->right = rotateRight(node->right);
            return rotateLeft(node);
        }
        return node;
    }
    void inOrder(Node* root) {
        if (root != nullptr) {
            inOrder(root->left);
            cout << root->key << " ";
            inOrder(root->right);
        }
    }
public:
    Node* root;
   AVLTree()
    {this->root=NULL ;}

    void insert(int key) {
        root=insert(root, key);
    }

    void printInOrder() {
        inOrder(root);
        cout<<endl;
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
    int y;
    cout<<"enter a elemen:";
    cin>>y;
    tree.insert(y);
    cout << "In-order traversal of the constructed AVL tree is: ";
    tree.printInOrder();

    return 0;
}
