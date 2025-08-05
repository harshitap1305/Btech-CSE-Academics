#include<iostream>
using namespace std;

class MaxHeap{
public:
int *heap;
int size;
int orgsize;
MaxHeap(int *a,int s)
{
   heap=a;
   size=s;
   orgsize=s;
   buildheap();
}
void heapify(int i)
{
    int left=2*i + 1;
    int right=2*i +2;
    int largest=i;
    if(left < size && heap[left]>heap[largest])
    {largest=left;}
    if(right<size && heap[right]>heap[largest]) {
        largest=right;
    }
    if(largest!=i)
    {
        swap(heap[largest],heap[i]);
        heapify(largest);
    }
}
void buildheap()
{
    int s=(size/2)-1; 
    for(int i=s;i>=0;i--)
    {    
         heapify(i);
    }
}
void heapSort()
{
    for(int n=size-1;n>0;n--)
    {
        swap(heap[n],heap[0]);
        size--;
        heapify(0);
    }
}
void print()
{
    for(int i=0;i<orgsize;++i)
    {cout<<heap[i]<<" ";}
}
};
int main()
{
    int n;
    cout<<"enter no of elements";
    cin>>n;
    int a[n];
    for(int i=0;i<n;i++)
    {cin>>a[i];}
    class MaxHeap h(a,n);
   
    cout<<"elements of heap are";
    h.print();
    cout<<endl;
    cout<<"after heap sort";
    h.heapSort();
    h.print();
    cout<<endl;
    return 0;
} 