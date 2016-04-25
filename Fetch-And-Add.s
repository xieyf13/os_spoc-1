.var mutex
.var ptr

.main

.acquire
mov  $1, %ax        
xchg %ax, mutex     # atomic swap of 1 and mutex
test $0, %ax        # if we get 0 back: lock is free!
jne  .acquire       # if not, try again

# critical section
mov  ptr, %ax       # get the value at the address
add  $1, %ax
mov  %ax, ptr       # renew ptr
sub  $1, %ax        # set return value

# release lock
mov  $0, mutex	

halt
