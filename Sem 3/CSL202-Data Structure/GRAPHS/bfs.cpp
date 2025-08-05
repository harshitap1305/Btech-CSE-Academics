 #include<bits/stdc++.h>
using namespace std;
class Graph{ 
 vector<int> bfsOfGraph(vector<vector<int>> &adj) {
        //Code here
        vector<int> bfs;
        vector<bool> visited(adj.size(),0);
        queue<int> q;
        visited[0]=1;
        q.push(0);
        while(!q.empty())
        {
            int curr=q.front();
            q.pop();
            bfs.push_back(curr);
            for(int i=0;i<adj[curr].size();i++)
            {
                int neighbour=adj[curr][i];
                if(visited[neighbour]==0)
                {
                    visited[neighbour]=1;
                    q.push(neighbour);
                }
            }
        }
        return bfs;
    }
};
int main()
{
    return 0;
}