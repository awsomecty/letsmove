module task2::greenjoee_coin {
    use sui::coin;
    use sui::coin::{TreasuryCap};
    use sui::transfer::{public_transfer, public_freeze_object};

    public struct GREENJOEE_COIN has drop{}
    fun init(witness: GREENJOEE_COIN, ctx: &mut TxContext){
        let (treasuryCap, denyCap ,metadata) = coin::create_regulated_currency(
            witness,
            8,
            b"GREENJOEE",
            b"GREENJOEE Coin",
            b"move coin",
            option::none(),
            ctx
        );
        public_transfer(treasuryCap, tx_context::sender(ctx));
        public_transfer(denyCap, tx_context::sender(ctx));
        public_freeze_object(metadata);
    }

    public entry fun mint(cap: &mut TreasuryCap<GREENJOEE_COIN>, amount: u64, recipient: address, ctx: &mut TxContext){
        let coin = coin::mint(cap, amount, ctx);
        public_transfer(coin, recipient);
    }
}