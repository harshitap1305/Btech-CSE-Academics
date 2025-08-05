#include<iostream>
using namespace std;
int main()
{
    int n,largest=INT_MIN;
    cin>>n;
    int a[n];
    for(int i=0;i<n;i++)
    {
        cin>>a[i];
        if(largest<a[i])
        {largest=a[i];}
    }
    cout<<"largest element is: "<<largest<<endl;
    return 0;
}