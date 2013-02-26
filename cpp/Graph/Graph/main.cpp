#include "stdafx.h"
#include "graph.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

template <class T>
Graph<T>::Graph()
{
	Graph("", false, false);
}

template <class T>
Graph<T>::Graph(string name, bool directed = false, bool weighted = false)
{
	_name = name;
	_directed = directed;
	_weighted = weighted;
}

template <class T>
Graph<T>::~Graph()
{
	_vertexVector.clear();
	_edgeVector.clear();
}

template <class T>
int Graph<T>::getVertexIndex(T vertex)
{
	for (int index = 0; index < (int)_vertexVector.size(); index++)
		if (_vertexVector[index] == vertex)
			return index;
	return -1;
}

template <class T>
bool Graph<T>::isVertex(T vertex)
{
	return getVertexIndex(vertex) >= 0;
}

template <class T>
T Graph<T>::getVertexByIndex(int index)
{
	if ((index < 0) || (index >= _vertexVector.size()))
		return 0;
	return _vertexVector[index];
}

template <class T>
int Graph<T>::getEdgeIndex(T from, T to)
{
	for (int index = 0; index < (int)_edgeVector.size(); index++)
		if (_directed)
		{
			if ((_edgeVector[index].from == from) && (_edgeVector[index].to == to))
				return index;
		}
		else
		{
			if (((_edgeVector[index].from == from) && (_edgeVector[index].to == to)) ||
			   ((_edgeVector[index].from == to) && (_edgeVector[index].to == from)))
				return index;
		}
	return -1;
}

template <class T>
int Graph<T>::getEdgeIndex(Edge<T> edge)
{
	return getEdgeIndex(edge.from, edge.to);
}

template <class T>
bool Graph<T>::isEdge(T from, T to)
{
	return getEdgeIndex(from, to) >= 0;
}

template <class T>
bool Graph<T>::isEdge(Edge<T> edge)
{
	return getEdgeIndex(edge.from, edge.to) >= 0;
}

template <class T>
Edge<T> Graph<T>::getEdgeByIndex(int index)
{
	if ((index < 0) || (index >= _edgeVector.size()))
		return Edge<T>();
	return _edgeVector[index];
}

template <class T>
string Graph<T>::name()
{
	return _name;
}

template <class T>
bool Graph<T>::directed()
{
	return _directed;
}

template <class T>
bool Graph<T>::weighted()
{
	return _weighted;
}

template <class T>
void Graph<T>::addVertex(T vertex)
{
	if (!isVertex(vertex))
		_vertexVector.push_back(vertex);
}

template <class T>
void Graph<T>::removeVertexByIndex(int index)
{
	if ((index < 0) || (index >= (int)_vertexVector.size()))
		return;
	removeEdges(_vertexVector[index]);
	_vertexVector.erase(_vertexVector.begin() + index);
}

template <class T>
void Graph<T>::removeVertex(T vertex)
{
	int index = getVertexIndex(vertex);
	if (index >= 0)
		removeVertexByIndex(index);
}

template <class T>
int Graph<T>::getVertexCount()
{
	return _vertexVector.size();
}

template <class T>
void Graph<T>::addEdge(T from, T to, int weight = 1)
{
	if (isVertex(from) && (isVertex(to)) && !isEdge(from, to))
	{
		if (!_weighted)
			weight = 1;
		_edgeVector.push_back(Edge<T>(from, to, weight));
	}
}

template <class T>
void Graph<T>::addEdge(Edge<T> edge)
{
	addEdge(edge.from, edge.to, edge.weight);
}

template <class T>
void Graph<T>::updateEdgeWeight(T from, T to, int weight)
{
	int index = getEdgeIndex(from, to);
	if (index >= 0)
	{
		vector<Edge<T>>::iterator iterator = _edgeVector.begin();
		iterator += index;
		*iterator = Edge<T>(from, to, weight);
	}
}

template <class T>
void Graph<T>::updateEdgeWeight(Edge<T> edge)
{
	updateEdgeWight(edge.from, edge.to, edge.weight);
}

