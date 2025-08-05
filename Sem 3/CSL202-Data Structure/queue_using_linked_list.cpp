#include<iostream>
using namespace std;
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
class Queue{
  Node* front;
  Node* rear;
  public:
  Queue()
  {
    this->front=NULL;
    this->rear=NULL;
  }
  bool isEmpty()
  {
    if(front==NULL)
    {return 1;}
    else return 0;
  }
  void Enqueue(int v)
  {
    Node* temp=new Node(v);
    if(this->isEmpty())
    {
        front=temp;
        rear=temp;
    }
    if(!temp)
    {
        cout<<"queue full"<<endl;
        return;
    }
    rear->next=temp;
    rear=temp;
  }
  void Dequeue()
  {
    if(this->isEmpty()) 
    {cout<<"empty";88
    return;}
    Node* temp=front;
    front=front->next;
    if(front==NULL)
    {rear=NULL;}
    delete temp;
  }
  int getFront()
  {
    if(isEmpty())
    {cout<<"empty";
    return -1;}
    return front->data;
  }
  int getRear()
  {
    if(isEmpty())
    {cout<<"empty";
    return -1;}
    return rear->data;
  }
  void Print()
  {
    Node* temp=front;
    while(temp!=NULL)
    {
        cout<<temp->data<<" ";
        temp=temp->next;
    }
    cout<<endl;
  }
};
int main()
{
    class Queue s;
    int n;
    cout<<"enter the number of elements in queue"<<endl;
    cin>>n;
    cout<<"enter the elements of queue"<<endl;
    int x;
    for(int i=0;i<n;i++)
    {
        cin>>x;
        s.Enqueue(x);
    }
    s.Print();
    cout<<"element got Dequeued!!"<<endl;
    s.Print();
    cout<<"front is "<<s.getFront()<<" and rear is "<<s.getRear();
    return 0;

}