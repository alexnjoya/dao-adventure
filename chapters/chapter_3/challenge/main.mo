import Result "mo:base/Result";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Types "types";
actor {

    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;

    var ledger : HashMap.HashMap<Principal, Nat> = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    let token : Text = "Orbit Token";
    let tokenTicker : Text = "ORT";

    public query func tokenName() : async Text {
        return token;
    };

    public query func tokenSymbol() : async Text {
        return tokenTicker;
    };

    public func mint(owner : Principal, amount : Nat) : async Result<(), Text> {
        let currentBalance = Option.get(ledger.get(owner), 0);
        ledger.put(owner, currentBalance + amount);
        #ok(());
    };

    public func burn(owner : Principal, amount : Nat) : async Result<(), Text> {
        let currentBalance = Option.get(ledger.get(owner), 0);
        if (currentBalance < amount) {
            return #err("Burn ammount exceeded available amount")
        };
        ledger.put(owner, currentBalance - amount);
        #ok(());
    };

    public shared ({ caller }) func transfer(from : Principal, to : Principal, amount : Nat) : async Result<(), Text> {
        let senderCurrentBalance = Option.get(ledger.get(from), 0);
        if (senderCurrentBalance < amount) {
            return #err("Send amount exceeded current balance")
        };
        let receiverCurrentBalance = Option.get(ledger.get(to), 0);
        ledger.put(from, senderCurrentBalance - amount);
        ledger.put(to, receiverCurrentBalance + amount);
        #ok(());
    };

    public query func balanceOf(account : Principal) : async Nat {
        let currentBalance = Option.get(ledger.get(account), 0);
        return currentBalance;
    };

    public query func totalSupply() : async Nat {
        var totalAvailableToken : Nat = 0;
        for (value in ledger.vals()) {
            totalAvailableToken += value
        };
        return totalAvailableToken;
    };

};