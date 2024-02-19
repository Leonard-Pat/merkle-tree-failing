import { hash, merkle } from "starknet";

const raw = [
  [0x1, 0x2],
  [0x1, 0x3],
];

const leaves = raw.map((leaf) => hash.computePoseidonHashOnElements(leaf));

const merkleTree = new merkle.MerkleTree(leaves, hash.computePoseidonHash);
const merkleRoot = merkleTree.root;
const proofLeaf0 = merkleTree.getProof(leaves[0]);

console.log("merkle root", merkleRoot);
console.log("Leaf 1", leaves[0]);
console.log("proof", proofLeaf0);
console.log(
  "Verify",
  merkle.proofMerklePath(
    merkleRoot,
    leaves[0],
    proofLeaf0,
    hash.computePoseidonHash
  )
);
