# modem-restart-script
This script checks the modem's status and restarts it if necessary.

## requirements
 * bash
 * curl
 * sed

## usage
```
*/5 * * * * /bin/bash /path/to/modemCheck.sh
```

## supported devices
 * Motorola SB6141
