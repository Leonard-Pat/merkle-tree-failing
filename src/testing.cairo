use alexandria_merkle_tree::merkle_tree::{
    Hasher, MerkleTree, MerkleTreeImpl, poseidon::PoseidonHasherImpl, pedersen::PedersenHasherImpl,
    MerkleTreeTrait,
};

// use testing::merkle::{ Hasher, MerkleTree, MerkleTreeImpl, poseidon::PoseidonHasherImpl, pedersen::PedersenHasherImpl,
//     MerkleTreeTrait,};


#[test]
#[available_gas(500000000)]
fn merkle_tree_pedersen_test() {
    let mut merkle_tree: MerkleTree<Hasher> = MerkleTreeImpl::<_, PedersenHasherImpl>::new();
    let root = 0x52b3ebb5e8000e0f4eb35d586be43833503e52a9c660e39a5cd9ea80a4d075f;
    let leaf = 0x501a3a8e6cd4f5241c639c74052aaa34557aafa84dd4ba983d6443c590ab7df;
    let valid_proof = array![0x7a9eccfe79938eb610b27589c116c24551e1ac1d72de7a93456a11a2a3a858e]
        .span();

    // [Assert] Compute merkle root.
    let computed_root = MerkleTreeImpl::<
        _, PedersenHasherImpl
    >::compute_root(ref merkle_tree, leaf, valid_proof);
    assert(computed_root == root, 'compute valid root failed');

    // [Assert] Verify a valid proof.
    let result = MerkleTreeImpl::<
        _, PedersenHasherImpl
    >::verify(ref merkle_tree, root, leaf, valid_proof);
    assert(result, 'verify valid proof failed');
}

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
