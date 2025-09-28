(module
    (import "js" "f" (func $js_f (result i32)))
    (global $i (mut i32) (i32.const 0))

    (func $g (result i32)
        global.get $i
        i32.const 1
        i32.add
        global.set $i
        global.get $i
    )

    (func (export "w_f1")
       (loop $continue
            call $g
            i32.const 400_000_000
            i32.lt_u
            br_if $continue
       )
    )

    (func (export "w_f2")
       (loop $continue
            call $js_f
            i32.const 400_000_000
            i32.lt_u
            br_if $continue
       )
    )
)