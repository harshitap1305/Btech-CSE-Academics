//program to reverse a linked list using iterative method 
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
   temp -> next= head;
   head = temp;
}
Node* Reverse(Node* head)
{
    Node* current=head;
    Node* prev=NULL;
    Node* forward=NULL;
    while(current!=NULL)
    {
        forward=current -> next;
        current-> next=prev;
        prev=current;
        current=forward;
    }
    return prev;
}
int main()
{
    
    //creating linked list
     Node* newNode= new Node(5);
    Node* head=newNode;
    
    insertAtBegin(head,4);
    insertAtBegin(head,3);
    insertAtBegin(head,2);
    insertAtBegin(head,1);
 
   cout<<"original linked list=";
   PrintLinkedList(head);
   cout<<endl;
   head=Reverse(head);
   cout<<"Reversed Linked list=";
   PrintLinkedList(head);
    return 0;
}