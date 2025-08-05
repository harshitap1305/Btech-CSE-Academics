#include<bits/stdc++.h>
using namespace std;
void merge(vector<int> a, int left,int mid, int right)
{
    vector<int> temp;
    int low=left;
    int high=mid+1;
    while(low<=mid && high<=right)
    {
        if(a[low]<=a[high])
        {
            temp.push_back(a[low]);
            low++;
        }
        else{
            temp.push_back(a[high]);
            high++;
        }
    }
    while(low<=mid)
    {
        temp.push_back(a[low]);
        low++;
    }
    while(high<=right)
    {
        temp.push_back(a[high]);
        high++;
    }
    for(int i=left;i<=right;i++)
    {
        a[i]=temp[i-left];
    }
}
void mergeSort(vector<int> a,int left,int right)
{ 
      if(left<right)
      {
         int mid= left +(right-left)/2;
         mergeSort(a,left,mid);
         mergeSort(a,mid+1,right);
         merge(a,left,mid,right);
      }
}

int main()
{
    return 0;
}