(module
    (func $is_prime (export "is_prime") (param $n i32)
    (result i32)
        (local $d i32)

        ;; n < 2
        local.get $n
        i32.const 2
        i32.lt_s
        if 
            i32.const 0
            return
        end

        ;; n == 2
        local.get $n
        i32.const 2
        i32.eq
        if 
            i32.const 1
            return
        end

        ;; n % 2 == 0
        local.get $n
        i32.const 1
        i32.and
        i32.const 0 
        i32.eq
        if
            i32.const 0
            return
        end

        i32.const 3
        local.set $d
        

        (loop $continue
            ;; n % d == 0
            local.get $n
            local.get $d
            i32.rem_s
            i32.const 0 
            i32.eq
            if
               i32.const 0
               return
            end

            ;; d += 2
            local.get $d
            i32.const 2
            i32.add
            local.set $d
            
            ;; d*d > n
            local.get $d
            local.get $d
            i32.mul
            local.get $n
            i32.le_s
            br_if $continue
        )

        i32.const 1
    )
)