#include<iostream>
using namespace std;
int binarySerach(int a[],int n,int key)
{
    int l=0,r=n-1;

    while(l<=r)
    {
       int mid=l+(r-l)/2;
        if(a[mid]==key)
        {
            return mid;
        }
        else if(a[mid]>key)
        {
            r=mid-1;
        }
        else{
            l=mid+1;
        }
    }
    return -1;
}
int main()
{
    int n;
    cin>>n;
    int a[n];
    for(int i=0;i<n;i++)
    {cin>>a[i];}
    int key;
    cin>>key;
    if(binarySerach(a,n,key)==-1)
    {cout<<"key not found";}
    else{
        cout<<"key found";
    }

    return 0;
}