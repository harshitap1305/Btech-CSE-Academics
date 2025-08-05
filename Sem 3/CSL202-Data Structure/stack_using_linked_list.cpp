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
class Stack{
   Node* head;
   public:
   Stack()
   {
    this->head=NULL;
   }
   bool isEmpty()
   {
    if(head==NULL) return 1;
    else return 0;
   }
   void Push(int v)
   {
    Node* temp=new Node(v);
    if(!temp)
    {
        cout<<"Stack Overflow";
        return;
    }
    temp->next=head;
    head=temp;
   }
   void Pop()
   {
    if(this->isEmpty())
    {
        cout<<"Stack underflow"<<endl;
        return ;
    }
    Node* temp=head;
    head=head->next;
    delete temp;
   }
void Print()
{
    Node* temp=head;
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
    class Stack s;
    int n;
    cout<<"enter the number of elements in stack"<<endl;
    cin>>n;
    cout<<"enter the elements of stack"<<endl;
    int x;
    for(int i=0;i<n;i++)
    {
        cin>>x;
        s.Push(x);
    }
    s.Print();
    cout<<"element got popped!!"<<endl;
    s.Pop();
    s.Print();
    return 0;
}