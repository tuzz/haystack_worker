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

  /* allocate a 2d array for surpluses */

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
      /* append to the 2d array, realloc as needed */
    }
  }

  /* pass the 2d array back to ruby */

  /* free the 2d array */
}
