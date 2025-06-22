#include <stddef.h>
#include <stdint.h>

// Simple perceptron implementing logical OR
static float weights[2] = {0.5f, 0.5f};
static float bias = -0.2f;

static int perceptron(int x1, int x2) {
    float sum = x1 * weights[0] + x2 * weights[1] + bias;
    return sum > 0 ? 1 : 0;
}

extern void terminal_write(const char*);

void ai_demo(void) {
    int test[4][2] = { {0,0}, {0,1}, {1,0}, {1,1} };
    const char* msg[2] = { "0", "1" };
    for (int i = 0; i < 4; ++i) {
        int y = perceptron(test[i][0], test[i][1]);
        terminal_write("AI OR(");
        terminal_write(msg[test[i][0]]);
        terminal_write(", ");
        terminal_write(msg[test[i][1]]);
        terminal_write(") = ");
        terminal_write(msg[y]);
        terminal_write("\\n");
    }
}
