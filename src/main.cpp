#include "ui.h"
#include "processing.h"

int main(int /*argc*/, char **/*argv*/)
{
    UI ui;
    ui.init();
    ui.show();

    Processing p;
    p.process();
    p.getData();

    return 1;
}
