use alexandria_merkle_tree::merkle_tree::{
    Hasher, MerkleTree, MerkleTreeImpl, poseidon::PoseidonHasherImpl, MerkleTreeTrait,
};

#[test]
#[available_gas(500000000)]
fn merkle_tree_poseidon_test() {
    // [Setup] Merkle tree.
    let mut merkle_tree: MerkleTree<Hasher> = MerkleTreeImpl::<_, PoseidonHasherImpl>::new();
    let root = 0x6ad36632fa7767dfb38908760fee605b083aa5205d9cbbc5abfc5b8c09dca5;
    let leaf = 0x371cb6995ea5e7effcd2e174de264b5b407027a75a231a70c2c8d196107f0e7;
    let valid_proof = array![0x306d0231b41f3ab3d4925eab31f8dbbb41e019d1ece7499781666361a0c71fd]
        .span();

    let result = MerkleTreeImpl::<
        _, PoseidonHasherImpl
    >::verify(ref merkle_tree, root, leaf, valid_proof);
    assert(result, 'verify valid proof failed');

    // [Assert] Compute merkle root.
    let computed_root = MerkleTreeImpl::<
        _, PoseidonHasherImpl
    >::compute_root(ref merkle_tree, leaf, valid_proof);
    // computer root: 0x0164ea3922e104567b9713add1d24e654092eacfaacac28f576411c9569ef266
    println!("{}", computed_root);
    assert(computed_root == root, 'compute valid root failed');
}
