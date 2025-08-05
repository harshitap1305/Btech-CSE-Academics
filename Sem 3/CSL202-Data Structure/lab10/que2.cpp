#include <bits/stdc++.h>
using namespace std;

class Graph {
public:
    int vertices;
    vector<vector<int>> edgeList;
    vector<vector<int>> adjList;
    vector<int> discovery, finish, parent;
    stack<int> topoSortStack;
    int time = 0;
    vector<pair<int, int>> treeEdges;
    vector<pair<int, int>> backEdges;
    vector<pair<int, int>> forwardEdges;
    vector<pair<int, int>> crossEdges;
    Graph(int v, vector<vector<int>> edge) {
        edgeList = edge;
        vertices = v;
        adjList.resize(v + 1);
        FormAdjList();
        discovery.resize(v+1,-1);
        finish.resize(v+1,-1);
        parent.resize(v+1,-1);
    }

    void FormAdjList() {
        for (int i = 0; i<edgeList.size(); i++) {
            int u=edgeList[i][0];
            int v=edgeList[i][1];
            adjList[u].push_back(v);
        }
    }

    void classifyEdge(int s, int v) {
        if (discovery[v] > discovery[s] && parent[v] == s) {
            treeEdges.push_back({s, v});
        } else if (discovery[v] != -1 && finish[v] == -1) {
            backEdges.push_back({s, v});
        } else if (discovery[v] > discovery[s]) {
            forwardEdges.push_back({s, v});
        } else {
            crossEdges.push_back({s, v});
        }
    }

    void DFSTravel(int s) {
        discovery[s] = ++time;
        for (int i = 0; i < adjList[s].size(); ++i) {
            int v = adjList[s][i];
            if (discovery[v] == -1) {
                parent[v] = s;
                treeEdges.push_back({s, v});
                DFSTravel(v);
            } else {
                classifyEdge(s, v);
            }
        }
        finish[s] = ++time;
        topoSortStack.push(s); // Push the finished vertex to stack
    }

    void DFS() {
        for (int i = 1; i <= vertices; ++i) {
            if (discovery[i] == -1) {
                DFSTravel(i);
            }
        }
    }

    void printTopologicalOrder() {
        cout << "Topological Ordering: ";
        while (!topoSortStack.empty()) {
            cout << topoSortStack.top() << " ";
            topoSortStack.pop();
        }
        cout << endl;
    }

    void printDFSTree() {
        cout << "DFS Tree (Parent-Child relationships):" << endl;
        for (int i = 0; i < treeEdges.size(); i++) {
            cout << treeEdges[i].first << " -> " << treeEdges[i].second << endl;
        }
    }

    void printEdge() {
        cout << "TreeEdges are:" << endl;
        for (int i = 0; i < treeEdges.size(); ++i) {
            cout << treeEdges[i].first << "->" << treeEdges[i].second << endl;
        }
        cout << "BackEdges are:" << endl;
        for (int i = 0; i < backEdges.size(); ++i) {
            cout << backEdges[i].first << "->" << backEdges[i].second << endl;
        }
        cout << "ForwardEdges are:" << endl;
        for (int i = 0; i < forwardEdges.size(); ++i) {
            cout << forwardEdges[i].first << "->" << forwardEdges[i].second << endl;
        }
        cout << "Cross Edges are:" << endl;
        for (int i = 0; i < crossEdges.size(); ++i) {
            cout << crossEdges[i].first << "->" << crossEdges[i].second << endl;
        }
    }
};

int main() {
    int v;
    cout << "Enter number of vertices: ";
    cin >> v;
    int edge;
    cout << "Enter number of edges: ";
    cin >> edge;
    vector<vector<int>> edges(edge, vector<int>(2));
    cout << "Enter the edges:" << endl;
    for (int i = 0; i < edge; i++) {
        cin >> edges[i][0] >> edges[i][1];
    }
    Graph g(v, edges);

    g.DFS();
    g.printDFSTree();
    g.printEdge();
    g.printTopologicalOrder();

    return 0;
}
