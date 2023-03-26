import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
final emulatorIp = '10.0.2.2:3000'; // 애뮬레이터는 '10.0.0.2' 가 localhost와 동일
final simulatorIp = '127.0.0.1:3000'; // 시뮬레이터는 localhost와 동일

// 어떤 OS에서 코드가 실행되는지 알 수 있는 메서드
final ip = Platform.isIOS ? simulatorIp : emulatorIp;