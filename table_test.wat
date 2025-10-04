(module
    (import "js" "inc" (func $js_inc (result i32)))
    (import "js" "dec" (func $js_dec (result i32)))
    (import "js" "wasm_inc" (func $wasm_inc (result i32)))
    (import "js" "wasm_dec" (func $wasm_dec (result i32)))

    (import "js" "tbl" (table $tbl 4 anyfunc))
    (type $returns_i32 (func (result i32)))

    (global $i0 i32 (i32.const 0))
    (global $i1 i32 (i32.const 1))
    (global $i2 i32 (i32.const 2))
    (global $i3 i32 (i32.const 3))

    (func (export "tbl_js")
        (loop $a
            (call_indirect (type $returns_i32) (global.get $i0))
            i32.const 4_000_000
            i32.le_u
            br_if $a
        )

        (loop $b
            (call_indirect (type $returns_i32) (global.get $i1))
            i32.const 0
            i32.gt_u
            br_if $b
        )
    )

    (func (export "tbl_wasm")
        (loop $a
            (call_indirect (type $returns_i32) (global.get $i2))
            i32.const 4_000_000
            i32.le_u
            br_if $a
        )

        (loop $b
            (call_indirect (type $returns_i32) (global.get $i3))
            i32.const 0
            i32.gt_u
            br_if $b
        )
    )

    (func (export "call_js")
        (loop $a
            (call $js_inc)
            i32.const 4_000_000
            i32.le_u
            br_if $a
        )

        (loop $b
            (call $js_dec)
            i32.const 0
            i32.gt_u
            br_if $b
        )
    )

    (func (export "call_wasm")
        (loop $a
            (call $wasm_inc)
            i32.const 4_000_000
            i32.le_u
            br_if $a
        )

        (loop $b
            (call $wasm_dec)
            i32.const 0
            i32.gt_u
            br_if $b
        )
    )
)