import { hash, merkle } from "starknet";

const raw = [
  [0x1, 0x2],
  [0x1, 0x3],
];

function poseidonMerkleTree() {
  const leaves = raw.map((leaf) => hash.computePoseidonHashOnElements(leaf));

  const merkleTree = new merkle.MerkleTree(leaves, hash.computePoseidonHash);
  const merkleRoot = merkleTree.root;
  const proofLeaf0 = merkleTree.getProof(leaves[0]);

  console.log("Poseidon Merkle Root - POSEIDON", merkleRoot);
  console.log("Leaf 0 - POSEIDON", leaves[0]);
  console.log("Proof 0 - POSEIDON", proofLeaf0);
  console.log(
    "Verify",
    merkle.proofMerklePath(
      merkleRoot,
      leaves[0],
      proofLeaf0,
      hash.computePoseidonHash
    )
  );
}

function pedersenMerkleTree() {
  const leaves = raw.map((leaf) => hash.computePedersenHashOnElements(leaf));

  const merkleTree = new merkle.MerkleTree(leaves);
  const merkleRoot = merkleTree.root;
  const proofLeaf0 = merkleTree.getProof(leaves[0], merkleTree.leaves);

  console.log("Poseidon Merkle Root - PEDERSEN", merkleRoot);
  console.log("Leaf 0 - PEDERSEN", leaves[0]);
  console.log("Proof 0 - PEDERSEN", proofLeaf0);
  console.log(
    "Verify",
    merkle.proofMerklePath(merkleRoot, leaves[0], proofLeaf0)
  );
}

poseidonMerkleTree();
pedersenMerkleTree();
