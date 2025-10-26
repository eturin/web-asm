(module
    (import "env" "mem" (memory 1))
    (global $addr (import "env" "addr") i32)
    (global $cnt  (import "env" "cnt")  i32)

    (func $set_val (param i32 i32)
        global.get $addr
        local.get 0
        i32.const 4
        i32.mul
        i32.add
        local.get 1
        i32.store
    )

    (func $init
        (local $i i32)
                
        ;; if(cnt == 0) return;        
        global.get $cnt
        i32.eqz
        if return end

        ;; m[0] = 1;
        i32.const 0
        i32.const 1
        call $set_val
        
        ;; if(cnt == 1) return; 
        global.get $cnt
        i32.const 1
        i32.eq
        if return end

        ;; i = 1;
        i32.const 1
        local.set $i

        (loop $continue
            ;; set_val(i, i*5)
            local.get $i
            local.get $i
            i32.const 5
            i32.mul
            call $set_val

            ;; i += 1; if (i<cnt) continue;
            local.get $i
            i32.const 1
            i32.add
            local.tee $i
            global.get $cnt
            i32.lt_u
            br_if $continue
        )
    )

    (start $init) 
)