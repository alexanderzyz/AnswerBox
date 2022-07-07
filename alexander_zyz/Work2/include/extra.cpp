#include <stack>
#include <queue>
int Compare_stack_queue(std::stack<int>* s, std::queue<int>* q);
int Compare_stack_queue(std::stack<int>* s, std::queue<int>* q)
{
    if (s->size() != q->size())
        return 0;
    else
        return 1;
}
