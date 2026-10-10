const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'jsencrypt.min.js');
let content = fs.readFileSync(filePath, 'utf-8');

// 将 window 替换为 globalThis，避免小程序中 window 为 undefined
content = content.replace(/\bwindow\b/g, 'globalThis');

fs.writeFileSync(filePath, content, 'utf-8');
console.log('Replaced window with globalThis in jsencrypt.min.js');
