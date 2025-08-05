#include<iostream>
using namespace std;
class Node{
    public:
int data;
Node* left;
Node* right;
 Node(int v)
 {
    this->data=v;
    this->right=NULL;
    this->left=NULL;
 }
};
class BST
{
   public:
   Node* root;
   BST(){
    this->root=NULL;
   }
   int height(Node* root)
   {
    if(root==NULL)
    {return 0;}
    return 1+max(height(root->left),height(root->right));
   }
   bool isAVL(Node* root)
   {
    if(root==NULL)
    {
        return true;
    }
      int leftHeight=height(root->left);
      int rightHeight=height(root->right);
      if(abs(leftHeight-rightHeight)>1)
      {return false;}
      return isAVL(root->left) && isAVL(root->right);
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
    return root;
   }
};
int main()
{ 
    int n;
    cout<<"enter no. of node:";
    cin>>n;
    int x;
    cout<<"enter node values";
    class BST b;
    for(int i=0;i<n;i++)
    {
        cin>>x;
        b.root=b.insert(b.root,x);
        
    }
    if(b.isAVL(b.root))
    {
        cout<<"yes";
    }
    else{cout<<"NO";}
    return 0;
}