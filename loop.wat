(module
    (import "env" "log" (func $log (param i32 i32)))

    (func $loop_test (export "loop_test") (param $n i32)
    (result i32)

        (local $i         i32)
        (local $factorial i32)
        i32.const 1
        local.set $factorial
        i32.const 0
        local.set $i 

        (loop $continue
            (block $break
                local.get $i
                i32.const 1
                i32.add
                local.set $i

                local.get $i
                local.get $factorial
                i32.mul
                local.set $factorial

                local.get $i
                local.get $factorial
                call $log

                local.get $i
                local.get $n
                i32.eq

                br_if $break
                br $continue
            )
        )

        local.get $factorial
    )
)