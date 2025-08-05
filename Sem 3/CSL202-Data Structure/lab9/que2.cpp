#include<bits\stdc++.h>
using namespace std;
class Graph{
    public:
int vertices;
vector<vector<int>> adjList;
vector<vector<int>> edgeList;
  Graph(int v,vector<vector<int>> edge)
  {
    vertices=v;
    edgeList=edge;
    adjList.resize(v + 1);
    FormAdjList();
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
void BSF(int start)
{
    vector<string> color(vertices+1,"white");
    vector<int> parent(vertices+1,-1);
    queue<int> q;
    color[start]="grey";
    q.push(start);
    cout<<"BFS tree Edges"<<endl;
    while(!q.empty())
    {
        int node=q.front();
        q.pop();
        for (int i=0;i<adjList[node].size();i++)
         {
             int neighbor = adjList[node][i];
             if (color[neighbor]=="white")
            {
             color[neighbor]="grey";  
             parent[neighbor]=node;  
             q.push(neighbor);
             cout<<node<<" -> "<<neighbor<<endl; 
            }
        }
        color[node]="black";

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
    cout<<"enter the starting point of bsf";
    int s;
    cin>>s;
    g.BSF(s);
    return 0;
}
