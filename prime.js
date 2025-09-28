const fs = require('fs');
const bytes = fs.readFileSync('./prime.wasm');


(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(bytes));
    const { is_prime } = obj.instance.exports;
    const n = parseInt(process.argv[2]);
    
    const r = is_prime(n);
    console.log(`${n} - ${r ? "простое" : "составное"}`);
})();