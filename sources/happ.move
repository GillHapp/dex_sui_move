module dex::happ {
use std::option;
use sui::url;
use sui::transfer;
use sui::coin;
use sui::tx_context::{Self, TxContext};

public struct HAPP has drop {}
fun init(witness: HAPP, ctx: &mut TxContext) {
  let (treasury_cap, metadata) = coin::create_currency<HAPP>(
    witness,
    9,
    b"HAPP",
    b"HAPP Coin",
    b"Ethereum Native Coin",
    option::some(url::new_unsafe_from_bytes(b"https://www.cryptologos.cc/logos/hedera-hbar-logo.png?v=040")),
    ctx
  );

  transfer::public_transfer(treasury_cap, tx_context::sender(ctx));

  transfer::public_share_object(metadata);
}


  #[test_only]
  public fun init_for_testing(ctx: &mut TxContext) {
    init(HAPP {}, ctx);
  }
}