# Coinflip

- Pass this challenge by correctly guessing the outcome of the coinflip 10 times in a row

# Hints

- CoinFlip's flip function is _intended_ to randomly make the side variable either true or false
- Can you create similar logic in your attacking contract to correctly choose what the flip function will choose?
- You may add code on `AttackingCoinFlip`.sol and/or `CoinFlipHelper.ts` to help pass the tests in CoinFlip.test.ts

# Solution
The issue with `CoinFlip` is that it tries to generate "randomness" to determine
wether a coin toss results in head or tails.
But the paramaters it uses **are not random at all!**.

`uint256 coinFlip = blockValue / FACTOR`

If we could know the value of `coinFlip` ahead of time, we'll guess the correct value every time.

`FACTOR` is easy. The value is hardcoded in the contract and we can simply copy it.

`uint256 blockValue = uint256(blockhash(block.number - 1));`
This is the interesting part. `block.number` is the number of the block in which the tx is being included. This is not random either!

If our attacking contract function calls `flip(bool)`, `block.number` will be exactly the same in both functions.

This way we can easily calculate wether `side` is going to be `true` or `false` before calling `flip(bool)`.
