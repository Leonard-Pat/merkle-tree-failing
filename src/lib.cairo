use alexandria_merkle_tree::merkle_tree::{
    Hasher, MerkleTree, MerkleTreeImpl, poseidon::PoseidonHasherImpl, MerkleTreeTrait,
};

#[test]
#[available_gas(500000000)]
fn merkle_tree_poseidon_test() {
    // [Setup] Merkle tree.
    let mut merkle_tree: MerkleTree<Hasher> = MerkleTreeImpl::<_, PoseidonHasherImpl>::new();
    let root = 0x52b3ebb5e8000e0f4eb35d586be43833503e52a9c660e39a5cd9ea80a4d075f;
    let leaf = 0x501a3a8e6cd4f5241c639c74052aaa34557aafa84dd4ba983d6443c590ab7df;
    let valid_proof = array![0x7a9eccfe79938eb610b27589c116c24551e1ac1d72de7a93456a11a2a3a858e]
        .span();

    let result = MerkleTreeImpl::<
        _, PoseidonHasherImpl
    >::verify(ref merkle_tree, root, leaf, valid_proof);
    assert(result, 'verify valid proof failed');

    // [Assert] Compute merkle root.
    let computed_root = MerkleTreeImpl::<
        _, PoseidonHasherImpl
    >::compute_root(ref merkle_tree, leaf, valid_proof);
    // computer root: 0x05722f41b2b7aa2530309c954e868fd76f5f83abb6a3ad31475c9cfa0482aaa6
    assert(computed_root == root, 'compute valid root failed');
}