template <class T>
void Graph<T>::removeEdgeByIndex(int index)
{
	if ((index < 0) || (index >= (int)_edgeVector.size()))
		return;
	_edgeVector.erase(_edgeVector.begin() + index);
}

template <class T>
void Graph<T>::removeEdge(T from, T to)
{
	int index = getEdgeIndex(edge);
	if (index >= 0)
		removeEdgeByIndex(index);
}

template <class T>
void Graph<T>::removeEdge(Edge<T> edge)
{
	int index = getEdgeIndex(edge);
	if (index >= 0)
		removeEdgeByIndex(index);
}

template <class T>
void Graph<T>::removeEdges(T vertex)
{
	int index = 0;
	while (index < (int)_edgeVector.size())
	{
		if ((_edgeVector[index].from == vertex) || (_edgeVector[index].to == vertex))
			removeEdgeByIndex(index);
		else 
			index++;
	}
}

template <class T>
int Graph<T>::getEdgeCount()
{
	return _edgeVector.size();
}

template <class T>
void Graph<T>::clear()
{
	_name = "";
	_directed = false;
	_weighted = false;
	_vertexVector.clear();
	_edgeVector.clear();
}

template <class T>
void Graph<T>::printGraph()
{
	cout << "Graph" << " \"" << _name << "\":" << endl;
	cout << "Directed = " << ((_directed) ? "true" : "false") << endl;
	cout << "Weighted = " << ((_weighted) ? "true" : "false") << endl;
	cout << "Vertex list (" << _vertexVector.size() << "):" << endl;
	for (int index = 0; index < (int)_vertexVector.size(); index++)
		cout << "Vertex[" << index << "] = " << _vertexVector[index] << endl;
	cout << "Edge list (" << _edgeVector.size() << "):" << endl;
	for (int index = 0; index < (int)_edgeVector.size(); index++)
	{
		cout << "Edge[" << index << "] = " << _edgeVector[index].from;
		cout << ((_directed) ? " -> " : " - ");
		cout << _edgeVector[index].to;
		if (_weighted)
			cout << "(" << _edgeVector[index].weight << ")";
		cout << endl;
	}
	cout << endl;
}

template <class T>
vector<Edge<T>> Graph<T>::getConnectedEdges(T vertex, bool fromVertex = true)
{
	vector<Edge<T>> edgeVector;

	for (int index = 0; index < (int)_edgeVector.size(); index++)
		if (_directed)
		{
			if (((_edgeVector[index].from == vertex) && (fromVertex)) ||
			   ((_edgeVector[index].to == vertex) && (!fromVertex)))
				edgeVector.push_back(_edgeVector[index]);
		}
		else
		{
			if ((_edgeVector[index].from == vertex) || (_edgeVector[index].to == vertex))
				edgeVector.push_back(_edgeVector[index]);
		}

	return edgeVector;
}

template <class T>
vector<T> Graph<T>::getConnectedVertices(T vertex, bool fromVertex = true)
{
	vector<Edge<T>> edgeVector = getConnectedEdges(vertex, fromVertex);
	vector<T> vertexList;

	for (int index = 0; index < (int)edgeVector.size(); index++)
	{
		if (edgeVector[index].from == vertex)
			vertexVector.push_back(edgeVector[index].to);
		else if (edgeVector[index].to == vertex)
			vertexVector.push_back(edgeVector[index].from);
	}

	return vertexVector;
}

