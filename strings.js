const fs = require('fs')
const bytes = fs.readFileSync(__dirname + '/strings.wasm')

let mem = new WebAssembly.Memory({initial: 1})
let importObj = {
    env : {
        buffer: mem,
        str_pos_len: (p,l) => {
            const b = new Uint8Array(mem.buffer,p,l)
            const s = new TextDecoder('utf8').decode(b)
            console.log(`${s}`)
        },
        null_ending_str: (p) => {
            let b = new Uint8Array(mem.buffer,p)
            let l = 0;
            while (b[l] !== 0) l++;
            b = new Uint8Array(mem.buffer,p,l)
            const s = new TextDecoder('utf8').decode(b)
            console.log(`${s}`)
        },
        len_prefix: (p) => {
            const l = new Uint8Array(mem.buffer,p,1)[0]
            const b = new Uint8Array(mem.buffer,p+1,l)
            const s = new TextDecoder('utf8').decode(b)
            console.log(`${s}`)
        }

    }
};

(async () => {
    let obj = await WebAssembly.instantiate( new Uint8Array(bytes), importObj)
    let main = obj.instance.exports.main
    main()
})();