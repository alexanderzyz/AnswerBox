#include "stack.h"
#include <iostream>

template <class T>
Node<T>::Node() {
    ptr = NULL;
    next = NULL;
}

template <class T>
Node<T>::Node(Node<T>& other) {
    next = NULL;
    ptr = new T(*(other.ptr));
}

template <class T>
Node<T>& Node<T>::operator=(Node<T>& other) {
    next = NULL;
    ptr = new T(*(other.ptr));
    return *this;
}

template <class T>
Node<T>::Node(T* t) {
    ptr = t;
    next = NULL;
}

template <class T>
Node<T>::~Node() {
    if (ptr != NULL) {
        delete ptr;
    }
}

template <class T>
Node<T>* Node<T>::get_next() const {
    return next;
}

template <class T>
void Node<T>::set_next(Node<T>* n) {
    next = n;
    return;
}

template <class T>
void Node<T>::print() {
    std::cout << "[" << *ptr << "]->";
    return;
}

template <class T>
T* Node<T>::getptr() {
    return ptr;
}

/*
The whole stack was essentially a singlely linked list.
The 'Top' Node is actually
the head of the linked list.
*/

template <class T>
Stack<T>::Stack() {
    length = 0;
    top_ = NULL;
}

template <class T>
Stack<T>::Stack(Stack<T>& other) {
    length = other.length;
    if (other.top_ == NULL) {
        top_ = new Node<T>();
    }
    else {
        top_ = new Node<T>(*(other.top_));
        copy(this->top_, other.top_);
    }

}

template <class T>
Stack<T>& Stack<T>::operator=(Stack<T>& other) {
    length = other.length;
    if (other.top_ == NULL) {
        top_ = new Node<T>();
    }
    else {
        top_ = new Node<T>(*(other.top_));
        copy(this->top_, other.top_);
    }
    return *this;
}

template <class T>
Stack<T>::~Stack() {
    remove(top_);
}

template <class T>
T* Stack<T>::top() {
    if (length == 0) return NULL;
    return top_->getptr();
}

template <class T>
void Stack<T>::push(T* t) {
    if (t != NULL) {
        Node<T>* op = new Node<T>(t);
        if (length >= 1) {
            length++;
            op->set_next(top_);
            top_ = op;
        }
        else {
            top_ = op;
            length = 1;
        }
    }
    else return;
}

template <class T>
void Stack<T>::push(Node<T>* n) {
    if (n != NULL) {
        Node<T>* op = n;
        if (length >= 1) {
            length++;
            op->set_next(top_);
            top_ = op;
        }
        else {
            top_ = op;
            length = 1;
        }
    }
    else return;
}

template <class T>
Node<T>* Stack<T>::pop() {
    if (length >= 1) {
        Node<T>* op = top_;
        length--;
        top_ = top_->get_next();
        return op;
    }
    else return NULL;
}

template <class T>
int Stack<T>::get_size() const {
    return length;
}

template <class T>
void Stack<T>::print() const {
    Node<T>* p = top_;
    while (p != NULL) {
        p->print();
        p = p->get_next();
    }
    return;
}

template <class T>
void Stack<T>::copy(Node<T>* this_, Node<T>* other_) {
    if (other_->get_next() == NULL) {
        return;
    }
    this_->set_next(new Node<T>(*(other_->get_next())));
    copy(this_->get_next(), other_->get_next());
    return;
}

template <class T>
void Stack<T>::remove(Node<T>* n) {
    if (n == NULL) {
        return;
    }
    if (n->get_next() == NULL) {
        delete n;
        return;
    }
    Node<T>* tmp = n->get_next();
    delete n;
    remove(tmp);
    return;
}
