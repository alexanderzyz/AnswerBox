#include "workflow.h"
#include "worker.h"
#include "vector.h"
#include <iostream>

Job::~Job() {
    num_job--;
}

Workflow::Workflow() {
    tail = NULL;
    head = NULL;
    size = 0;
}

Workflow::~Workflow() {
}

int Workflow::insert(Job *j) {
    try {
        if (j == NULL) throw 1; // Throw Error
        if (size)
        {
            tail->next = j;
            j->prev = tail;
            tail = j;
            size++;
        }
        else
        {
            head = j;
            tail = j;
            size = 1;
        }
        return 0;
    }
    catch (...) {
        return 1;
    }
}

int Workflow::swap(int original_index, int target_index) {
    try {
        if (original_index < 0 || original_index >= size || target_index < 0  || target_index >= size ) throw 1;// Throw Error
        if (target_index == original_index) return 0; // NULL DONE
        int a, b;
        a = b = 0;
        Job* op;
        Job* op1 = head, * op2 = head;
        while (a != original_index && a < size)
        {
            op1 = op1->next;
            a++;
        }
        while (b != target_index && b < size)
        {
            op2 = op2->next;
            b++;
        }
        op2->prev->next = op1;
        op2->next->prev = op1;
        op1->prev->next = op2;
        op1->next->prev = op2;
        op = op2->prev;
        op2->prev = op1->prev;
        op1->prev = op;
        op = op2->next;
        op2->next = op1->next;
        op1->next = op;
        return 0;
    }
    catch (...) {
        return 1;
    }
}

Job *Workflow::pop() {
    try {
        if (!size) throw 1;
        head = head->next;
        size--;
        return head->prev;
    }
    catch (...) {
        return NULL;
    }
}

int Workflow::process(vector *l, int index) {
    Worker* t = l->get(0);
    if (t == NULL || !size || index < 0 || index >= size)
        return 1;
    Job* j = head;
    l->remove(0);
    for (int i = 1; i <= index; i++)
        j = j->next;
    j->worker = t;
    return 0;
}
int Job::num_job = 0;
Job::Job() {
    id = num_job;
    num_job++;
    next = NULL;
    prev = NULL;
    worker = NULL;
}
int Workflow::print() {
    Job * curr = head;
    int i = 0;
    if (curr == NULL) {
        std::cout << "Empty Flow\n";
        return 0;
    }
    while (curr != NULL) {
        std::cout << "[" << i << "]";
        curr->print();
        i++;
        curr = curr->next;
    }
    return 0;
}
int Job::print() {
    std::cout << "job [" << this->id << "]\n";
    return 0;
}
