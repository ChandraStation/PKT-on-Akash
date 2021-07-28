#!/bin/sh

if [ -z "$PAYMENT_ADDR" ]; then
  echo "PAYMENT_ADDR not defined"
  exit 1
fi

./packetcrypt ann -p "$PAYMENT_ADDR" http://pool.pktpool.io http://pool.pkt.world http://pool.pkteer.com
