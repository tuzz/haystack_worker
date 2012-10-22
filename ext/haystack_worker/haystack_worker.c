#include <ruby.h>

static VALUE work(VALUE self, VALUE array) {
  int i, total = 0;
  for (i = 0; i < RARRAY_LEN(array); i++) {
    total += FIX2INT(RARRAY_PTR(array)[i]);
  }
  return INT2FIX(total);
}

void Init_haystack_worker(void) {
  VALUE klass = rb_define_class("HaystackWorker", rb_cObject);
  rb_define_singleton_method(klass, "work", work, 1);
}
