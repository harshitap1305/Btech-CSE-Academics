#include<bits\stdc++.h>
using namespace std;
class Graph{

public:
    int vertices;
    vector<vector<int>> edgeList;
    vector<vector<int>> adj;
     Graph(int v,vector<vector<int>> edge)
        {
           edgeList=edge;
           vertices=v;
           adj.resize(v+1);
            FormAdjList();
        
        }
  void FormAdjList()
  {
          for(int i=0;i<edgeList.size();i++)
          {
             int u=edgeList[i][0];
             int v=edgeList[i][1];
             adj[u].push_back(v);
             adj[v].push_back(u);
          }
          dfsOfGraph(adj);
  }
  void dfs(int node,vector<vector<int>> &adj,vector<int> &visited,int &time,vector<int> &h,vector<int> &discovery,vector<int> &parent,vector<pair<int,int>> &cutEdges)
  {
      time=time+1;
      discovery[node]=time;
      h[node]=time;
      visited[node]=1;
      for(int i=0;i<adj[node].size();i++)
      {
          if(!visited[adj[node][i]])
          {
              parent[adj[node][i]]=node;
              dfs(adj[node][i],adj,visited,time,h,discovery,parent,cutEdges);
              h[node]=min(h[node],h[adj[node][i]]);

              if(h[adj[node][i]]>discovery[node])
              {
                cutEdges.push_back({node,adj[node][i]});
              }
          }
          else if(adj[node][i]!=parent[node])
              {
                h[node]=min(h[node],discovery[adj[node][i]]);
              }
      }
  }
    
    
    void dfsOfGraph(vector<vector<int>>& adj) {
       
        int n=adj.size();
        vector<int> discovery(n,-1);
        vector<int> visited(n,0);
        vector<int> h(n,-1);
        vector<int> parent(n,-1);
        int time=0;
        vector<pair<int,int>> cutEdges;
        dfs(1,adj,visited,time,h,discovery,parent,cutEdges);
        if(cutEdges.size()==0)
        {
            cout<<"no cut edges in the graph"<<endl;
        }
        else{
            cout<<"the cut edges are"<<endl;
            for(int i=0;i<cutEdges.size();i++)
            {
                cout<<"("<<cutEdges[i].first<<","<<cutEdges[i].second<<")"<<endl;
            }
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
    return 0;
}