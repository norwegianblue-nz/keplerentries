{ "rules_update_custom_line_item" : {
    "LABEL" : "Update Custom Line Item",
    "PLUGIN" : "reaction rule",
    "OWNER" : "rules",
    "TAGS" : [ "norwegian blue" ],
    "REQUIRES" : [ "rules", "commerce_line_item", "commerce_product_reference" ],
    "ON" : { "commerce_product_calculate_sell_price" : [] },
    "IF" : [
      { "entity_has_field" : { "entity" : [ "commerce-line-item" ], "field" : "field_payment_amount" } }
    ],
    "DO" : [
      { "data_calc" : {
          "USING" : {
            "input_1" : [ "commerce-line-item:field-payment-amount" ],
            "op" : "*",
            "input_2" : "100"
          },
          "PROVIDE" : { "result" : { "payment_dollars" : "Payment_Amount_Dollars" } }
        }
      },
      { "commerce_line_item_unit_price_amount" : {
          "commerce_line_item" : [ "commerce_line_item" ],
          "amount" : [ "payment-dollars" ],
          "component_name" : "base_price",
          "round_mode" : "0"
        }
      }
    ]
  }
}
