#include<iostream>
using namespace std;
class MAX_HEAP{
    int size;
    int *heap;
    void max_heapify(int root)
    {
        int largest=root;
        int left=2*root + 1;
        int right= 2*root +2;  
        if(left<size && heap[left]>heap[largest])
            {largest=left;}
        if(right<size && heap[right]>heap[largest])
        {largest=right;}
        if(largest!=root)
        {
            swap(heap[root],heap[largest]);
            max_heapify(largest);
        }
    }
    public:
    MAX_HEAP(int array[],int length)
    {
        heap=array;
        size=length;
        construct_heap();
    }
    void construct_heap()
    {
        int start=(size/2)+1;
        for(int i=start;i>=0;i--)
        {
            max_heapify(i);
        }
    }
    void printHeap()
    {
        for(int i=0;i<size;++i)
        {
            cout<<heap[i]<<" ";
        }
        cout<<endl;
    }

};
int main()
{
    int n;
    cout<<"enter the size of array:"<<endl;
    cin>>n;
    cout<<"enter the elements of array:"<<endl;
    int a[n];
    for(int i=0;i<n;i++)
    {
        cin>>a[i];
    }
    class MAX_HEAP h(a,n);
    cout<<"heap representation of the given array is:"<<endl;
    h.printHeap();
    
    return 0;
}