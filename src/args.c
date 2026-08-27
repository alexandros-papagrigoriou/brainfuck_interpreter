#include "args.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void usage_message(const char *bfi) {
    printf("Usage: %s [filename]\n", bfi);
    printf("If no filename is given, stdin is used.\n");
}

char *check_args(int argc, char *argv[]) {
    if (argc < 2) {
        return NULL;
    }

    if (argc > 2) {
        usage_message(argv[0]);
        exit(EXIT_FAILURE);
    }

    if (strcmp(argv[1], "--help") == 0) {
        usage_message(argv[0]);
        exit(EXIT_SUCCESS);
    }

    return argv[1];
}
