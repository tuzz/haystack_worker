#include <stdlib.h>
#include <stdio.h>

#include "lookup.h"
#include "macros.h"

int main() {
  /* ranges will be passed in through Ruby FFI */
  int ranges[26][2] = {
    {1,1},{1,1},{1,1},{1,1},{1,1},{1,1},{1,1},
    {1,1},{1,1},{1,1},{1,1},{1,1},{1,1},{1,1},
    {1,1},{1,1},{1,1},{1,1},{1,1},{1,1},{1,1},
    {1,1},{1,1},{1,1},{1,1},{1,1}
  };

  int blocks = 16, position = 0, *array = NULL, bytes;

  YIELD_ATTEMPTS {
    int i, j, total[26] = {};
    for (i = 0; i < 26; i++) {
      for (j = 0; j < 26; j++) {
        total[j] += LOOKUP[attempt[i]][i][j];
      }
    }

    int satisfiable = 1, surplus[26];
    for (i = 0; i < 26; i++) {
      surplus[i] = attempt[i] - total[i];
      if (surplus[i] < 0) {
        satisfiable = 0;
        break;
      }
    }

    if (satisfiable) {
      if (position + 26 > blocks) {
        blocks *= 2, bytes = blocks * sizeof(int);
        array = realloc(array, bytes);

        if (array == NULL) {
          printf("Failed to allocate %d bytes.", bytes);
          /* raise a Ruby exception */
        }
      }

      for (i = 0; i < 26; i++) {
        array[position + i] = attempt[i];
      }

      position += 26;
    }
  }

  if (position == 0) {
    /* pass nil back to Ruby */
  }
  else {
    /* pass the array back to Ruby */
    free(array);
  }
}
