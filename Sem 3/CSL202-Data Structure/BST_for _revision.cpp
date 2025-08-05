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
    this -> root = NULL;
   }
   Node* maximum(Node* root)
   {
      if(root==NULL || root->right==NULL)
      {
        return root;
      }
      return maximum(root->right);
   }
   Node* minimum(Node* root)
   {
    if(root==NULL || root->left==NULL)
    {
        return root;
    }
    return minimum(root->left);
   }
   void inorder(Node* root)
   {
    if(root==NULL)
    {return ;}
    inorder(root->left);
    cout<<root->data<<" ";
    inorder(root->right);
   }
   void postorder(Node* root)
   {
    if(root==NULL)
    {return ;}
    postorder(root->left);
    postorder(root->right);
   cout<<root->data<<" ";
   }
   void preorder(Node* root)
   {
    if(root==NULL)
    {return ;}
    cout<<root->data<<" ";
    postorder(root->left);
    postorder(root->right);
   }
  Node* insert(Node* root, int v)
   {
        if(root==NULL)
        {
            return new Node(v);
        }
        if(root->data < v)
        {
            root->right = insert(root->right,v);
        }
        else{
            root->left= insert(root->left,v);
        }
        return root;
   }
   Node* Search(Node* root, int key)
   {
    if(root==NULL || root->data==key)
    {
        return root;
    }
    if(root->data < key )
    {
        return Search(root->right,key);
    }
    else{
        return Search(root->left, key);
    }
   }
   Node* successor(Node* root, int v)
   {
    if(root==NULL)
    {return root;}

    Node* current=this->root;
    Node* succ=NULL;
    while(current!=NULL)
    {
        if(current->data < v)
        {
            current=current->right;
        }
        else if(current->data > v)
        {
            succ=current;
            current=current->left;
        }
        else
        { 
            if(current->right!=NULL)
            {
                return minimum(current->right);
            }
            else{
                break;
                }
        }
    }
    return succ;
    }
  Node* predecessor(Node* root, int key)
  {
    if(root==NULL)
    {return root;}
    Node* curr=this -> root;
    Node* pre=NULL;
    while(curr!=NULL)
    {
        if(curr->data > key)
        {
            curr=curr->left;
        }
        else if(curr->data < key)
        {
            pre=curr;
            curr=curr->right;
        }
        else
        { 
            if(curr->left!=NULL)
            {
            return maximum(curr->left);
            }
             else{ 
                break;
                }
        }
    }
    return pre;
  }
/*void deletion(int key)
{
    if(root==NULL)
    {return ;}
    Node* prev=NULL;
    Node* curr=this->root;
    while(curr!=NULL)
    {
        prev=curr;
        if(curr->data < key)
        {
            curr=curr->right;
        }
        else if(curr->data > key)
        {
            curr=curr->left;
        }
        else{
            if(curr->left==NULL || curr->right==NULL)
            {
                Node* child;
                if(curr->right!=NULL)
                {child=curr->right;}
                else{
                    child=curr->left;
                }
              if(prev==NULL)
              {root=child;}  
              if(prev->left==curr)
              {
                prev->left=child;
              }
              else{
                prev->right=child;
              }
              delete curr;
            }
            else{
                Node* succ=minimum(curr->right);
                curr->data=succ->data;
                 deletion(succ->data);
            }
        }
    }
}*/
void deletion(int key)
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
         Node* succParent = curr;
        Node* succ = curr->right;
        while (succ->left != NULL) {
            succParent = succ;
            succ = succ->left;
        }

        // Copy the successor's data to the current node
        curr->data = succ->data;

        // Now, delete the in-order successor
        if (succParent->left == succ) {
            succParent->left = succ->right;
        } else {
            succParent->right = succ->right;
        }

        delete succ;
    }

}
int height(Node* root)
{
    if(root==NULL)
    {
        return 0;
    }
    int leftheight=height(root->left);
    int rightheight=height(root->right);
    int Max=max(leftheight,rightheight)+1;
    return Max;
}
};
int main()
{
    class BST b;
    int n;
    cout<<"enter no. of Nodes:";
    cin>>n;
    int x;
    cout<<"Enter Nodes:"<<endl;
    for(int i=0;i<n;i++)
    {
        cin>>x;
        b.root=b.insert(b.root,x);
    }
    cout<<"the minimum of BST is:";
    Node* y=b.minimum(b.root);
    cout<<y->data<<endl;

    cout<<"the maximum of BST is:";
    Node* o= b.maximum(b.root);
    cout<<o->data<<endl;

    cout<<"inorder traversal:";
    b.inorder(b.root);
    cout<<endl;

    cout<<"enter a number whose successor you  want to find:";
    cin>>x;
    cout<<"the successor of the "<<x<<"is : ";
    Node* a=b.successor(b.root,x);
    cout<<a->data<<endl;

     cout<<"enter a number whose predecessor you  want to find:";
     int p;
    cin>>p;
    Node*  r=b.predecessor(b.root,p);
    cout<<r->data<<endl;
     
     int f;
     cout<<"enter node to be deleted:";
     cin>>f;
     b.deletion(f);
     cout<<"after deletion: ";
     b.inorder(b.root);
     cout<<endl;
    cout<<"height of tree is : "<<b.height(b.root);
    return 0;
}