#include<iostream>
using namespace std;
class Node{
public:
int data;
Node *left;
Node *right;
Node(int v){
    this -> data =v;
    this -> left= NULL;
    this -> right = NULL;
}
};
class BST{
public: 
Node* root;
BST()
{
    this -> root=NULL;
}
Node* insertBST(Node* nodeV,int val)
{
    if(nodeV == NULL)
    {
        return new Node(val);
    }
    if(val<nodeV->data)
    {
        nodeV->left = insertBST(nodeV->left, val);
    }
    else 
    {
        nodeV->right = insertBST(nodeV->right, val);
    }
    return nodeV;
}
void insert(int v)
{
    root=insertBST(root,v);
}

Node* minimum(Node* root)
{
    if(root==NULL)
    {return NULL;}
    if(root->left==NULL)
    {return root;}
    return minimum(root->left);
}
Node* maximum(Node* root)
{
    if(root==NULL)
    {return NULL;}
    if(root->right==NULL)
    {return root;}
    return maximum(root->right);
}
void PreOrder(Node *node)//first parent--then--right child--then left child
{
    if(node==NULL)
    {return; }
    cout<<node->data<<" ";
    PreOrder(node->left);
    PreOrder(node->right);
}
void PostOrder(Node* node) //left child--right child--parent node
{
   if(node==NULL)
   {return; }
   PostOrder(node->left);
   PostOrder(node->right);
   cout<<node->data<<" ";
}
void InOrder(Node *node) //left child--parent node--right child
{
   if(node==NULL)
   {return ;}
   InOrder(node->left);
   cout<<node->data<<" ";
   InOrder(node->right);
}
Node* insertInBST(Node* node, int val)
{
    if(node==NULL)
    {return new Node(val);}
    if(node->data==val)
    {return node;}
    if(node->data < val)
    {
        node->right=insertInBST(node->right,val);
    }
    else 
    {
        node->left=insertInBST(node->left,val);
    }
    return node;
}
Node* DeleteInBST(Node* root ,int val)
{ 
        if(root) 
            if(val < root->data)
            { 
                root->left = DeleteInBST(root->left,val); 
             }  
            else if(val> root->data) 
            {
                root->right = DeleteInBST(root->right,val);  
            }     
            else{
                if(!root->left && !root->right) 
                {return NULL;  }        
                if (!root->left || !root->right)
                    return root->left ? root->left : root->right;   
					                                                
                Node* temp = root->left;                      
                while(temp->right != NULL) 
                {temp = temp->right;     }
                root->data = temp->data;                           
                root->left = DeleteInBST(root->left, temp->data); 		
            }
        return root;
  
}
Node* leftest(Node *node){
    Node* temp = node;
    while (temp->left !=NULL) 
        temp=temp->left;
    return temp;  
}
Node* Successor(Node* root,int key)
{
    if(root==NULL)
    { return NULL; }
    Node* successor=NULL;
    Node* current=root;
    while(current!=NULL)
    {   if(key<current->data){
        successor=current;
        current=current->left;}
        else if(key>current->data)
        {
            current = current->right;
        }
        else {
            if (current->right != NULL) {
                return leftest(current->right);
            }
            break;}
    }
   return successor;
}
int Height(Node* node)
{
  if(node==NULL)
  {
    return 0;
  } 
  int leftheight=Height(node->left);
  int rightheight=Height(node->right);
  return max(leftheight,rightheight)+1;  
}
};
int main()
{
    BST b;
   //creating a Binary search tree;
    b.insert(5);
    b.insert(4);
    b.insert(1);
    b.insert(12);
    b.insert(17);
    b.insert(20);
    b.insert(10);
   // (a) Find the minimum element
   Node* min= b.minimum(b.root);
   cout<<"the minimum element is:"<<min->data;
   cout<<endl;
   //(b) Find the maximum element
   Node* max= b.maximum(b.root);
   cout<<"the maximum element is:"<<max->data;
   cout<<endl;
   //(c) Preorder traversal
   cout<<"the preorder traversal is:"<<endl;
   b.PreOrder(b.root);
   cout<<endl;
   //(d) Postorder traversal
   cout<<"the post order traversal is"<<endl;
   b.PostOrder(b.root);
   cout<<endl;
    //(e) Inorder traversal
    cout<<"the In order traversal of binary search tree is"<<endl;
    b.InOrder(b.root);
    cout<<endl;
    //(f) Insert an element
    b.insertInBST(b.root,16);
    cout<<"the In order traversal of binary search tree after inserting 16 is:"<<endl;
    b.InOrder(b.root);
    //(h) Find the successor of an element
   cout<<"the successor of 17 is:";
   Node* succ=b.Successor(b.root,17);
   cout<<succ->data;
   cout<<endl;
   //(i) Find the height of the BST.
   int height= b.Height(b.root);
   cout<<"the height of binary search tree is: "<<height<<endl;
   //g) delele an element
   cout<<"binary tree after deleting the element 12 is:"<<endl;
   b.DeleteInBST(b.root,12);
   b.InOrder(b.root);
    
    return 0;
}