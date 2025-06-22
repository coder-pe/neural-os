#include <stddef.h>
#include <stdint.h>

// Estructura para representar un perceptrón
typedef struct {
    float weights[2];
    float bias;
    const char* name;
} Perceptron;

// Perceptrones para diferentes compuertas lógicas
static Perceptron perceptrons[] = {
    {{0.5f, 0.5f}, -0.2f, "OR"},    // OR
    {{0.5f, 0.5f}, -0.7f, "AND"},   // AND
    {{-1.0f, -1.0f}, 0.5f, "NAND"}, // NAND
    {{-1.0f, -1.0f}, 1.5f, "NOR"},  // NOR
    {{1.0f, -1.0f}, -0.5f, "XOR"}   // XOR (nota: esto no funcionará perfectamente)
};

static int activate(float sum) {
    return sum > 0 ? 1 : 0;
}

static int run_perceptron(const Perceptron* p, int x1, int x2) {
    float sum = x1 * p->weights[0] + x2 * p->weights[1] + p->bias;
    return activate(sum);
}

extern void terminal_write(const char*);

void ai_demo(void) {
    int test_cases[4][2] = {{0,0}, {0,1}, {1,0}, {1,1}};
    const char* msg[2] = {"0", "1"};
    
    // Probar cada perceptrón
    for (size_t p = 0; p < sizeof(perceptrons)/sizeof(perceptrons[0]); p++) {
        Perceptron* perc = &perceptrons[p];
        terminal_write("\nTesting ");
        terminal_write(perc->name);
        terminal_write(" gate:\n");
        
        for (int i = 0; i < 4; i++) {
            int y = run_perceptron(perc, test_cases[i][0], test_cases[i][1]);
            
            terminal_write("  ");
            terminal_write(perc->name);
            terminal_write("(");
            terminal_write(msg[test_cases[i][0]]);
            terminal_write(", ");
            terminal_write(msg[test_cases[i][1]]);
            terminal_write(") = ");
            terminal_write(msg[y]);
            terminal_write("\n");
        }
    }
    
    // Mostrar advertencia sobre XOR
    terminal_write("\nNote: Single-layer perceptron cannot solve XOR perfectly.\n");
    terminal_write("This demonstrates the need for multi-layer networks.\n");
}