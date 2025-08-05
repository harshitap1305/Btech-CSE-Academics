#include<iostream>
using namespace std;
class Node{
public:
int data;
Node* next;

 Node(int value)
{
  this -> data=value;
  this -> next=NULL;
}

};
void PrintLinkedList(Node* &head)
{
     Node* temp = head;
     while(temp!=NULL)
     {
        cout<<temp -> data <<" ";
        temp=temp -> next;
     }
}
void insertAtBegin(Node* &head , int x)
{
   Node* temp =new Node(x);
   if(head == NULL)
   {head=temp;}
   else{
   temp -> next= head;
   head = temp;}
}
void insertAtEnd(Node* &tail, int x)
{
    Node* temp= new Node(x);
    tail -> next =temp;
    tail = tail -> next;
}

void insertAtIndex(Node* head,Node* tail,int p, int v)
{
    if(p==1)
    {insertAtBegin(head,v);
    return;}
    int count=1;
    Node* temp=head;
    while(count<p-1)
    {
        temp=temp -> next;
        count++;
    }
     if(temp -> next == NULL)
     {
        insertAtEnd(tail,v);
        return ;
     }
    Node* node=new Node(v);
       node -> next = temp -> next;
       temp -> next = node;

}
void deleteFromBegin(Node* &head)
{
    if(head==NULL)
    {return ;}
    Node* temp = head;
    head = head -> next;
    delete temp;

}
void deleteFromEnd(Node* head)
{
    if(head==NULL)
    {return;}
    if(head -> next == NULL)
    {delete head;
    return ;}
    //we will find second last node, then later delete last 
    Node* temp=head;//temp=till second last node
    while(temp -> next -> next != NULL)
    {
        temp=temp -> next;
    }
    //once we found second last node, delete last;
    delete (temp->next);
    temp->next = NULL;
}
void deleteByValue(Node* &head, int value)
{
    if(head==NULL)
    {return ;}
    if(head -> data == value)
    {
       /* Node* temp = head;
        head = head->next;
        delete temp;
        return ;*/
        deleteFromBegin(head);
        return ;
    }
    Node* toDelete=head;
    while(toDelete -> next !=NULL && toDelete -> next -> data != value)
    {
        toDelete= toDelete -> next;
    }

    Node* Delete=toDelete->next;
      toDelete->next = toDelete->next->next;
      delete Delete;
}
int main()
{
    //(a)creating linked list
    Node* newNode= new Node(5);
    Node* head=newNode;
    Node* tail=newNode;

    //(b)Inserting a node at the begaining of the list
    insertAtBegin(head,4);
    insertAtBegin(head,3);
    insertAtBegin(head,2);
    insertAtBegin(head,1);

    //printing the linked list
    cout<<"linked list after inserting nodes in the begainning=";
    PrintLinkedList(head);
    cout<<endl;

    //(c) Inserting node at the end of the list

    insertAtEnd(tail,6);
    insertAtEnd(tail,7);
 
    cout<<"linked list after inserting nodes at the end=";
    PrintLinkedList(head);
    cout<<endl;
    
    //(d)Insert a node before a node with a given value;
    int v,p;
    cout<<"enter the value to be inserted and it's position=";
    cin>>v>>p;
    cout<<"linked list after inserting node at given position="<<endl;
    
    insertAtIndex(head,tail,p,v);
    cout<<"Linked list after inserting "<<v<<" at position "<<p<<":";
    PrintLinkedList(head);
    cout<<endl;

    //(e) Delete the node at the beginning of the list
    deleteFromBegin(head);
    cout<<"Linked list after deleting node at the begining=";
    PrintLinkedList(head);
    cout<<endl;

    //(f) Delete the node at the end of the list
    deleteFromEnd(head);
    cout<<"linked list after deleting node from end=";
    PrintLinkedList(head);
    cout<<endl;

    //(g) Delete the node with a given value
    int value;
     cout<<"enter the value to be deleted=";
     cin>>value;
     deleteByValue(head,value);

     cout<<"linked list after deleting by value=";
     PrintLinkedList(head);
     cout<<endl;
    return 0;
}