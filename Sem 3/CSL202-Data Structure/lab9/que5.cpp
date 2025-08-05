#include <bits\stdc++.h>
using namespace std;

class Graph {
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
    FormAdjList();
    FormAdjMatrix();

  }
  void FormAdjList()
  {
          for(int i=0;i<edgeList.size();i++)
          {
             int u=edgeList[i][0];
             int v=edgeList[i][1];
             adjList[u].push_back(v);
          }
  }
  void FormAdjMatrix()
  {
       for(int i=0;i<edgeList.size();i++)
       {
         int u=edgeList[i][0];
         int v=edgeList[i][1];

         adjMat[u][v]=1;
       }
  }
  Graph TransposeAdjList() {
        Graph transposeGraph(vertices, {});
        for (int u=1; u<=vertices;u++) {
            for (int v : adjList[u]) {
                transposeGraph.adjList[v].push_back(u);
            }
        }
        return transposeGraph;
    }
    Graph TransposeAdjMatrix() {
        Graph transposeGraph(vertices, {});
        for (int i=1;i<=vertices;i++) {
            for (int j=1;j<=vertices;j++) {
                if (adjMat[i][j]==1) {
                    transposeGraph.adjMat[j][i]=1;
                }
            }
        }
        return transposeGraph;
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
    
    cout<<"Original Adjacency Matrix:"<< endl;
    g.Print_AdjMAtrix();
    cout<<"Original Adjacency List:"<< endl;
    g.Print_AdjList();

    Graph transposeList = g.TransposeAdjList();
    cout<<"Transpose Adjacency List:"<<endl;
    transposeList.Print_AdjList();

    Graph transposeMatrix = g.TransposeAdjMatrix();
    cout << "Transpose Adjacency Matrix:" << endl;
    transposeMatrix.Print_AdjMAtrix();
    return 0;
}