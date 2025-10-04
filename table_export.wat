(module
    (import "js" "inc" (func $js_inc (result i32)))
    (import "js" "dec" (func $js_dec (result i32)))

    
    (global $i (mut i32) (i32.const 0))
    (func $inc (export "inc") (result i32)
        global.get $i
        i32.const 1
        i32.add

        global.set $i
        global.get $i
    )
    (func $dec (export "dec") (result i32)
        global.get $i
        i32.const 1
        i32.sub

        global.set $i
        global.get $i
    )

    (table $tbk (export "tbl") 4 anyfunc)
    (elem (i32.const 0) $js_inc $js_dec $inc $dec)
    ;; (elem (i32.const 1) $js_dec $inc) ;; только два элемента в середине
)