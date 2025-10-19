const fs = require('fs')
const bytes = fs.readFileSync(__dirname + '/number2string.wasm')

let mem = new WebAssembly.Memory({initial: 1})
let importObj = {
    env : {
        buffer: mem,
        print: (p,l) => {
            const b = new Uint8Array(mem.buffer,p,l)
            const s = new TextDecoder('utf8').decode(b)
            console.log(`${s}`)
        },        
    }
};

(async () => {
    let obj = await WebAssembly.instantiate( new Uint8Array(bytes), importObj)
    let num2strK = obj.instance.exports.num2strK
    const n = parseInt(process.argv[2]);
    const k = parseInt(process.argv[3]);
    num2strK(n,k)
})();