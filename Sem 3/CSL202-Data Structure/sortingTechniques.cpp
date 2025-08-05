#include<iostream>
using namespace std;
void BubbleSort(int a[],int n)
{
  for(int i=0;i<n-1;i++)
  {
    for(int j=0;j<n-i-1;j++)
    {
        if(a[j]>a[j+1])
        {
            int temp=a[j];
            a[j]=a[j+1];
            a[j+1]=temp;
        }
    }
  }
}
void InsertionSort(int a[],int n)//takes an element and places it at correct place
{
     for(int i=0;i<n;i++)
     {
        int j=i;
        while(j>0 && a[j-1]>a[j])
        {
            swap(a[j-1],a[j]);
            j--;
        }
     }

}
void SelectionSort(int a[],int n)//get the minimum from the unsorted array and swap
// with the element which is at it's correct place
{
  for(int i=0;i<n-2;i++)
  {
    for(int j=i;j<n-1;j++)
    {
       if(a[j]<a[i])
       {swap(a[j],a[i]);}
    }
  }
}
int main()
{
    int n;
    cin>>n;
    int a[n];
    for(int i=0;i<n;i++)
    {
        cin>>a[i];
    }
    InsertionSort(a,n);
    for(int i=0;i<n;i++)
    {
        cout<<a[i]<<" ";
    }
    return 0;
}