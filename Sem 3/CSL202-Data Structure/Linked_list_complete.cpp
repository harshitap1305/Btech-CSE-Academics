#include<bits/stdc++.h>
class Node{
public:
int data;
Node* next;
Node(int v)
{
    this->data=v;
    this->next=NULL;
}
};
class LinkedList{
public:
Node* head;
LinkedList()
{
   head->next=NULL;
}
void insertAtBegin(int v)
{
    Node* temp=new Node(v);
    temp->next=head;
    head=temp;
}
void insertAtEnd(int v)
{
    Node* temp=new Node(v);

}
int node_remain(Node* head)
  {
    int count=0;
    Node* temp=head;
    while(temp!=NULL)
    {
        count++;
        temp=temp->next;
    }
    return count;
  }
  //leetcode que. 25
 Node* reverseKGroup(Node* head, int k) {
       if(head==NULL)
       {
        return NULL;
       } 
       Node* curr=head;
       Node* prev=NULL;
       Node* forward=NULL;
      int count=0;
      while(curr!=NULL && count<k)
      {
         forward=curr->next;
         curr->next=prev;
         prev=curr;
         curr=forward;
         count++;

      }
      if(forward!=NULL && node_remain(forward)>=k)
      {
        head->next=reverseKGroup(forward,k);
      }
      else
      {
        head->next=forward;
      }
      return prev;
    }
    //detect if cycle is present in linked and return starting point of the cycle
    //leetcode que no. 142
     Node *detectCycle(Node *head) {
        Node* temp=head;
        map<Node*,bool> visited;
        while(temp!=NULL)
        {
            if(visited[temp]==true)
            {return temp;}
            visited[temp]=true;
            temp=temp->next;
        }
        return NULL;
    }

    //leetcode 141
    //detect if cycle is present in a linked list
    bool hasCycle(Node *head) {
        Node *slow=head;
        5+Node* fast=head;
        while(fast!=NULL && fast->next!=NULL)
        {
            slow=slow->next;
            fast=fast->next->next;
            if(slow==fast)
            {return 1;}
        }
        return 0;
    }
};