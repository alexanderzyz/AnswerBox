#ifndef QUEUE_H_
#define QUEUE_H_
#include <iostream>
#include "stack.h"

template <class T>
class Queue {
private:
    int length;
    Node<T>* front, * back;
public:
    Queue();
    Queue(Queue& other);
    ~Queue();
    Queue& operator=(Queue& other);
    int get_size() const;
    void push(T* t);
    void push(Node<T>* n);
    Node<T>* pop();
    void print();
    void print(Node<T>* n);
};

#include "queue.cpp"
#endif
