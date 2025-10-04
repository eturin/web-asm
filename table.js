const fs = require('fs')
const export_module_bytes = fs.readFileSync(__dirname + '/table_export.wasm')
const test_module_bytes = fs.readFileSync(__dirname + '/table_test.wasm')

let i = 0
const inc = () => {
    i += 1
    return i
}
const dec = () => {
    i -= 1
    return i
}
const importObject = {    
    js: {
        inc: inc,
        dec: dec,
        wasm_inc: null,
        wasm_dec: null,
        tbl: null,
    },
};

(async () => {
    let obj = await WebAssembly.instantiate(new Uint8Array(export_module_bytes), importObject);
    importObject.js.wasm_inc = obj.instance.exports.inc
    importObject.js.wasm_dec = obj.instance.exports.dec
    importObject.js.tbl = obj.instance.exports.tbl
    

    obj = await WebAssembly.instantiate(new Uint8Array(test_module_bytes), importObject);
    const {tbl_js, tbl_wasm, call_js, call_wasm} = obj.instance.exports;

    let start = Date.now();
    tbl_js();
    console.log(`tbl_js = ${Date.now() - start}`);

    start = Date.now();
    tbl_wasm();
    console.log(`tbl_wasm = ${Date.now() - start}`);

    start = Date.now();
    call_js();
    console.log(`call_js = ${Date.now() - start}`);

    start = Date.now();
    call_wasm();
    console.log(`call_wasm = ${Date.now() - start}`);
})();