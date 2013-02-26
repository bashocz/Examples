#include "StdAfx.h"
#include "Graph.h"
#include <iostream>
#include <fstream>

//template <class T>
//Graph<T>::Graph()
//{
//	Graph("", false, false);
//}
//
//template <class T>
//Graph<T>::Graph(string name, bool directed = false, bool weighted = false)
//{
//	_name = name;
//	_directed = directed;
//	_weighted = weighted;
//}
//
//template <class T>
//Graph<T>::~Graph()
//{
//	_vertexVector.clear();
//	_edgeVector.clear();
//}
//
//template <class T>
//int Graph<T>::getVertexIndex(T vertex)
//{
//	for (int index = 0; index < (int)_vertexVector.size(); index++)
//		if (_vertexVector[index] == vertex)
//			return index;
//	return -1;
//}
//
//template <class T>
//bool Graph<T>::isVertex(T vertex)
//{
//	return getVertexIndex(vertex) >= 0;
//}
//
//template <class T>
//T Graph<T>::getVertexByIndex(int index)
//{
//	if ((index < 0) || (index >= _vertexVector.size()))
//		return 0;
//	return _vertexVector[index];
//}
//
//template <class T>
//int Graph<T>::getEdgeIndex(T from, T to)
//{
//	for (int index = 0; index < (int)_edgeVector.size(); index++)
//		if (_directed)
//		{
//			if ((_edgeVector[index].from == from) && (_edgeVector[index].to == to))
//				return index;
//		}
//		else
//		{
//			if (((_edgeVector[index].from == from) && (_edgeVector[index].to == to)) ||
//			   ((_edgeVector[index].from == to) && (_edgeVector[index].to == from)))
//				return index;
//		}
//	return -1;
//}
//
//template <class T>
//int Graph<T>::getEdgeIndex(Edge<T> edge)
//{
//	return getEdgeIndex(edge.from, edge.to);
//}
//
//template <class T>
//bool Graph<T>::isEdge(T from, T to)
//{
//	return getEdgeIndex(from, to) >= 0;
//}
//
//template <class T>
//bool Graph<T>::isEdge(Edge<T> edge)
//{
//	return getEdgeIndex(edge.from, edge.to) >= 0;
//}
//
//template <class T>
//Edge<T> Graph<T>::getEdgeByIndex(int index)
//{
//	if ((index < 0) || (index >= _edgeVector.size()))
//		return Edge<T>();
//	return _edgeVector[index];
//}
//
//template <class T>
//string Graph<T>::name()
//{
//	return _name;
//}
//
//template <class T>
//bool Graph<T>::directed()
//{
//	return _directed;
//}
//
//template <class T>
//bool Graph<T>::weighted()
//{
//	return _weighted;
//}
//
//template <class T>
//void Graph<T>::addVertex(T vertex)
//{
//	if (!isVertex(vertex))
//		_vertexVector.push_back(vertex);
//}
//
//template <class T>
//void Graph<T>::removeVertexByIndex(int index)
//{
//	if ((index < 0) || (index >= (int)_vertexVector.size()))
//		return;
//	removeEdges(_vertexVector[index]);
//	_vertexVector.erase(_vertexVector.begin() + index);
//}
//
//template <class T>
//void Graph<T>::removeVertex(T vertex)
//{
//	int index = getVertexIndex(vertex);
//	if (index >= 0)
//		removeVertexByIndex(index);
//}
//
//template <class T>
//int Graph<T>::getVertexCount()
//{
//	return _vertexVector.size();
//}
//
//template <class T>
//void Graph<T>::addEdge(T from, T to, int weight = 1)
//{
//	if (isVertex(from) && (isVertex(to)) && !isEdge(from, to))
//	{
//		if (!_weighted)
//			weight = 1;
//		_edgeVector.push_back(Edge<T>(from, to, weight));
//	}
//}
//
//template <class T>
//void Graph<T>::addEdge(Edge<T> edge)
//{
//	addEdge(edge.from, edge.to, edge.weight);
//}
//
//template <class T>
//void Graph<T>::updateEdgeWeight(T from, T to, int weight)
//{
//	int index = getEdgeIndex(from, to);
//	if (index >= 0)
//	{
//		vector<Edge<T>>::iterator iterator = _edgeVector.begin();
//		iterator += index;
//		*iterator = Edge<T>(from, to, weight);
//	}
//}
//
//template <class T>
//void Graph<T>::updateEdgeWeight(Edge<T> edge)
//{
//	updateEdgeWight(edge.from, edge.to, edge.weight);
//}
//
//template <class T>
//void Graph<T>::removeEdgeByIndex(int index)
//{
//	if ((index < 0) || (index >= (int)_edgeVector.size()))
//		return;
//	_edgeVector.erase(_edgeVector.begin() + index);
//}
//
//template <class T>
//void Graph<T>::removeEdge(T from, T to)
//{
//	int index = getEdgeIndex(edge);
//	if (index >= 0)
//		removeEdgeByIndex(index);
//}
//
//template <class T>
//void Graph<T>::removeEdge(Edge<T> edge)
//{
//	int index = getEdgeIndex(edge);
//	if (index >= 0)
//		removeEdgeByIndex(index);
//}
//
//template <class T>
//void Graph<T>::removeEdges(T vertex)
//{
//	int index = 0;
//	while (index < (int)_edgeVector.size())
//	{
//		if ((_edgeVector[index].from == vertex) || (_edgeVector[index].to == vertex))
//			removeEdgeByIndex(index);
//		else 
//			index++;
//	}
//}
//
//template <class T>
//int Graph<T>::getEdgeCount()
//{
//	return _edgeVector.size();
//}
//
//template <class T>
//void Graph<T>::clear()
//{
//	_name = "";
//	_directed = false;
//	_weighted = false;
//	_vertexVector.clear();
//	_edgeVector.clear();
//}
//
//template <class T>
//void Graph<T>::printGraph()
//{
//	cout << "Graph" << " \"" << _name << "\":" << endl;
//	cout << "Directed = " << ((_directed) ? "true" : "false") << endl;
//	cout << "Weighted = " << ((_weighted) ? "true" : "false") << endl;
//	cout << "Vertex list (" << _vertexVector.size() << "):" << endl;
//	for (int index = 0; index < (int)_vertexVector.size(); index++)
//		cout << "Vertex[" << index << "] = " << _vertexVector[index] << endl;
//	cout << "Edge list (" << _edgeVector.size() << "):" << endl;
//	for (int index = 0; index < (int)_edgeVector.size(); index++)
//	{
//		cout << "Edge[" << index << "] = " << _edgeVector[index].from;
//		cout << ((_directed) ? " -> " : " - ");
//		cout << _edgeVector[index].to;
//		if (_weighted)
//			cout << "(" << _edgeVector[index].weight << ")";
//		cout << endl;
//	}
//	cout << endl;
//}
//
//template <class T>
//vector<Edge<T>> Graph<T>::getConnectedEdges(T vertex, bool fromVertex = true)
//{
//	vector<Edge<T>> edgeVector;
//
//	for (int index = 0; index < (int)_edgeVector.size(); index++)
//		if (_directed)
//		{
//			if (((_edgeVector[index].from == vertex) && (fromVertex)) ||
//			   ((_edgeVector[index].to == vertex) && (!fromVertex)))
//				edgeVector.push_back(_edgeVector[index]);
//		}
//		else
//		{
//			if ((_edgeVector[index].from == vertex) || (_edgeVector[index].to == vertex))
//				edgeVector.push_back(_edgeVector[index]);
//		}
//
//	return edgeVector;
//}
//
//template <class T>
//vector<T> Graph<T>::getConnectedVertices(T vertex, bool fromVertex = true)
//{
//	vector<Edge<T>> edgeVector = getConnectedEdges(vertex, fromVertex);
//	vector<T> vertexList;
//
//	for (int index = 0; index < (int)edgeVector.size(); index++)
//	{
//		if (edgeVector[index].from == vertex)
//			vertexVector.push_back(edgeVector[index].to);
//		else if (edgeVector[index].to == vertex)
//			vertexVector.push_back(edgeVector[index].from);
//	}
//
//	return vertexVector;
//}
//
//template <class T>
//void Graph<T>::readFromFile(char* fileName, T (*fromString)(string vertexStr))
//{
//	char line[1025];
//	string trueStr = "true";
//	ifstream in;
//	in.open(fileName);
//	if (in.is_open())
//	{
//		clear();
//		// main data
//		in.getline(line, 1024);
//		_name = line;
//		in.getline(line, 1024);
//		if (trueStr.compare(line) == 0)
//			_directed = true;
//		in.getline(line, 1024);
//		if (trueStr.compare(line) == 0)
//			_weighted = true;
//		// vertexes data
//		in.getline(line, 1024);
//		int vertexCount = atoi(line);
//		for (int index = 0; index < vertexCount; index++)
//		{
//			in.getline(line, 1024);
//			addVertex((*fromString)(line));
//		}
//		// edges data
//		in.getline(line, 1024);
//		int edgeCount = atoi(line);
//		for (int index = 0; index < edgeCount; index++)
//		{
//			in.getline(line, 1024);
//			string lineStr = line;
//			int delimiter = lineStr.find("|");
//			T from = (*fromString)(lineStr.substr(0, delimiter));
//			lineStr = lineStr.substr(delimiter + 1, lineStr.size() - delimiter - 1);
//			delimiter = lineStr.find("|");
//			T to = (*fromString)(lineStr.substr(0, delimiter));
//			lineStr = lineStr.substr(delimiter + 1, lineStr.size() - delimiter - 1);
//			int weight = atoi(lineStr.c_str());
//			addEdge(from, to, weight);
//		}
//		// close file
//		in.close();
//		cout << "Graph \"" << _name << "\" was sucessfully read from file \"" << fileName << "\"." << endl << endl;
//	}
//	else
//		cout << "Error during opening file \"" << fileName << "\"" << endl;
//}
//
//template <class T>
//void Graph<T>::writeToFile(char* fileName, string (*toString)(T vertex))
//{
//	ofstream out;
//	out.open(fileName);
//	if (out.is_open())
//	{
//		// main data
//		out << _name << endl;
//		out << ((_directed) ? "true" : "false") << endl;
//		out << ((_weighted) ? "true" : "false") << endl;
//		// vertexes data
//		out << _vertexVector.size() << endl;
//		for (int index = 0; index < (int)_vertexVector.size(); index++)
//			out << (*toString)(_vertexVector[index]) << endl;
//		// edges data
//		out << _edgeVector.size() << endl;
//		for (int index = 0; index < (int)_edgeVector.size(); index++)
//		{
//			out << (*toString)(_edgeVector[index].from) << "|" 
//				<< (*toString)(_edgeVector[index].to) << "|"
//				<< _edgeVector[index].weight << endl;
//		}
//		// close file
//		out.close();
//		cout << "Graph \"" << _name << "\" was saved to file \"" << fileName << "\"." << endl << endl;
//	}
//	else
//		cout << "Error during opening file \"" << fileName << "\"" << endl;
//}