template <class T>
void Graph<T>::readFromFile(char* fileName, T (*fromString)(string vertexStr))
{
	char line[1025];
	string trueStr = "true";
	ifstream in;
	in.open(fileName);
	if (in.is_open())
	{
		clear();
		// read main data
		in.getline(line, 1024);
		_name = line;
		in.getline(line, 1024);
		if (trueStr.compare(line) == 0)
			_directed = true;
		in.getline(line, 1024);
		if (trueStr.compare(line) == 0)
			_weighted = true;
		// read vertexes data
		in.getline(line, 1024);
		int vertexCount = atoi(line);
		for (int index = 0; index < vertexCount; index++)
		{
			in.getline(line, 1024);
			addVertex((*fromString)(line));
		}
		// read edges data
		in.getline(line, 1024);
		int edgeCount = atoi(line);
		for (int index = 0; index < edgeCount; index++)
		{
			in.getline(line, 1024);
			string lineStr = line;
			int delimiter = lineStr.find("|");
			T from = (*fromString)(lineStr.substr(0, delimiter));
			lineStr = lineStr.substr(delimiter + 1, lineStr.size() - delimiter - 1);
			delimiter = lineStr.find("|");
			T to = (*fromString)(lineStr.substr(0, delimiter));
			lineStr = lineStr.substr(delimiter + 1, lineStr.size() - delimiter - 1);
			int weight = atoi(lineStr.c_str());
			addEdge(from, to, weight);
		}
		// close file
		in.close();
		cout << "Graph \"" << _name << "\" was sucessfully read from file \"" << fileName << "\"." << endl << endl;
	}
	else
		cout << "Error during opening file \"" << fileName << "\"" << endl;
}

template <class T>
void Graph<T>::writeToFile(char* fileName, string (*toString)(T vertex))
{
	ofstream out;
	out.open(fileName);
	if (out.is_open())
	{
		// write main data
		out << _name << endl;
		out << ((_directed) ? "true" : "false") << endl;
		out << ((_weighted) ? "true" : "false") << endl;
		// write vertexes data
		out << _vertexVector.size() << endl;
		for (int index = 0; index < (int)_vertexVector.size(); index++)
			out << (*toString)(_vertexVector[index]) << endl;
		// write edges data
		out << _edgeVector.size() << endl;
		for (int index = 0; index < (int)_edgeVector.size(); index++)
		{
			out << (*toString)(_edgeVector[index].from) << "|" 
				<< (*toString)(_edgeVector[index].to) << "|"
				<< _edgeVector[index].weight << endl;
		}
		// close file
		out.close();
		cout << "Graph \"" << _name << "\" was saved to file \"" << fileName << "\"." << endl << endl;
	}
	else
		cout << "Error during opening file \"" << fileName << "\"" << endl;
}




int intFromString(string vertexStr)
{
	return atoi(vertexStr.c_str());
}

string intToString(int vertex)
{
	char intChar[128];
	sprintf_s(intChar, "%i", vertex);
	string intStr = intChar;
	return intStr;
}

string stringFromString(string vertexStr)
{
	return vertexStr;
}

string stringToString(string vertex)
{
	return vertex;
}

template <class T>
void printPath(vector<Edge<T>> path, bool directed, bool weighted)
{
	for (int index = 0; index < (int)path.size(); index++)
	{
		cout << path[index].from;
		if (weighted)
			cout << "(" << path[index].weight << ")";
		cout << ((directed) ? " -> " : " - ");
	}
	cout << path[path.size() - 1].to << endl;
}

template <class T>
bool isVertexInPath(vector<Edge<T>> edgeVector, T vertex)
{
	for (int index = 0; index < (int)edgeVector.size(); index++)
		if ((edgeVector[index].from == vertex) || (edgeVector[index].to == vertex))
			return true;
	return false;
}

template <class T>
void findPath(Graph<T> graph, T fromVertex, vector<Edge<T>> edgeVector)
{
	vector<Edge<T>> nextEdgeVector = graph.getConnectedEdges(fromVertex);
	for (int index = 0; index < (int)nextEdgeVector.size(); index++)
	{
		T toVertex = nextEdgeVector[index].to;
		if ((!graph.directed()) && (nextEdgeVector[index].to == fromVertex))
			toVertex = nextEdgeVector[index].from;
		// if toVertex isn't already in path only
		if (!isVertexInPath(edgeVector, toVertex))
		{
			// add edge to path
			edgeVector.push_back(Edge<T>(fromVertex, toVertex, nextEdgeVector[index].weight));
			// print path
			printPath(edgeVector, graph.directed(), graph.weighted());
			// recall for next vertex - recursive function
			findPath(graph, toVertex, edgeVector);
			// remove edge from path
			edgeVector.pop_back();
		}
	}
}

