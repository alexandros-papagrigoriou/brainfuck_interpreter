#include "args.h"
#include "bf.h"
#include "comma_input.h"
#include "input.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    char *input_file = check_args(argc, argv);

    size_t comma_counter = 0;
    char *code = read_bf_code(input_file, &comma_counter);

    printf("Clean input (commands only):\n");
    printf("%s\n\n", code);

    get_comma_inputs(comma_counter);

    run_bf_code(code, comma_counter);

    free_comma_inputs(comma_counter);
    free(code);

    return 0;
}
