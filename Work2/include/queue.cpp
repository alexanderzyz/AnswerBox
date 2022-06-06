#include "queue.h"
#include <iostream>
template <class T>
Queue<T>::Queue() {
    front = NULL;
    back = NULL;
    length = 0;
}

template <class T>
Queue<T>::Queue(Queue& other) {
    length = other.length;
    if (other.front == NULL) front = new Node<T>();
    else {
        front = new Node <T>(*(other.front));//deep copy
        Node<T>* op = front;
        Node<T>* ox = other.front;
        while (ox->get_next() != NULL) {
            op->set_next(new Node<T>(*(ox->get_next())));//need new
            op = op->get_next();
            ox = ox->get_next();
        }
        op = front;
        while (1) { // search *back
            if (op->get_next() == NULL) {
                back = op;
                break;
            }
            op = op->get_next();
        }
    }
    return;
}

template <class T>
Queue<T>::~Queue() {
    Node<T>* op = front;
    Node<T>* op_next = NULL;
    while (op != NULL) {
        if (op->next != NULL) {
            op_next = op->get_next();
        }
        else {
            delete op;
            break;
        }
        delete op;
        op = op_next;
    }
    return;
}

template <class T>
Queue<T>& Queue<T>::operator=(Queue& other) {
    *this(other);
    return *this;
}

template <class T>
int Queue<T>::get_size() const {
    return length;
}

template <class T>
void Queue<T>::push(T* t) {
    if (t != NULL) {
        Node<T>* op = new Node<T>(t);
        if (length == 0) {
            length++;
            front = op;
            back = op;
        }
        else {
            length++;
            back->next = op;
            back = back->next;
        }
    }
    return;
}

template <class T>
void Queue<T>::push(Node<T>* n) {
    if (n != NULL) {
        if (length == 0) {
            length++;
            front = n;
            back = n;
        }
        else {
            length++;
            back->next = n;
            back = back->next;
        }
    }
    return;
}

template <class T>
Node<T>* Queue<T>::pop() {
    if (length == 0) return NULL;
    Node<T>* op = front;
    length--;
    front = front->next;
    return op;
}

template <class T>
void Queue<T>::print(Node<T>* n)
{
    if (n->next != NULL)
    {
        print(n->next);
    }
    n->print();
    return;
}
template <class T>
void Queue<T>::print()
{
    Node<T>* p = front;
    print(p);
    std::cout << "END\n";
    return;
}