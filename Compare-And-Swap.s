.var mutex
.var ptr
.var expected
.var new

.main

.acquire
mov  $1, %ax        
xchg %ax, mutex     # atomic swap of 1 and mutex
test $0, %ax        # if we get 0 back: lock is free!
jne  .acquire       # if not, try again

# critical section
mov  ptr, %ax       # get the value at the address
test %ax, expected  # if (actual == expected)
jne  $1             # if not equal, should do nothing
mov  new, ptr       # if equal, ptr should be new

# release lock
mov  $0, mutex	

halt
