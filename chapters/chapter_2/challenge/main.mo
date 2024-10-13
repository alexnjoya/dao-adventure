bimport Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
actor class DAO() = this {

    public type Member = {
        name : Text;
        age : Nat;
    };
    
    public type Result<A, B> = Result.Result<A, B>;
    public type HashMap<A, B> = HashMap.HashMap<A, B>;

    let map : HashMap<Principal, Member> = HashMap.HashMap<Principal, Member>(1, Principal.equal, Principal.hash);

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        switch(map.get(caller)) {
            case(?member) {
                return #err("Member had already been registered.");
            };
            case(null) {
                map.put(caller, member);
                return #ok(());
            };
        };

    };

    public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {
        switch(map.get(caller)) {
            case(?member) {
                ignore map.replace(caller, member);
                return #ok(());
            };
            case(null) {
                return #err("There's no member registered with the caller")
            };
        };
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        switch(map.get(caller)) {
            case(?member) {
                map.delete(caller);
                return #ok(());
            };
            case(null) {
                return #err("No member correlated with the caller");
            };
        };
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        switch(map.get(p)) {
            case(?member) {
                return #ok(member);
            };
            case(null) {
                return #err("No member with that principal");
            };
        };
    };

    public query func getAllMembers() : async [Member] {
        var arrayMember = Buffer.Buffer<Member>(0);
        for (value in map.vals()) {
            arrayMember.add(value);
        };
        return Buffer.toArray(arrayMember);
    };

    public query func numberOfMembers() : async Nat {
        return map.size();
    };

};
