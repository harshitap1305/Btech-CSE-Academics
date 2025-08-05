#include<iostream>
using namespace std;
class Node{
public:
int data;
int height;
Node* left;
Node* right;
Node(int v)
{
    this->data=v;
    this->left=NULL;
    this->right=NULL;
    this->height=1;
}
};
class AVL{
public:
Node* root;
AVL()
{
    this->root=NULL;
}
int height(Node* root)
{
    if(root==NULL)
    {return 0;}
    return root->height;
}
int getBalance(Node* root)
{ 
    if(root==NULL)
     {return 0;}
    return height(root->left)-height(root->right);
}
Node* leftRotation(Node* root)
{
    Node* child=root->right;
    Node* childLeft=child->left;
    child->left=root;
    root->right=childLeft;
    root->height=1+max(height(root->left),height(root->right));
    child->height=1+max(height(child->left),height(child->right));
    return child;
}

Node* rightRotation(Node* root)
{
     Node* child=root->left;
     Node* childRight=child->right;
     child->right=root;
     root->left=childRight;
root->height=1+max(height(root->left),height(root->right));
    child->height=1+max(height(child->left),height(child->right));
    return child;

}
Node* insert(Node* root, int key)
{
     if(root==NULL)
    {return new Node(key);}
    if(key < root->data)
    {
        root->left=insert(root->left,key);
    }
    else if(key > root->data)
    {
        root->right=insert(root->right, key);
    }
    else{
        return root;
    }
    root->height=1+max(height(root->left),height(root->right));
    int balance=getBalance(root);
    if(balance>1 &&  key < root->left->data)
    {
      return rightRotation(root);
    }
    if(balance <-1 && key > root->right->data)
    {
       return leftRotation(root);
    }
    if(balance >1 && key> root->left->data)
    {
         root->left=leftRotation(root->left);
         return rightRotation(root);
    }
    if(balance<-1 && key< root->right->data)
    {
         root->right=rightRotation(root->right);
         return leftRotation(root);
    }
    return root;
    }
};
int main()
{
    return 0;
}