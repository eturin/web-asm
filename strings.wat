(module
    ;; Импортированная функция принимает позицию и длину
    (import "env" "str_pos_len" (func $str_pos_len (param i32 i32)))
    ;; Импорт функции принимающую только позицию
    (import "env" "null_ending_str" (func $null_ending_str (param i32)))
    ;; Импорт функции принимающей только позицию (строка с префиксом длины)
    (import "env" "len_prefix" (func $len_prefix (param i32)))
    ;; Импортирование буфера памяти (к которому будет относиться позиция и длина)
    (import "env" "buffer" (memory 1))


    ;; Запись массива байт в импорированный буфер (строка завершается \0)
    (data (i32.const 0) "null-terminating string\00")
    ;; Запись массива байт в импорированный буфер (строка завершается \0)
    (data (i32.const 128) "another null-terminating string\00")
    ;; Запись массива байт в импортированный буфер (строка из 30 символов)
    (data (i32.const 256) "Know the length of this string")
    ;; Запись массива байт в импортированный буфер (строка из 35 символов)
    (data (i32.const 384) "Also know the length of this string")
    ;; запись массива байт в импортированный буфер (строки с префиксом длины)
    (data (i32.const 512) "\16length-prefixed string")
    (data (i32.const 640) "\1eanother length-prefixed string")
    ;; запись массива байт для проверки копирования
    (data (i32.const 700) "\0fHello, World!!!")

    
    (func $copy_by_bytes 
        (param $src i32) 
        (param $dst i32) 
        (param $len i32)

        (local $last i32)
        local.get $src
        local.get $len
        i32.add
        local.set $last

        
        (loop $continue
            (block $break
                local.get $dst    
                local.get $src
                i32.load8_u
                i32.store8

                local.get $src
                i32.const 1
                i32.add
                local.tee $src

                local.get $last
                i32.ge_u
                br_if $break

                local.get $dst
                i32.const 1
                i32.add
                local.set $dst
                br $continue
            )
        )        
    )

    (func $copy_by_8bytes 
        (param $src i32) 
        (param $dst i32) 
        (param $len i32)
        (result i32)

        (local $last i32)

        local.get $src
        
        local.get $src
        local.get $len
        i32.add
        local.set $last

        
        (loop $continue
            (block $break
                ;; проверка выхода
                local.get $src
                i32.const 8
                i32.add
                local.get $last
                i32.gt_u
                br_if $break

                ;; копирование
                local.get $dst    
                local.get $src
                i64.load
                i64.store

                ;; $src += 8
                local.get $src
                i32.const 8
                i32.add
                local.set $src                

                ;; $dst += 8
                local.get $dst
                i32.const 8
                i32.add
                local.set $dst
                br $continue
            )

        )

        local.get $src
        i32.sub        
    )

    (func $copy 
        (param $src i32) 
        (param $dst i32) 
        (param $len i32)

        (local $cnt i32)
        local.get $src 
        local.get $dst 
        local.get $len
        call $copy_by_8bytes
        local.tee $cnt

        local.get $src
        i32.add
        local.tee $src
    
        local.get $cnt
        local.get $dst
        i32.add
        local.tee $dst

        local.get $len
        local.get $cnt        
        i32.sub
        
        call $copy_by_bytes
    )

    (func (export "main")
        (call $str_pos_len (i32.const 256) (i32.const 30))
        (call $str_pos_len (i32.const 384) (i32.const 35))
        (call $null_ending_str (i32.const 0))
        (call $null_ending_str (i32.const 128))
        (call $len_prefix (i32.const  512))
        (call $len_prefix (i32.const  640))

        (call $copy (i32.const  700) (i32.const  800) (i32.const  16))
        (call $len_prefix (i32.const  700))
        (call $len_prefix (i32.const  800))
    )

)
    
