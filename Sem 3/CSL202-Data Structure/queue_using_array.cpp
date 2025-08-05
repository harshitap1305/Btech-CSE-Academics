//QUEUE= first in first out; 
#include<iostream>
using namespace std;
#define MAX 1000
class Queue{
  int front;
  int rear;
  public:
  int a[MAX];
  Queue()
  {
    front=-1;
    rear=-1;
  }
  bool isEmpty()
  {
    return front==-1 || front>rear;
  }
  bool isFull()
  {
    return rear==MAX-1;
  }
  void Enqueue(int v)
  {
    if(isFull())
    {
        cout<<"FULL!!"<<endl;
        return;
    }
    if(isEmpty()) {front=0;}
    a[++rear]=v;
  }
  int Dequeue()
  {
    if(isEmpty())
    {cout<<"EMPTY!!!"<<endl;}
    int ans=a[front];
    front++;
    if(isEmpty())
    {
        front=-1;
        rear=-1;
    }
    return ans;
  }
  int getRear()
  {
    if (isEmpty())
    {
      cout<<"empty"<<endl;
      return -1;
    }
    return a[rear];
    
  }
  int getFront()
  {
    if(isEmpty())
    {cout<<"empty"<<endl;
    return -1;}
    return a[front];
  }
  void Print()
  {
    if(isEmpty())
    {
        cout<<"empty"<<endl;
        return;
    }
    for(int i=front;i<=rear;i++)
    {cout<<a[i]<<" ";}
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
    cout<<"element "<<s.Dequeue()<<" got Dequeued!!"<<endl;
    s.Print();
}