require('colors');
const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/store_data.wasm');

const mem = new WebAssembly.Memory({initial: 1});
const addr = 32;
const cnt = 5;

const export_obj = {
    'env': {
        mem: mem,
        addr: addr,
        cnt: cnt,
    }
};

const mem_i32 = new Int32Array(mem.buffer);

(async () => {
    let obj = await WebAssembly.instantiate(bytes, export_obj);

    for (let i=addr/4; i < addr/4 + cnt; i+=1) {
        console.log(`${i} -> ${mem_i32[i]}`.green)
    }
    
})();