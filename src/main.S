.syntax unified

.global main
.global EXTI0_IRQHandler
.global EXTI1_IRQHandler
.global EXTI15_10_IRQHandler
.include "libcomp2300/macros.S"
.type EXTI1_IRQHandler, %function
.type main, %function
main:
  @ enable SYSCFG clock
  RCC_APB2ENR_set 0
  @ turn on the clock for GPIO ports B and E
  GPIOx_clock_enable B
  GPIOx_clock_enable E
  @ turn on the clock for GPIO ports A for joystick
  GPIOx_clock_enable A
  @ GPIOx_clock_enable D

  GPIO_configure_output_pin B, 2 @ (red LED)
  GPIO_configure_output_pin E, 8 @ (green LED)


  @ GPIO_configure_input_pin A, 0 @ (central joystick button)
  @ GPIO_configure_input_pin A, 1

@exercise 2
  GPIO_configure_input_pin_it A, 0
  @ GPIO_configure_input_pin_it A, 1
  @ GPIO_configure_input_pin_it A, 5
  EXTI_set_rising_edge_trigger 0
  @ EXTI_set_rising_edge_trigger 1
  EXTI_set_falling_edge_trigger 0
  @ EXTI_set_falling_edge_trigger 1
  @ EXTI_set_falling_edge_trigger 5
  NVIC_set ISER 6
  @ NVIC_set ISER 7
  @ NVIC_set ISER 23
  NVIC_set ISER 40

  

  @ poll_gpio:
  @ @ read PA0, set flags based on result
  @ GPIOx_IDR_read A, 0
  @ beq gotored
  @ GPIOx_IDR_read A, 1
  @ @ do something based on the flags in here
  @ bne gotogreen
  @ b poll_gpio

  @ gotored:
  @ GPIOx_ODR_toggle B, 2
  @ EXTI_PR_clear_pending
  @ b poll_gpio
  
  @ gotogreen:
  @ GPIOx_ODR_toggle E, 8
  @ EXTI_PR_clear_pending
  @ b poll_gpio


@ @exercise 3

  GPIO_configure_output_pin B, 7
  GPIO_configure_input_pin_it E, 13
@   GPIO_configure_output_pin E, 14
  
@   GPIO_configure_input_pin_it D, 0

  EXTI_set_rising_edge_trigger 13
  EXTI_set_falling_edge_trigger 13

loop:
  nop
  b loop

.type EXTI0_IRQHandler, %function
EXTI0_IRQHandler:
  push {lr}
  GPIOx_ODR_toggle B, 7
  EXTI_PR_clear_pending 0
  pop {lr}
  bx lr

.type EXTI15_10_IRQHandler, %function
EXTI15_10_IRQHandler:
  push {lr}
  GPIOx_ODR_toggle E, 8
  EXTI_PR_clear_pending 13
  pop {lr}
  bx lr
@ .type EXTI9_5_IRQHandler, %function
@ EXTI9_5_IRQHandler:
@   push {lr}
@   GPIOx_ODR_toggle E, 8
@   EXTI_PR_clear_pending 7
@   pop {lr}
@   bx lr
@ @
@ .type EXTI1_IRQHandler, %function
@ EXTI1_IRQHandler:
@   push {lr}
@   GPIOx_ODR_toggle E, 14
@   EXTI_PR_clear_pending 1
@   pop {lr}
@   bx lr
@ PE14->PE13
@ PE13->PE13

@ .type EXTI0_IRQHandler, %function
@ EXTI0_IRQHandler:
@   push {lr}
@   GPIOx_ODR_toggle B, 2
@   EXTI_PR_clear_pending 0
@   pop {lr}
@   bx lr

@ .type EXTI1_IRQHandler, %function
@ EXTI1_IRQHandler:
@   push {lr}
@   GPIOx_ODR_toggle E, 8
@   EXTI_PR_clear_pending 1
@   pop {lr}
@   bx lr

@ EXTI9_5_IRQHandler:
@   push {lr}
@   GPIOx_ODR_toggle E, 8
@   EXTI_PR_clear_pending 5
@   pop {lr}
@   bx lr
.size main, .-main
