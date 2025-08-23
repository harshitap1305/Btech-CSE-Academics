#include<iostream>
using namespace std;
class Heap_sort{
    int size;
    int *a;
    int originalSize;
    void max_heapify(int root)
    {
        int largest=root;
        int left=2*root + 1;
        int right= 2*root +2;  
        if(left<size && a[left]>a[largest])
            {largest=left;}
        if(right<size && a[right]>a[largest])
        {largest=right;}
        if(largest!=root)
        {
            swap(a[root],a[largest]);
            max_heapify(largest);
        }
    }
    public:
    Heap_sort(int *arr,int n)
    {
        a=arr;
        size=n;
        originalSize=n;
    }
    void sort()
    {
        for(int i=(size/2)-1;i>=0;i--)
        {max_heapify(i);}
        for(int i=size-1;i>0;i--)
        {
           swap(a[0],a[i]);
           size--;
           max_heapify(0);
        }
    }
    void printSortedArray()
    {
        for(int i=0;i<originalSize;++i)
        {
            cout<<a[i]<<" ";
        }
        cout<<endl;
    }
};
int main()
{
    int n;
    cout<<"enter size of array"<<endl;
    cin>>n;
    int a[n];
    cout<<"enter the elements of the array:"<<endl;
    for(int i=0;i<n;i++)
    {
        cin>>a[i];
    }
    class Heap_sort s(a,n);
    cout<<"the sorted array using heap sort is:"<<endl;
    s.sort();
    s.printSortedArray();
    return 0;
}
