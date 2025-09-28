const fs = require('fs');
const bytes = fs.readFileSync('./perf_call.wasm');
let i = 0;

let importObject = {    
    js: {
        f: () => { i += 1; return i},
    },
};


(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
    const {w_f1, w_f2} = obj.instance.exports;
    let start = Date.now();
    w_f1();
    console.log(`${Date.now() - start}`);

    start = Date.now();
    w_f2();
    console.log(`${Date.now() - start}`);
})();