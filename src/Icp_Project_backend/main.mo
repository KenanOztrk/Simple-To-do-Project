import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Trie "mo:base/Trie";
import Option "mo:base/Option";
import Types "Types";

actor {
  let ic : Types.IC = actor ("aaaaa-aa");
  type Id = Nat32;

  type Movies_cart = {
    addMovie: Types.MovieList;
  };

  private stable var next : Id = 0;
  private stable var cart : Trie.Trie<Id, Movies_cart> = Trie.empty();

  public func get_movies(movie_name: Types.MovieList) : async Text {
    var movie_value = "Avengers";
    switch(movie_name) {
      case(#Avengers) { movie_value := "Avengers" };
      case(#Batman) { movie_value := "Batman"};
      case(#IronMan) { movie_value := "IronMan"};
      case(#SpiderMan) { movie_value := "SpiderMan"};
      case(#Superman) { movie_value := "Superman"};
    };


    let host : Text = "api.themoviedb.org";
    let apikey : Text = "5a92be248396737f4d7a9cf321f6499c";
    let url = "https://" # host # "/3/search/movie?api_key=" # apikey # "&query=" # movie_value # "";
    let request_headers = [
        { name = "Host"; value = host },
        { name = "User-Agent"; value = "exchange_rate_canister" },
    ];

    let http_request : Types.HttpRequestArgs = {
        url = url;
        headers = request_headers;
        body = null; // İsteğe bağlı
        method = #get;
    };

    Cycles.add(20_949_972_000);

    let http_response : Types.HttpResponsePayload = await ic.http_request(http_request);

    let response_body: Blob = Blob.fromArray(http_response.body);
    let decoded_text: Text = switch (Text.decodeUtf8(response_body)) {
        case (null) { "No value returned" };
        case (?y) { y };
    };

    decoded_text
  };

  public func add_cart(movie_cart: Movies_cart) : async Id {
    let id = next;
    next += 1;
    cart := Trie.replace(
      cart,
      key(id),
      Nat32.equal,
      ?movie_cart,
    ).0;
    return id;
  };

  public query func read(id : Id) : async ? Movies_cart {
    let result = Trie.find(cart, key(id), Nat32.equal);
    return result;
  };

  public func deleteCart(id: Id) : async Bool{
    let result = Trie.find(cart, key(id), Nat32.equal);
    let exists = Option.isSome(result); 
    if (exists) {
      cart := Trie.replace(
        cart,
        key(id),
        Nat32.equal,
        null
      ).0;
    };

    exists
  };

  private func key(x : Id) : Trie.Key<Id> {
    return { hash = x; key = x };
  };

}