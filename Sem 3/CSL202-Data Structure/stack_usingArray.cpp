//STACK= First in last out

#include<iostream>
using namespace std;
#define MAX 1000
class Stack{
    int top;
public:
int a[MAX];
Stack()
{
    top=-1;
}
bool isFull()
{
    if(top==MAX-1) return 1;
    else return 0;
}
bool isEmpty()
{
    if(top==-1) return 1;
    else return 0;
}
void Push(int v)
{
    if(isFull())
    {
        cout<<"stack Overflow"<<endl;
        return;
    }
    a[++top]=v;
}
int Pop()
{
    if(isEmpty())
    {
        cout<<"Stack Underflow"<<endl;
        return -1;
    }
    int x=a[top];
    top=top-1;
    return x; 

}
void Print()
{
    for(int i=0;i<=top;i++)
    {cout<<a[i]<<" ";}
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
    cout<<"element "<<s.Pop()<<" got popped!!"<<endl;
    s.Print();
    return 0;
}