#include<iostream>
#include<vector>
using namespace std;
class PriorityQueue{
   int *heap;
   int size;
   public:
   int parent(int i)
   {
    return (i-1)/2;
   }
   
   void heapify(int x)
   {
        int largest=x;
        int left=2*x+1;
        int right =2*x+2;
        if(left< size && heap[left]>heap[largest])
        {
            largest=left;
        }
        if(right<size && heap[right]>heap[largest])
        {
            largest=right;
        }
        if(largest!=x)
        {
            swap(heap[x],heap[largest]);
            heapify(largest);
        }

   }
   PriorityQueue(int arr[],int s)
   {
    heap=arr;
    size=s;
   }
  void Insert(int x)
  {
      size++;
      int i=size-1;
      heap[i]=x;

      while(i!=0 && heap[parent(i)]<heap[i])
    {
        swap(heap[parent(i)],heap[i]);
        i=parent(i);
    }
  }
  int Maximum()
  {
    if(sizeof(heap)<1)
    {
        cout<<"Heap/priority queue is empty,insert some elements"<<endl;
        return 0;
    }
    return heap[0];
  }
  int extractMax()
  {
    if(sizeof(heap)==0)
    {cout<<"heap is empty"<<endl;
    return 0;}
    int max=heap[0];
    heap[0]=heap[size-1];
    size--;
    heapify(0);
    return max;
  }
  void increaseKey(int i,int key)
  {
    if(key<heap[i])
    {cout<<"the given key is smaller then the current key"<<endl;
    return ;}
    heap[i]=key;
    while(i!=0 && heap[parent(i)]<heap[i])
    {
        swap(heap[parent(i)],heap[i]);
        i=parent(i);
    }
  }
  void printHeap()
  {
    for(int i=0;i<sizeof(heap);++i)
    {cout<<heap[i]<<" ";}
    cout<<endl;
  }
};
int main()
{
    int n;
    cout<<"enter the size of the array"<<endl;
    cin>>n;
    int a[n];
    cout<<"enter the elements of array"<<endl;
    for(int i=0;i<n;i++)
    {cin>>a[i];}
    class PriorityQueue h(a,n);
    cout<<"enter a element to insert"<<endl;
    int x;
    cin>>x;
    h.Insert(x);
    cout<<"after inserting:"<<endl;
    h.printHeap();
    cout<<"the max is:";
    cout<<h.Maximum();
    cout<<endl;
    cout<<"extracting maximum element:";
    cout<<h.extractMax();
    int i,y;
    cout<<"enter the position and key for increase key func:";
    cin>>i>>y;
    h.increaseKey(i,y);
    cout<<"after increasing key:";
    h.printHeap();
    return 0;
}