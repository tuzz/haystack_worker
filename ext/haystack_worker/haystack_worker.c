#include <ruby.h>
#include "lookup.h"
#include "macros.h"

static VALUE work(VALUE self, VALUE rb_ary) {
  int i, j, ranges[26][2];
  for (i = 0; i < 26; i++) {
    for (j = 0; j < 2; j++) {
      ranges[i][j] = FIX2INT(RARRAY_PTR(RARRAY_PTR(rb_ary)[i])[j]);
    }
  }

  int blocks = 16, position = 0, *array = NULL, bytes;

  YIELD_ATTEMPTS {
    int total[26] = {};
    for (i = 0; i < 26; i++) {
      for (j = 0; j < 26; j++) {
        total[j] += WORD_LOOKUP[attempt[i]][i][j];
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
          rb_raise(rb_eNoMemError, "Failed to allocate %d bytes", bytes);
        }
      }

      for (i = 0; i < 26; i++) {
        array[position + i] = attempt[i];
      }

      position += 26;
    }
  }

  if (position == 0) {
    return Qnil;
  }
  else {
    VALUE rb_solutions = rb_ary_new(), rb_solution;

    for (i = 0; i < position / 26; i++) {
      rb_solution = rb_ary_new();
      for (j = 0; j < 26; j++) {
        rb_ary_push(rb_solution, INT2FIX(array[i * 26 + j]));
      }
      rb_ary_push(rb_solutions, rb_solution);
    }

    free(array);
    return rb_solutions;
  }
}

void Init_haystack_worker(void) {
  VALUE klass = rb_define_class("HaystackWorker", rb_cObject);
  rb_define_singleton_method(klass, "_work", work, 1);
}
