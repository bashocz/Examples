#pragma once

#include <string>
#include <vector>

using namespace std;

template <class T>
struct Edge
{
	T from;
	T to;
	int weight;

	Edge() { }

	Edge (T _from, T _to, int _weight = 1)
	{
		from = _from;
		to = _to;
		weight = _weight;
	}
};

template <class T>
class Graph
{
private:
	string _name;
	bool _directed;
	bool _weighted;

	vector<T> _vertexVector;
	vector<Edge<T>> _edgeVector;

	int getVertexIndex(T vertex);
	bool isVertex(T vertex);
	T getVertexByIndex(int index);

	int getEdgeIndex(T from, T to);
	int getEdgeIndex(Edge<T> edge);
	bool isEdge(T from, T to);
	bool isEdge(Edge<T> edge);
	Edge<T> getEdgeByIndex(int index);

public:
	Graph();
	Graph(string name, bool directed = false, bool weighted = false);
	~Graph();

	string name();
	bool directed();
	bool weighted();

	void addVertex(T vertex);
	void removeVertexByIndex(int index);
	void removeVertex(T vertex);
	int getVertexCount();

	void addEdge(T from, T to, int weight = 1);
	void addEdge(Edge<T> edge);
	void updateEdgeWeight(T from, T to, int weight);
	void updateEdgeWeight(Edge<T> edge);
	void removeEdgeByIndex(int index);
	void removeEdge(T from, T to);
	void removeEdge(Edge<T> edge);
	void removeEdges(T vertex);
	int getEdgeCount();

	void clear();

	void printGraph();

	vector<Edge<T>> getConnectedEdges(T vertex, bool fromVertex = true);
	vector<T> getConnectedVertices(T vertex, bool fromVertex = true);

	void readFromFile(char* fileName, T (*fromString)(string vertexStr));
	void writeToFile(char* fileName, string (*toString)(T vertex));
};
