So you want to run a cryptoescudo full node on Android? So did i :D

Install UserLAnd from Play store on Android device (tested on Huawei P20 Lite)


On UserLAnd:
 1- Create a file system:
  File system name: cesc
  User: cescudo
  Pass: 1111 (use other, this one i used for tests)
  VNX pass: 12345678 (use other, this one i used for tests)
  File system: Debian
  Save 
  
 2- Create a session:
  Session name: cescudo
  File system: cesc:Debian
  User: cescudo (predefined)
  Save
  
 3 - Click on session created in step 2 to ssh to debian (wait for file system creation on 1st time)
 
 4 - Input password you defined on step 1, You are in Debian OS
 
To build cryptoescudo, and start daemon and chain sync type this command:

 bash <(curl -s https://raw.githubusercontent.com/VDamas/cryptoescudo/master/doc/build-debian-userland-script.txt)
 
or if you are working in your LAN and have a computer and android on same LAN you can ssh from laptop and paste command above:
 1 - On debian, type command: ip addr, you should find a local LAN address like 192.168.* 
 2 - On you computer ssh to the Ip found in previous step with port 2022, autenticate yourself, and paste 
 
 bash <(curl -s https://raw.githubusercontent.com/VDamas/cryptoescudo/master/doc/build-debian-userland-script.txt)
 
Done, you shoud have a running Cryptoescudo full node
