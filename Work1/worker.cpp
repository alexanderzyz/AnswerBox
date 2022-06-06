#include "worker.h"
#include <string>
#include <iostream>
Worker::Worker(std::string &input_name) {
    this->name=input_name;
    this->id=num_worker++;
}
int Worker::get_id() {
    return this->id;
}
std::string &Worker::get_name() {
    std::string user_name;
    user_name=this->name;
    return user_name;
}
int Worker::num_worker = 0;

Worker::Worker() { 
    this->id = num_worker;
    num_worker++;
    this->name = std::string("default_string");

}

Worker::~Worker() {
}

int Worker::print() {
    std::cout << "Worker [" << this->id << "] with name [" << (this->name) << "]\n";
    return 0;
}
