#include<bits\stdc++.h>
using namespace std;
class Graph{
public:
int vertices;
vector<vector<int>> edgeList;
vector<vector<int>> adjList;
vector<vector<int>> adjMat;
  
  Graph(int v,vector<vector<int>> edge)
  {
    edgeList=edge;
    vertices=v;
    adjList.resize(v+1);
    adjMat.resize(v+1, vector<int>(v+1, 0));
  }
  void FormAdjList()
  {
          for(int i=0;i<edgeList.size();i++)
          {
             int u=edgeList[i][0];
             int v=edgeList[i][1];
             adjList[u].push_back(v);
             adjList[v].push_back(u);
          }
  }
  void FormAdjMatrix()
  {
       for(int i=0;i<edgeList.size();i++)
       {
         int u=edgeList[i][0];
         int v=edgeList[i][1];

         adjMat[u][v]=1;
         adjMat[v][u]=1;
       }
  }
  void Print_AdjList()
  {
    for(int i=1;i<=vertices;i++)
    {
        cout<<i<<":";
        for(int j=0;j<adjList[i].size();j++ )
        {
            cout<<adjList[i][j]<<"->";
        }
        cout<<"null";
        cout<<endl;
        
    }
  }
  void Print_AdjMAtrix()
  {
    for(int i=1;i<=vertices;i++)
    {
        for(int j=1;j<=vertices;j++)
        {
            cout<<adjMat[i][j]<<" ";
        }
        cout<<endl;
    }
  }
};
int main()
{
    int v;
    cout<<"enter number of vertices: ";
    cin>>v;
    int edge;
    cout<<"enter number of edges:";
    cin>>edge;
    vector<vector<int>> edges(edge, vector<int>(2));
    cout<<"enter the edges:"<<endl;
    for (int i=0;i<edge;i++) {
        cin>>edges[i][0]>>edges[i][1];
    }
    Graph g(v,edges);

    g.FormAdjList();
    g.FormAdjMatrix();

    g.Print_AdjList();
    g.Print_AdjMAtrix();
    return 0;
}