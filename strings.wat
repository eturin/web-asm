(module
    ;; Импортированная функция принимает позицию и длину
    (import "env" "str_pos_len" (func $str_pos_len (param i32 i32)))
    ;; Импорт функции принимающую только позицию
    (import "env" "null_ending_str" (func $null_ending_str (param i32)))
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

    (func (export "main")
        (call $str_pos_len (i32.const 256) (i32.const 30))
        (call $str_pos_len (i32.const 384) (i32.const 35))
        (call $null_ending_str (i32.const 0))
        (call $null_ending_str (i32.const 128))
    )
)
    
