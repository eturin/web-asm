(module
    (memory 1)
    
    (func $init 
      i32.const 0
      i32.const 99
      i32.store
    )

    (func (export "get_ptr") 
    (result i32)
        i32.const 0
        i32.load        
    )

    (start $init)
)