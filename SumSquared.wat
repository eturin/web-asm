(module
    (func (export "SumSquared")
     (param $v1 i32)
     (param $v2 i32)
     (result i32)
     (local $sum i32)

     local.get $v1
     local.get $v2
     i32.add
        
     local.set $sum
     local.get $sum
     local.get $sum
     i32.mul
    )
)