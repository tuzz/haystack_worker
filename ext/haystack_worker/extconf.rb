require 'mkmf'

find_header('ruby.h')
create_makefile('haystack_worker/haystack_worker')
