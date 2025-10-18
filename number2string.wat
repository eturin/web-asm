(module
    (import "env" "print" (func $print (param i32 i32)))
    (import "env" "buffer" (memory 1))

    ;; зависываем в импортированный буфер
    (data (i32.const 128) "0123456789abcdef")
    (data (i32.const 245) "               0")

    (func (export "num2str10") 
    (param $n i32) 
        (local $i i32 )
        i32.const 260
        local.set $i
        
        (loop $continue
            ;; индекс dst
            local.get $i
            
            ;; индекс src
            i32.const 128
            local.get $n
            i32.const 10
            i32.rem_u           
            i32.add
            
            ;; копирование символа цифры
            i32.load8_u
            i32.store8

            ;; n /= 10
            local.get $n
            i32.const 10
            i32.div_u
            local.set $n

            ;; i -= 1
            local.get $i
            i32.const 1
            i32.sub
            local.set $i

            ;; n != 0
            local.get $n
            i32.const 0
            i32.ne

            br_if  $continue
        )

        (call $print (i32.const 245) (i32.const 16))
    )
)