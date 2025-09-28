const fs = require('fs');
const bytes = fs.readFileSync('./loop.wasm');
let global_test = null;

let importObject = {    
    env: {
        log: (i,f) => { console.log(`${i}! = ${f}`)},
    },
};

(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
    ({loop_test: factorial} = obj.instance.exports);
    const n = parseInt(process.argv[2]);
    factorial(n);
})();