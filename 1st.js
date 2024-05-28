// create a variable to hold your NFTs
let nftCollection = [];

// this function will take in some values as parameters, create an
// NFT object using the parameters passed to it for its metadata, 
// and store it in the variable above.
function mintNFT(name, description, owner) {
    // Create the NFT object with the provided metadata
    const nft = {
        name: name,
        description: description,
        owner: owner,
        timestamp: new Date().toISOString()
    };

    // Store the NFT object in the nftCollection array
    nftCollection.push(nft);
}

// create a "loop" that will go through an "array" of NFTs
// and print their metadata with console.log()
function listNFTs() {
    // Loop through each NFT in the collection
    for (let i = 0; i < nftCollection.length; i++) {
        const nft = nftCollection[i];
        console.log("Name: " + nft.name);
        console.log("Description: " + nft.description);
        console.log("Owner: " + nft.owner);
        console.log("Timestamp: " + nft.timestamp);
        console.log("----------");
    }
}

// print the total number of NFTs we have minted to the console
function getTotalSupply() {
    return nftCollection.length;
}

// call your functions below this line

// Minting three NFTs
mintNFT("NFT 1", "This is the first NFT", "Anubhav");
mintNFT("NFT 2", "This is the second NFT", "Raghav");
mintNFT("NFT 3", "This is the third NFT", "priya");

// Listing all NFTs
listNFTs();

// Printing the total supply of NFTs
console.log("Total Supply: " + getTotalSupply());
