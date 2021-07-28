#!/bin/sh

if [ -z "$PAYMENT_ADDR" ]; then
  echo "PAYMENT_ADDR not defined"
  exit 1
fi

./packetcrypt ann -p "$WALLET_ADDR" "$POOL1" "$POOL2" "$POOL3" "$POOL4" 
