#include <iostream>
#include <algorithm>

using namespace std;

class Node {
public:
    int data;
    Node* left;
    Node* right;

    Node(int val) {
        data=val;
        left=NULL;
        right=NULL;
    }
};

class BST {
public:
    Node* root;
    BST() {
        root=NULL; }

    Node* insert(Node* node,int data) {
        if (node==NULL) {
            return new Node(data);
        }
        if (data < node->data) {
            node->left=insert(node->left, data);
        } else {
            node->right=insert(node->right, data);
        }
        return node;
    }

    int height(Node* node) {
        if (node==NULL) {
            return 0;
        }
        return 1+max(height(node->left), height(node->right));
    }

    bool isAVL(Node* node) {
        if (node==NULL) {
            return true;
        }

        int leftHeight=height(node->left);
        int rightHeight=height(node->right);

        if (abs(leftHeight-rightHeight)>1) {
            return false;
        }

        return isAVL(node->left) && isAVL(node->right);
    }

    void insert(int data) 
    {
        root=insert(root, data);
    }

    bool isAVL()
     {
        return isAVL(root);
    }
};

int main() {
    BST tree;
     int n;
    cout<<"enter total no. of nodes";
    cin>>n;
    int x;
    for (int i=0;i<n;i++)
    {
        cin>>x;
        tree.insert(x);
    }
    if(tree.isAVL()){
        cout<<"The tree is an AVL tree."<<endl;
    } else {
        cout<<"The tree is not an AVL tree."<<endl;
    }
    return 0;
}
