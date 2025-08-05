#include<iostream>
#include<vector>
//matix representation of un-directed,weighted; 
using namespace std;
int main()
{
    int vertex,edges;
    cout<<"enter no of vertex and edges";
    cin>>vertex>>edges;
    vector<vector<int>> adjMatrix(vertex,vector<int>(vertex,0));
    cout<<"enter the edges of graph"<<endl;
    int x,y,weight;

    for(int i=0;i<edges;i++)
    {   cout<<"line"<<i<<": ";
       cin>>x>>y>>weight;
       adjMatrix[x][y]=weight;
       adjMatrix[y][x]=weight;
    }
    cout<<"matrix representation is given below:"<<endl;
    for(int i=0;i<vertex;i++)
    {
        for(int j=0;j<vertex;j++)
        {
            cout<<adjMatrix[i][j]<<" ";
        }
        cout<<endl;
    }
    return 0;
}