#include<iostream>
using namespace std;
class Node{
    public:
int data;
Node *next;
Node(int val)
{
    this->data=val;
    this->next=NULL;
}
};
class LinkedList{
    public:
   Node* head;
   LinkedList(){
    this->head=NULL;
   }
   void Print()
   {
      if(head==NULL)
      {
        cout<<"Linked list is empty"<<endl;
        return;
      }
      Node* temp=head;
      while(temp!=NULL)
      {
        cout<<temp->data<<" ";
        temp=temp->next;
      }
      cout<<endl;
   }
   void insertAtBegin(int val)
   {
    Node* temp = new Node(val);
    if(head==NULL)
    {
       head=temp;
       return;
    }
    temp->next=head;
    head=temp;
   } 
   void insertAtEnd(int val)
   {
    Node* temp=new Node(val);
    if(head==NULL)
    {
        head=temp;
        return;
    }
    Node* current=head;
    while(current->next!=NULL){
        current=current->next;
    }
    current->next=temp;
   }
   void insertAtPosition(int val,int p)
   {
      Node* temp=new Node(val);
      if(p==0)
      {
        insertAtBegin(val);
        return;
      }
      Node* current=head;
     for(int i=0;i<p-1 && current!=NULL;i++)
     {
        current=current->next;.
     }
     if(current->next==NULL)
     {insertAtEnd(val);
     return ;}
     temp->next=current->next;
     current->next=temp;
   }
   void DeletionAtBegin()
   {
    if(head==NULL)
    {return;}
    Node* temp=head;
    head=head->next;
    delete temp;
   }
   void DeletionAtEnd()
   {
     Node* current=head;
     while(current->next->next!=NULL)
     {
        current=current->next;
     }
      delete(current->next);
      current->next=NULL;
   }
   void DeleteAtPosition(int p)
   {
      if(p==0)
      {
        DeletionAtBegin();
        return;
      }
       Node* current=head;
       for(int i=0;i<p-1 && current!=NULL;i++)
       {
        current=current->next;
       }
       if(current->next==NULL)
       {
        DeletionAtEnd();
        return;
       }
       Node* temp=current->next;
       current->next=current->next->next;
       delete(temp);
   }
   void DeletionByValue(int v)
   {
    if(head->data==v)
    {
      DeletionAtBegin();
      return;
    }
    Node* curr=head;
    while(curr->next->data!=v && curr!=NULL)
    {curr=curr->next;}
    Node* Delete=curr->next;
    curr->next=curr->next->next;
    delete Delete;
   }
   void ReverseByIteration()
   {
    Node* current=head;
    Node* prev=NULL;
    Node* forward=NULL;
    while(current!=NULL)
    {
      forward=current->next;
      current->next=prev;
      prev=current;
      current=forward;
    }
    head=prev;
   }
   Node* ReverseByRecursion(Node* head)
{
    if(head==NULL || head->next==NULL)
    {return head;}
    Node* rest=ReverseByRecursion(head->next);
    head->next->next=head;
    head->next=NULL;
    return rest;
}

};
int main()
{ 
    class LinkedList list;
    int n;
    cout<<"enter the number of nodes in the linked listt"<<endl;
    cin>>n;
    cout<<"enter the nodes"<<endl;
    int x;
    for(int i=0;i<n;i++)
    {
        cin>>x;
        list.insertAtBegin(x);
    }
    list.Print();
    int y,p;
    cout<<"enter the node and the position"<<endl;
    cin>>y>>p;
    list.insertAtPosition(y,p);
    list.Print();
    cout<<"after deletion fro begin"<<endl;
    list.DeletionAtBegin();
    list.Print();
    cout<<"After deletion from end"<<endl;
    list.DeletionAtEnd();
    list.Print();
    cout<<"after deletion at position 2"<<endl;
    list.DeleteAtPosition(2);
    list.Print();
    int m;
    cout<<"enter a value to be deleted: ";
    cin>>m;
    list.DeletionByValue(m);
    list.Print();
    cout<<"after reverse by Iteration: ";
    list.ReverseByIteration();
    list.Print();
    cout<<"after reverse by recursion: ";
    list.head= list.ReverseByRecursion(list.head);
    list.Print();

    return 0;
}