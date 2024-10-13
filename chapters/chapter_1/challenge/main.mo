import Buffer "mo:base/Buffer";

actor class DAO() {
    let name : Text = "Actually Matters DAO";
    var manifesto : Text = "Making sure that the DAO actually matters to everyone in the world";
    var goals : Buffer.Buffer<Text> = Buffer.Buffer<Text>(0);

    public shared query func getName() : async Text {
        return name;
    };

    public shared query func getManifesto() : async Text {
        return manifesto;
    };

    public func setManifesto(newManifesto : Text) : async () {
        manifesto := newManifesto;
    };

    public func addGoal(newGoal : Text) : async () {
        goals.add(newGoal);
    };

    public shared query func getGoals() : async [Text] {
        return Buffer.toArray(goals);
    };
};
