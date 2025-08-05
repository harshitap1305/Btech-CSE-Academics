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
  void dfs(int node,vector<vector<int>> &adj,vector<int> &visited,int &time,vector<int> &h,vector<int> &discovery,vector<int> &parent,vector<int> &cutVer)
  {
      time=time+1;
      discovery[node]=time;
      h[node]=time;
      visited[node]=1;
      int child=0;
      for(int i=0;i<adj[node].size();i++)
      {
          if(!visited[adj[node][i]])
          {
              child++;
              parent[adj[node][i]]=node;
              dfs(adj[node][i],adj,visited,time,h,discovery,parent,cutVer);
              h[node]=min(h[node],h[adj[node][i]]);


              if(parent[node]!=-1 && h[adj[node][i]]>=discovery[node])
              {
                cutVer.push_back(node);
              }
              if(parent[node]==-1 && child>1)
              {
                cutVer.push_back(node);
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
        vector<int> cutVer;
        dfs(1,adj,visited,time,h,discovery,parent,cutVer);
        if(cutVer.size()==0)
        {
            cout<<"no cut vertex in the graph"<<endl;
        }
        else{
            cout<<"the cut vertex are"<<endl;
            for(int i=0;i<cutVer.size();i++)
            {
                cout<<cutVer[i]<<endl;
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