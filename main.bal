import ballerinax/mysql.driver as _;
import ballerina/sql;
import ballerinax/mysql;
import ballerina/http;
// import ballerina/io;

type Catelog record {
    int item_id;
    string title;
    string desc;
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


service / on new http:Listener(9000) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new ("localhost", "root", "root", "siva_db", 3306);
    }

    // function get catalog() from the catalog table and return json
    resource function get catalog() returns json|error {
        // Execute the query and get the result as a stream.
        stream<record{}, error> resultStream = self.db->query("SELECT * FROM catalog");
        // Convert the stream to a table.
        table<record{}> tbl = check resultStream.toTable();
        // Convert the table to a json.
        json jsonPayload = tbl.toJson();
        return jsonPayload;
    }
}