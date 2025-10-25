const fs = require('fs');
const bytes = fs.readFileSync('./mem.wasm');
//const mem = new WebAssembly.Memory({initial: 2 /*, maximum: 4*/});

/*const import_obj = {
    env: {
        mem: mem,
    }
};


mem.grow(10);*/

(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes), {} /*import_obj*/);
    let ptr = obj.instance.exports.get_ptr();
    console.log(ptr)
})();