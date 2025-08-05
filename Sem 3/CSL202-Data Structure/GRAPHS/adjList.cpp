#include<bits/stdc++.h>
using namespace std;
class Graph{
public:
vector<vector<int>> adjList;
vector<vector<int>> edges;
int vertex;
Graph(int v,vector<vector<int>> edgeList)
{
   this->vertex=v;
   edges=edgeList;
   adjList.resize(v+1);
   formList();
}
void formList()
{
    for(int i=0; i<edges.size();i++)
    {
         int a=edges[i][0];
         int b=edges[i][1];
         //for undirected graph
        adjList[a].push_back(b);
        adjList[b].push_back(a);
    }
    printList();
}
void printList()
{
  for(int i = 1; i <=vertex; i++)
  {
    cout<<i<<":";
    for(int j = 0; j <adjList[i].size(); j++)
    {
        cout<<adjList[i][j]<<"->";
    }
    cout<<"null";
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