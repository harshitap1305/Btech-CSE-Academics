//program to reverse a linked list using recursion.
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
void Reverse(Node* &head, Node* current, Node* prev)
{
    if(current==NULL)
    {
        head = prev;
        return;
    }
    Node* forward=current -> next;
    Reverse(head,forward,current);
    current-> next=prev;
}

Node* ReverseLinkedList(Node* head)
{
    Node* current=head;
    Node* prev=NULL;
    Reverse(head,current,prev);
    return head;
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
   head=ReverseLinkedList(head);
   cout<<"reversed Linked list using recursion=";
   PrintLinkedList(head);
    return 0;
}