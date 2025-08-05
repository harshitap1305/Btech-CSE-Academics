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
    this->left=NULL;
    this->right=NULL;
}
};
class BST{
public:
Node* root;
BST()
{
    this->root=NULL;
}
Node* minimum(Node *root)
{
    if(root==NULL)
    {return root;}
    if(root->left==NULL)
    {return root;}
    return minimum(root->left);
}               
Node* maximum(Node* root)
{
    if(root==NULL)
    {
        return root;
    }
    if(root->right==NULL)
    {return root;}
    return maximum(root->right);
}
void PreOrder(Node* root)
{
    if(root==NULL)
    {return;}
    cout<<root->data<<" ";
    PreOrder(root->left);
    PreOrder(root->right);
}
void InOrder(Node* root)
{
    if(root==NULL)
    {return ;}
    InOrder(root->left);
    cout<<root->data<<" ";
    InOrder(root->right);
}
void PostOrder(Node* root)
{
    if(root==NULL)
    {return ;}
    PostOrder(root->left);
    PostOrder(root->right);
    cout<<root->data<<" ";
} 
Node* Search(Node* root, int key)
{
    if(root==NULL || root->data==key)
    {return root;}
    if(key<root->data)
    {
        return Search(root->left,key);
    }
    else{
       return  Search(root->right,key);
    }
}
Node* Insert(Node * root,int v)
{
    if(root==NULL)
    {return new Node(v);}
    if(root->data > v)
    {
        root->left=Insert(root->left,v);
    }
    else{
        root->right=Insert(root->right,v);
    }
    return root;
}
Node* successor(int key)
{
    if(root==NULL)
    {
        return NULL;
    }
    if(root->data==key && root->right==NULL)
    {
        return root;
    }
    Node* curr=this->root;
    Node* succ=NULL;
    while(curr!=NULL)
    {
         if(curr->data < key)
        {
            curr=curr->right;
        }
        else if(curr->data > key)
        {
            succ=curr;
            curr=curr->left;
        }
        
        else if(curr->data==key && curr->right!=NULL)
        {
            return minimum(curr->right);
        }
        
    }
    return succ;
}
Node* Predecessor(int key)
{
    if(root==NULL)
    return NULL;
    if(root->data==key && root->left==NULL)
    {
       return root;
    }
    Node* curr=this->root;
    Node* pre=NULL;
    while(curr!=NULL)
    {
        if(key<curr->data)
        {
            curr=curr->left;
        }
        else if(key>curr->data)
        {    pre=curr;
            curr=curr->right;
        }
        else if(key==curr->data && curr->left!=NULL)
        {
            return maximum(curr->left);
        }
    }
    return pre;
}
void Deletion(int key)
{
    if(root==NULL) return ;
    Node* prev=NULL;
      Node* curr=this->root;
    while (curr != NULL && curr->data != key) {
        prev = curr;
        if (key < curr->data) {
            curr = curr->left;
        } else {
            curr = curr->right;
        }
    }
    if(curr==NULL)
    {return ;}
    if(curr->right == NULL || curr->left==NULL)
    {
        Node* child;
          if(curr->right!=NULL)
          {
            child=curr->right;
          }
          else
          {
            child=curr->left;
          }
          if(prev==NULL)
          {
            root=child;
          }
          else if(prev->left==curr)
          { prev->left=child; }
          else{
            prev->right=child;
          }
          delete curr;
    }
    else{
        Node* succ=minimum(curr->right);
        curr->data=succ->data;
        Deletion(succ->data);
    }

}
};
int main()
{
    int n;
    cout<<"enter no. of Nodes:";
    cin>>n;
   class BST b;
    int x;
    cout<<"Enter Nodes:"<<endl;
    for(int i=0;i<n;i++)
    {cin>>x;
    b.root=b.Insert(b.root,x);}
    cout<<"the minimum of BST is:";
    Node* y=b.minimum(b.root);
    cout<<y->data<<endl;
    cout<<"the maximum of BST is:";
    Node* o= b.maximum(b.root);
    cout<<o->data<<endl;
    cout<<"inorder traversal:";
    b.InOrder(b.root);
    cout<<endl;
    cout<<"enter a number whose successor you  want to find:";
    cin>>x;
    cout<<"the successor of the "<<x<<"is : ";
    cout<<b.successor(x)->data;
     cout<<"enter a number whose predecessor you  want to find:";
     int p;
    cin>>p;
    Node*  r=b.Predecessor(p);
    cout<<r->data;
     
     int f;
     cout<<"enter node to be deleted:";
     cin>>f;
     b.Deletion(f);
     cout<<"after deletion: ";
     b.InOrder(b.root);
    return 0;
}