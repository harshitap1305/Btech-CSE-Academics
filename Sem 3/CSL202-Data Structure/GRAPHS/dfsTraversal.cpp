#include<bits\stdc++.h>
using namespace std;
class Graph{
public:
  void dfs(int node,vector<vector<int>> &adj,vector<int> &visited, vector<int> &dfsArray)
  {
      visited[node]=1;
      dfsArray.push_back(node);
      for(int i=0;i<adj[node].size();i++)
      {
          if(!visited[adj[node][i]])
          {
              dfs(adj[node][i],adj,visited,dfsArray);
          }
      }
  }
    
    
    vector<int> dfsOfGraph(vector<vector<int>>& adj) {
       
        int n=adj.size();
        vector<int> visited(n,0);
        vector<int> dfsArray;
        dfs(0,adj,visited,dfsArray);
        return dfsArray;
    }
};
int main()
{
    return 0;
}