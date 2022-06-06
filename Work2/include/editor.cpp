#include "stack.h"
#include "queue.h"
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>

Stack<std::string>* history;

Stack<std::string>* tmp;

int resume();
int undo();

int resume()
{
    if (tmp == NULL)
    {
        tmp = new Stack<std::string>();
        return 0;
    }
    if (history == NULL)
    {
        history = new Stack<std::string>();
        return 0;
    }
    if (tmp->get_size())
        history->push(tmp->pop());

    return 0;
}

int undo()
{
    if (tmp == NULL)
    {
        tmp = new Stack<std::string>();
        return 0;
    }
    if (history == NULL)
    {
        history = new Stack<std::string>();
        return 0;
    }
    if (history->get_size())
        tmp->push(history->pop());
    return 0;
}
