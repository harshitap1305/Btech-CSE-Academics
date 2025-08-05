#include<bits/stdc++.h>
using namespace std;
class Graph{
public:
vector<vector<int>> adjMatrix;
vector<vector<int>> edges;
int vertex;
Graph(int v,vector<vector<int>> edgeList)
{
   this->vertex=v;
   edges=edgeList;
   adjMatrix.resize(v+1,vector<int>(v+1,0));
   formMatrix();
}
void formMatrix()
{
    for(int i=0; i<edges.size();i++)
    {
         int a=edges[i][0];
         int b=edges[i][1];
         //for undirected graph
         adjMatrix[a][b]=1;
         adjMatrix[b][a]=1;
    }
    printMatrix();
}
void printMatrix()
{
  for (int i = 1; i <=vertex; i++)
  {
    /* code */
    for (int j = 1; j <=vertex; j++)
    {
        /* code */
        cout<<adjMatrix[i][j]<<" ";
    }
    cout<<endl;
  }
  
}
};
int main()
{
    int n,m;
    cout<<"enter the number of nodes and edges:";
    cin>>n>>m;
    vector<vector<int>> edgeList;
    int x,y;
    cout<<"enter the edges"<<endl;
    for(int i=0;i<m;i++)
    {
        cin>>x>>y;
        edgeList.push_back({x,y});
    }
    Graph g(n,edgeList);
    return 0;
}