void findAllPath(Graph<string> graph, string fromVertex)
{
	cout << "All path from " << fromVertex << ":" << endl;
	vector<Edge<string>> edgeVector;
	findPath(graph, fromVertex, edgeVector);
	cout << endl;
}

void findAllPath(Graph<int> graph, int fromVertex)
{
	cout << "All path from " << fromVertex << ":" << endl;
	vector<Edge<int>> edgeVector;
	findPath(graph, fromVertex, edgeVector);
	cout << endl;
}

void intGraphTest1(char* fileName)
{
	// create graph
	Graph<int> graph ("Integer", true, false); // directed, non-weighted
	graph.addVertex(1);
	graph.addVertex(2);
	graph.addEdge(1, 2);
	graph.addEdge(1, 3); // this edge isn't insert, because vertes "3" doesn't exist
	graph.addVertex(3);
	graph.addVertex(4);
	graph.addVertex(5);
	graph.addVertex(6);
	graph.addEdge(1, 3); // this edge is insert now
	graph.addEdge(2, 1);
	graph.addEdge(2, 3);
	graph.addEdge(3, 4);
	graph.addEdge(3, 6);
	graph.addEdge(4, 5);
	graph.addEdge(5, 2);
	graph.addEdge(5, 6);
	graph.addEdge(6, 4);
	graph.printGraph();
	// write graph to file
	graph.writeToFile(fileName, intToString);
}

void intGraphTest2(char* fileName)
{
	Graph<int> graph;
	// read graph from file
	graph.readFromFile(fileName, intFromString);
	// find all path from vertex "1"
	findAllPath(graph, 1);
	// find all path from vertex "2"
	findAllPath(graph, 2);
	// delete vertex "3"
	graph.removeVertex(3);
	// find all path from vertex "1"
	findAllPath(graph, 1);
	// find all path from vertex "2"
	findAllPath(graph, 2);
	// find all path from vertex "4"
	findAllPath(graph, 4);
}

void stringGraphTest1(char * fileName)
{
	// create graph
	Graph<string> graph ("String", false, true); // non-directed, weighted
	graph.addVertex("A");
	graph.addVertex("B");
	graph.addVertex("C");
	graph.addVertex("D");
	graph.addVertex("E");
	graph.addVertex("F");
	graph.addVertex("G");
	graph.addVertex("H");
	graph.addVertex("I");
	graph.addEdge("A", "B", 3);
	graph.addEdge("A", "C", 5);
	graph.addEdge("B", "D", 9);
	graph.addEdge("B", "C", 7);
	graph.addEdge("C", "D", 4);
	graph.addEdge("E", "F", 1);
	graph.addEdge("E", "H", 7);
	graph.addEdge("F", "G", 2);
	graph.addEdge("F", "I", 3);
	graph.addEdge("G", "H", 8);
	graph.addEdge("H", "I", 6);
	graph.printGraph();
	// write graph to file
	graph.writeToFile(fileName, stringToString);
}

void stringGraphTest2(char* fileName)
{
	Graph<string> graph;
	// read graph from file
	graph.readFromFile(fileName, stringFromString);
	// find all path from vertex "A"
	findAllPath(graph, "A");
	// find all path from vertex "F"
	findAllPath(graph, "F");

	// add edge from "D" to "E"
	graph.addEdge("D", "E", 5);
	// find all path from vertex "A"
	findAllPath(graph, "A");
}

int _tmain(int argc, _TCHAR* argv[])
{
	char* intFileName = "C:\\intgraph.txt";
	char* stringFileName = "C:\\stringgraph.txt";
	// creates directed non-weighted Graph<int> with vertices and edges, saves graph to file
	intGraphTest1(intFileName);
	// loads graph from file, print all paths from some vertices, deletes some vertices/edges
	intGraphTest2(intFileName);
	// creates non-directed weighted Graph<string> with vertices and edges, saves graph to file
	stringGraphTest1(stringFileName);
	// loads graph from file, print all paths from some vertices, deletes some vertices/edges
	stringGraphTest2(stringFileName);

	// cleaning - delete file
	remove(intFileName);
	// cleaning - delete file
	remove(stringFileName);

	string mystr;
	getline(cin, mystr);

	return 0;
}