## Command server for ESP8266.

This library will allow you to add TCP command server to your ESP8266.
The user API is just four functions:

Function                |Description
------------------------|-----------
`esp_cmd_start`         | Start the server.
`esp_cmd_reg_cb`        | Register your command handler.
`esp_cmd_stop`          | Stop the server.
`esp_cmd_schedule_stop` | Schedule server stop.
`esp_cmd_block`         | Block further connections.

The `esp_cmd_schedule_stop` should be used if you want to stop the server from 
`espconn` callback, see the [example program](example/main.c).

You can turn on debug mode by defining ESP_CMD_DEBUG_ON 1 or changing it 
in `esp_cmd.h` 

## Build environment.

This library is part of my build system for ESP8266 based on CMake.
To compile / flash examples you will have to have the ESP development 
environment setup as described at https://github.com/rzajac/esp-dev-env.

## Build and flash the example.

Edit `example/include/user_config.h` to put your access point connection 
details then do:

```
$ cd build
$ cmake ..
$ make cmd_example_flash
$ miniterm.py /dev/ttyUSB0 74880
```

If everything goes well you should see messages like:

```
connected with AccessPoint, channel 1
dhcp client start...
wifi event: EVENT_STAMODE_CONNECTED
ip:192.168.1.116,mask:255.255.255.0,gw:192.168.1.1
got IP: 192.168.1.116
msk IP: 255.255.255.0
pm open,type:2 0
``` 

In another console issue:

```
$ echo -n 'test' | nc 192.168.1.116 7802
OK
```

Back in ESP8266 console you should see something like this:

```
CMD DBG: CONN: 192.168.1.149:34146
Received command (1): test
CMD DBG: REC: test (4)
CMD DBG: SENT: 192.168.1.149:34146
CMD DBG: DISC: 192.168.1.149:34146
```

Sending the test command twice will close the server and your test messages 
will no longer return `OK`.

## Integration.

If you're using my build environment you can install this library by issuing:

```
$ wget -O - https://raw.githubusercontent.com/rzajac/esp-cmd/master/install.sh | bash
```

or if you already cloned this repository you can do:

```
$ cd build
$ cmake ..
$ make
$ make install
```

which will install the library, headers and scripts in appropriate places 
in `$ESPROOT`.

## TODO

Unfortunately stopping the server does not close the port. Esp keeps it open which can be checked with:

```
$ nc -w 2 -v 192.168.1.116 7802 </dev/null
Connection to 192.168.1.116 7802 port [tcp/*] succeeded!
```

## License.

[Apache License Version 2.0](LICENSE) unless stated otherwise.
