import { encrypt } from './jsencrypt.js';

const password = '123456';
const encrypted = encrypt(password);

console.log('原始密码:', password);
console.log('加密后:', encrypted);
