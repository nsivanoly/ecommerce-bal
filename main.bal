import ballerinax/mysql.driver as _;
import ballerina/sql;
import ballerinax/mysql;
import ballerina/io;
import ballerina/http;

type Catelog record {
    int item_id;
    string title;
    string desc;
    string includes;
    string intended_for;
    string color;
    string material;
    string img_url;
    decimal unit_price;
};

type Favorite record {
    int item_id;
    int user_id;
};

type Order record {
    int order_id;
    int user_id;
    decimal shipping_rate;
    decimal tax;
    decimal total;
};

type OrderItem record {
    int order_id;
    int item_id;
    int qty;
    decimal unit_price;
    decimal total;
};

type Cart record {
    int item_id;
    int user_id;
    int qty;
    decimal unit_price;
    decimal total;
};

type Card record {
    int user_id;
    string card_number;
};


service /petstore on new http:Listener(8888) {
    private final mysql:Client db;

    function init() returns error? {
        self.db = check new ("localhost", "root", "root", "siva_db", 3306);
    }
    
    resource function get catalog() returns Catelog[]|error {
        Catelog[] catalogs = [];
        stream<Catelog, sql:Error?> resultStream = self.db->query(`SELECT * FROM catalog`);

        check from Catelog catalog in resultStream
        do {
            catalogs.push(catalog);
        };
        check resultStream.close();
        return catalogs;
    }
}