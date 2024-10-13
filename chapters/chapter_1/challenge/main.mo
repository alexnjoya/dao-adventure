import Buffer "mo:base/Buffer";

actor class DAO() {
    let name : Text = "Token DAO";
    var manifesto : Text = "To create a decentralized hub where every individual has the power to influence, innovate, and drive the future of governance and technology, free from centralized control and bureaucratic limitations.";
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
