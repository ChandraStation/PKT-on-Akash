#!/bin/sh

if [ -z "$PAYMENT_ADDR" ]; then
  echo "PAYMENT_ADDR not defined"
  exit 1
fi

exec ./target/release/packetcrypt ann -p "$PAYMENT_ADDR" http://pool.pkt.world http://pool.pkteer.com http://pool.srizbi.com
