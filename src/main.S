.syntax unified

.global main

.include "libcomp2300/macros.S"

.type main, %function
main:
  @ enable SYSCFG clock
  RCC_APB2ENR_set 0
  @ turn on the clock for GPIO ports B and E
  GPIOx_clock_enable B
  GPIOx_clock_enable E

loop:
  nop
  b loop
.size main, .-main
