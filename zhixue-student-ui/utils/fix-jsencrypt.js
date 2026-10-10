const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'jsencrypt.min.js');
let content = fs.readFileSync(filePath, 'utf-8');

content = content.replace(/navigator\.appName/g, '"Netscape"');
content = content.replace(/navigator\.userAgent/g, '"Mozilla"');

fs.writeFileSync(filePath, content, 'utf-8');
console.log('Fixed jsencrypt.min.js');
