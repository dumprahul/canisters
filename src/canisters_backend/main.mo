import Array "mo:base/Array"; // Import Array utilitiess

actor IdeaStorage {

  // Define an Idea record structure
  type Idea = {
    id : Nat;
    name : Text;
    description : Text;
    problemStatement : Text;
    pptLink : Text;
  };

  // Stable array to store ideas
  stable var ideas : [Idea] = [];
  stable var ideaCount : Nat = 0;

  // Store a new idea with an auto-incremented ID
  public func storeIdea(name : Text, description : Text, problemStatement : Text, pptLink : Text) : async Nat {
    let newIdea : Idea = {
      id = ideaCount;
      name = name;
      description = description;
      problemStatement = problemStatement;
      pptLink = pptLink;
    };

    // Create a new array by appending the new idea (since arrays are immutable)
    ideas := Array.append<Idea>(ideas, [newIdea]);
    ideaCount += 1;

    // Return the assigned ID
    return newIdea.id;
  };

  // Get the total number of ideas stored
  public query func getIdeaCount() : async Nat {
    return ideaCount;
  };

  // Retrieve an idea by ID
  public query func getIdea(id : Nat) : async ?Idea {
    if (id < ideaCount) {
      return ?ideas[id];
    } else {
      return null;
    };
  };

  // Get all stored ideas
  public query func getAllIdeas() : async [Idea] {
    return ideas;
  };
};
